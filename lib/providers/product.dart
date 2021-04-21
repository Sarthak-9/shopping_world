import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product({@required this.id,@required this.title,@required this.description,@required this.price,@required this.imageUrl,
      this.isFavourite=false});
  Future<void> toggleFavouriteStatus(String token) async{
    final oldstatus =isFavourite;
    isFavourite=!isFavourite;
    notifyListeners();
    try{
      final url =
          'https://shopping-world-e9574-default-rtdb.firebaseio.com/products/$id.json';
      final response = await http.patch(url,body: json.encode({'isFavourite': isFavourite}));
      if(response.statusCode>=400){
        isFavourite=oldstatus;
        notifyListeners();
      }
    }
     catch(error){
       isFavourite=oldstatus;
       notifyListeners();
     }

}}