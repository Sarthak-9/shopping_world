import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_world/providers/cart.dart';
import 'package:shopping_world/providers/orders.dart';
import 'package:shopping_world/screens/cart_screen.dart';
import 'package:shopping_world/screens/edit_product_screen.dart';
import 'package:shopping_world/screens/orders_screen.dart';
import 'package:shopping_world/screens/product_detail_screen.dart';
import 'package:shopping_world/screens/product_overview_screen.dart';
import 'package:shopping_world/screens/user_products_screen.dart';
import 'providers/products_provider.dart';
import 'screens/auth_screen.dart';
import 'providers/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (ctx, auth, previousProducts) => Products(
            auth.token,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (ctx, auth, previousOrders) => Orders(
            auth.token,
            auth.userId,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        ),
      ], //value:Products(),
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
            // Use create when creating a new instance
            debugShowCheckedModeBanner: false,
            title:
                'Shopping World', // and value when recycling the old as in ProductsGrid
            theme: ThemeData(
              primarySwatch: Colors.amber,
              fontFamily: 'Lato',
              accentColor: Colors.deepOrangeAccent,
            ),
            routes: {
              ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrdersScreen.routeName: (ctx) => OrdersScreen(),
              UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
              EditProductScreen.routeName: (ctx) => EditProductScreen(),
            },
            home: auth.isAuth
                ? ProductsOverviewScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? Container(
                          child: CircularProgressIndicator(),
                        )
                            : AuthScreen(),
                  )),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping World'),
      ),
      body: Center(
        child: Text('ABC'),
      ),
    );
  }
}
