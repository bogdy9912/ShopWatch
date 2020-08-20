import 'package:flutter/material.dart';
import 'package:shop_watch/models/product.dart';

class Products with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products {
    return [..._products];
  }

  int get productsCount {
    return _products.length;
  }

  void addProducts(Product newProduct) {
    _products.add(newProduct);
    notifyListeners();
  }
}
