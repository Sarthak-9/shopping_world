import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'file:///E:/Flutter/shopping_world/lib/providers/product.dart';
import 'package:shopping_world/providers/products_provider.dart';
import 'package:shopping_world/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFavs?productsData.favouriteItems:productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 10,
      ),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: products[i],
          child: ProductItem(
             // products[i].id, products[i].title, products[i].imageUrl)),
    ),),);
  }
}
