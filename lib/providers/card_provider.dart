// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  // ignore: unused_field
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addNewCartItem(
    String proId,
    String title,
    String imgUrl,
    double price,
  ) {
    if (_items.containsKey(proId)) {
      //soni ko'paytradi

      _items.update(
        proId,
        (value) => CartItem(
          id: value.id,
          title: value.title,
          imgUrl: value.imgUrl,
          quantity: value.quantity + 1,
          price: value.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        proId,
        () => CartItem(
          id: UniqueKey().toString(),
          title: title,
          imgUrl: imgUrl,
          quantity: 1,
          price: price,
        ),
      );
    }
    notifyListeners();
  }

  void removeSingleItem(String productId, {bool isCartButton = false}) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (value) => CartItem(
          id: value.id,
          title: value.title,
          imgUrl: value.imgUrl,
          quantity: value.quantity - 1,
          price: value.price,
        ),
      );
      notifyListeners();
    }
    else if (isCartButton) {
      removeItem(productId);
    }
  }

  double get totalPrice {
    var total = 0.0;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void removeItem(pId) {
    _items.removeWhere((key, value) => key == pId);
    notifyListeners();
  }

  void clearItems() {
    _items.clear();
    notifyListeners();
  }
}
