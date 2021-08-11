import 'package:flutter/foundation.dart';
import 'package:shop/data/product_dummy.dart';
import 'package:shop/models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _items = ProductDummy().getAll();

  List<Product> get items => [..._items];

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    _items.remove(product);
    notifyListeners();
  }
}
