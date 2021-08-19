import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shop/data/product_dummy.dart';
import 'package:shop/models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _items = ProductDummy().getAll();

  List<Product> get items => [..._items];

  List<Product> get favoriteitems =>
      _items.where((prod) => prod.isFavorite).toList();

  // bool _showFavoriteOnly = false;

  // List<Product> get items {
  //   if (this._showFavoriteOnly) {
  //     return _items.where((prod) => prod.isFavorite).toList();
  //   }

  //   return [..._items];
  // }

  // void showFavoriteOnly() {
  //   _showFavoriteOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoriteOnly = false;
  //   notifyListeners();
  // }

  void addProduct(Product newProduct) {
    newProduct.id = Random().nextDouble().toString();
    _items.add(newProduct);
    notifyListeners();
  }

  void updateProduct(Product product) {
    if (product.id == null || product.id!.isEmpty) {
      return;
    }

    final index = _items.indexWhere((element) => element.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void removeProduct(Product product) {
    final index = _items.indexWhere((element) => element.id == product.id);

    if (index >= 0) {
      _items.remove(product);
      notifyListeners();
    }
  }
}
