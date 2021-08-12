import 'package:flutter/material.dart';
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
                print('ProductOverViewScreen $_showFavoriteOnly');
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
        ],
      ),
      body: ProductGrid(this._showFavoriteOnly),
    );
  }
}
