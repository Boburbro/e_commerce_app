import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final double price;
  final String des;
  final String imgUrl;
  bool isFavorite;
  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.des,
    required this.imgUrl,
    this.isFavorite = false,
  });

  void changeFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
