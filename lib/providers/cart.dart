import 'package:flutter/cupertino.dart';

class CartItem {
  final String id;
  final String brand;
  final String name;
  String quantity;
  String price;

  CartItem({this.id, this.brand, this.name, this.price, this.quantity});

  void setQ(String q) {
    quantity = q;
  }
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void setQuant(String prodId, String q) {
    _items.update(
        prodId,
        (value) => CartItem(
            id: prodId,
            brand: value.brand,
            name: value.name,
            price: value.price,
            quantity: q));
    notifyListeners();
  }

  int get itemCount {
    return _items.length;
  }

  String addQuantity(CartItem cartItem) {
    var man = int.parse(cartItem.quantity) + 1;
    notifyListeners();
    return man.toString();
  }

  bool get isEmpty {
    return _items.isEmpty;
  }

  void addProduct(String id, String brand, String name, String price) {
    if (_items.containsKey(id)) {
      _items.update(
        id,
        (value) => CartItem(
          id: value.id,
          brand: value.brand,
          name: value.name,
          price: value.price,
          quantity: addQuantity(value),
        ),
      );
    } else {
      _items.putIfAbsent(
          id,
          () => CartItem(
                id: id,
                brand: brand,
                name: name,
                price: price,
                quantity: '1',
              ));
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  String totalAmount() {
    var sum = 0.0;
    _items.forEach((key, value) {
      sum += double.parse(value.price) * double.parse(value.quantity);
    });
    return sum.toString();
  }
}
