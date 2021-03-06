import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart_provider.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:shop/widgets/badge.dart';
import 'package:shop/widgets/product_grid.dart';

class ProductOverViewScreen extends StatefulWidget {
  @override
  _ProductOverViewScreenState createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {
  bool _showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Loja'),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.menu),
            onSelected: (int selectValue) {
              setState(() {
                if (selectValue == 0) {
                  this._showFavoriteOnly = true;
                } else {
                  this._showFavoriteOnly = false;
                }
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Somente Favoritos'),
                value: 0,
              ),
              PopupMenuItem(
                child: Text('Todos'),
                value: 1,
              )
            ],
          ),
          Consumer<CartProvider>(
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed((AppRoute.cart));
              },
            ),
            builder: (_, cart, child) => Badge(
              value: cart.intCount.toString(),
              child: child!,
            ),
          ),
        ],
      ),
      body: ProductGrid(this._showFavoriteOnly),
      drawer: AppDrawer(),
    );
  }
}
