import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_world/providers/cart.dart';
import 'package:shopping_world/providers/products_provider.dart';
import 'package:shopping_world/screens/cart_screen.dart';
import 'package:shopping_world/widgets/app_drawer.dart';
import 'file:///E:/Flutter/shopping_world/lib/providers/product.dart';
import 'package:shopping_world/widgets/product_item.dart';
import 'package:shopping_world/widgets/products_gird.dart';
import '../widgets/badge.dart';
enum FilterOptions{
  Favourites,All,
}

class ProductsOverviewScreen extends StatefulWidget {

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showOnlyFavourites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(_isInit){
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProduct().then((_) {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final productsContainer = Provider.of<Products>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping World'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue){
                setState(() {
                  if(selectedValue==FilterOptions.Favourites){
                    _showOnlyFavourites=true;
                  }
                  else{
                    _showOnlyFavourites=false;
                  }
                });
            },
            icon: Icon(Icons.more_vert_rounded),
            itemBuilder: (_)=>[
              PopupMenuItem(child: Text('Only Favourites',),value: FilterOptions.Favourites,),
              PopupMenuItem(child: Text('Show All',),value: FilterOptions.All,),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart,ch)=> Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart_rounded,
              ),
              onPressed: (){
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading? Center(child: CircularProgressIndicator(),):ProductsGrid(_showOnlyFavourites),
    );
  }
}

