import 'dart:io';
import 'package:flutter/cupertino.dart';

enum Bracelet {
  leather,
  steel,
}
enum WatchType { mechanical, automatic }
enum WatchGender { man, women, universal }

class Product {
  final String id;
  final String name;
  final String brand;
  bool isNew;
  double price;
  int quantity;
  bool isDiscounted;
  final String description;
  Bracelet bracelet;
  WatchGender gender;
  WatchType type;
  File image;
  bool isFavorite = false;

  Product({
    this.id,
    @required this.name,
    @required this.brand,
    @required this.price,
    @required this.description,
    this.image,
    this.isNew,
    this.gender,
    this.bracelet,
    this.isDiscounted,
    this.quantity,
    this.type,
  });
}
