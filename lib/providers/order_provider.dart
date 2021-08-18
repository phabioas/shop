import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:shop/models/order.dart';

import 'cart_provider.dart';

class OrderProvider with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  void addOrder(CartProvider cart) {
    _orders.insert(
      0,
      Order(
        id: Random().nextDouble().toString(),
        total: cart.totalAmount,
        products: cart.items.values.toList(),
        date: DateTime.now(),
      ),
    );

    notifyListeners();
  }
}
