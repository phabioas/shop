import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart_provider.dart';
import 'package:shop/providers/order_provider.dart';
import 'package:shop/views/cart_screen.dart';
import 'package:shop/views/order_screen.dart';
import 'providers/products_provider.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/views/product_detail_screen.dart';
import 'package:shop/views/products_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderProvider(),
        ),
      ],
      child: MaterialApp(
        // debugShowCheckedModeBanner: false,
        title: 'Minha Loja',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        routes: {
          AppRoute.home: (ctx) => ProductOverViewScreen(),
          AppRoute.productDetail: (ctx) => ProductDetailScreen(),
          AppRoute.cart: (ctx) => CartScreen(),
          AppRoute.order: (ctx) => OrderScreen(),
        },
      ),
    );
  }
}
