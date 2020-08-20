import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_watch/screens/detail_product_screen.dart';

class ItemHome extends StatelessWidget {
  final String brand;
  final String name;
  final double price;
  final String id;
  final String description;

  ItemHome({
    @required this.id,
    @required this.brand,
    @required this.name,
    @required this.price,
    @required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        DetailProductScreen.routeName,
        arguments: {
          'id': id,
          'name': name,
          'price': price,
          'description': description,
          'brand': brand
        },
      ),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            width: 190,
            height: 250,
            decoration: BoxDecoration(
              color: Colors.deepOrange[200],
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Positioned(
            top: 10.0,
            left: 20.0,
            child: SizedBox(
              width: 70,
              child: Text(
                brand,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Positioned(
            top: 30.0,
            left: 20.0,
            child: SizedBox(
                width: 70,
                child: Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )),
          ),
          Positioned(
            top: 70.0,
            left: 20.0,
            child: SizedBox(
                width: 70,
                child: Text(
                  '\$$price',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )),
          ),
          Positioned(
            bottom: 30.0,
            right: -60.0,
            child: Container(
              width: 200,
              height: 210,
              child: Transform.rotate(
                angle: pi / 5,
                child: Image.asset(
                    'assets/images/Omega-De-Ville-Tourbillon-RMV.png'),
              ),
            ),
          ),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  DetailProductScreen.routeName,
                  arguments: {
                    'id': id,
                  },
                );
              },
              icon: Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
