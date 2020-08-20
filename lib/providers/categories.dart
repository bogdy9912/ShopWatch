import 'package:flutter/material.dart';

class Categories with ChangeNotifier {
  List<String> _categories = [
    'ALL',
    'ROLEX',
    'HUBLOT',
    'OMEGA',
    'AUDERMARS PIGUET',
    'BRETLING',
    'JACOB&CO',
    'CLAUDE BERNARD'
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
