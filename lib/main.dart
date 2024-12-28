import 'package:e_commerce_app/screens/edit_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../style/them.dart';

import '../screens/manage_product.dart';
import '../screens/order_screen.dart';
import '../screens/home.dart';
import '../screens/product_detals.dart';
import '../screens/cart_screen.dart';

import '../providers/products.dart';
import '../providers/card_provider.dart';
import '../providers/order_provider.dart';

void main(List<String> args) {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});

  ThemeData them = MyTheme.them;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Products>(create: (ctx) => Products()),
        ChangeNotifierProvider<CartProvider>(create: (ctx) => CartProvider()),
        ChangeNotifierProvider<OrderProvider>(create: (ctx) => OrderProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: them,
        initialRoute: "/",
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          ProductDetals.routeName: (context) => const ProductDetals(),
          CartScreen.routeName: (context) => const CartScreen(),
          OrderScreen.routeName: (context) => const OrderScreen(),
          ManageProduct.routeName: (context) => const ManageProduct(),
          EditProduct.routeName: (context) => const EditProduct(),
        },
      ),
    );
  }
}
