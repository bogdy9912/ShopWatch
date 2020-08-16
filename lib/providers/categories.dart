import 'package:flutter/material.dart';

class Categories with ChangeNotifier {
  List<String> _categories = [
    'Rolex',
    'Hublot',
    'Audermars Piguet',
    'Bretling',
    'Jacob&Co',
    'Claude Bernard'
  ];

  List<String> get categories {
    return [..._categories];
  }

  int get categoriesCount {
    return _categories.length;
  }

  void addCategory(String newCategory) {
    _categories.add(newCategory);
    notifyListeners();
  }
}
