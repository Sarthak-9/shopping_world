import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_world/providers/cart.dart';
import 'package:shopping_world/providers/product.dart';
import 'package:shopping_world/providers/products_provider.dart';
import 'package:shopping_world/screens/product_detail_screen.dart';
import '../providers/auth.dart';
class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  //
  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    final scaffold =Scaffold.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
            // Navigator.of(context).push(
            //     MaterialPageRoute(builder: (ctx) => ProductDetailScreen(),),);
          },
          child: Hero(
            tag: product.id,
            child: FadeInImage(
              placeholder: AssetImage('assets/images/product-placeholder.png'),
              image: NetworkImage(
                product.imageUrl,),
                fit: BoxFit.cover,

            ),
          ),
        ),
        footer: GridTileBar(
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          leading: Consumer<Product>(
            builder: (ctx, product, child) => IconButton(
              icon: Icon(product.isFavourite
                  ? Icons.favorite
                  : Icons.favorite_border_rounded),
              //onPressed: ()=>pproduct.favouriteProduct(product.id),
              // onPressed: () async {
              //   try {
              //     await Provider.of<Products>(context, listen: false)
              //         .favouriteProduct(product.id);
              //   } catch (error) {
              //     scaffold.showSnackBar(
              //       SnackBar(
              //         content: Text(
              //           'Can\'t add to Favourites',
              //           textAlign: TextAlign.center,
              //         ),
              //       ),
              //     );
              //   }
              // },
                  //() {
                //pproduct.favouriteItems(product.id);
                onPressed:(){product.toggleFavouriteStatus(authData.token);}
             // },
            ),
          ),
          backgroundColor: Colors.black54,
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart_rounded),
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(content: Text('Item added to Cart'),
                duration: Duration(seconds: 1),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: (){
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
