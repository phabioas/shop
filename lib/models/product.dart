import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  late String? id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void toogleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
