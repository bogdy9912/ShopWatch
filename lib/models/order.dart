import 'package:flutter/material.dart';
import 'package:shop_watch/providers/cart.dart';

class Order {
  final String id;
  final String amount;
  final List<CartItem> products;
  final String dateTime;

  Order({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}
