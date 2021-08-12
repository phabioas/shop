import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/product.dart';

class CartProvider with ChangeNotifier {
  late Map<String, CartItem> _items;

  Map<String, CartItem> get item {
    return {..._items};
  }

  void addItens(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (value) => CartItem(
          id: value.id,
          title: value.title,
          quantity: value.quantity + 1,
          price: value.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          id: Random().nextDouble().toString(),
          title: product.title,
          quantity: 1,
          price: product.price,
        ),
      );
    }

    notifyListeners();
  }
}
