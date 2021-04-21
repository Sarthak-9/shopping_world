import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_world/providers/products_provider.dart';
import 'package:shopping_world/widgets/app_drawer.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;
  // final double price;

  // ProductDetailScreen(this.title, this.price);
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    // final productId =
    // ModalRoute.of(context).settings.arguments as String; // is the id!
    // final loadedProduct = Provider.of<Products>(
    //   context,
    //   listen: false,
    // ).findById(productId);
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<Products>(context).findById(productId);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(loadedProduct.title),
      // ),
      //drawer: AppDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(loadedProduct.title),
              background: Hero(
                tag: loadedProduct.id,
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(delegate: SliverChildListDelegate(
            [
              SizedBox(
                height: 10,
              ),
              Text(
                'INR ${loadedProduct.price}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(loadedProduct.description),
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
              ),
              SizedBox(
                height: 1000,
              ),
            ]
          )),
        ],
        // child: Column(
        //   children: [
        //     Container(
        //       padding: EdgeInsets.all(8.0),
        //       height: 300,
        //       width: double.infinity,
        //       child:
        //     ),
        //
        //   ],
        ),
      //),
    );
  }
}


