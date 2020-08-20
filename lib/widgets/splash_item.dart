import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

class SplashItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Container(
          width: 190,
          height: 250,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Positioned(
          top: 10.0,
          left: 20.0,
          child: SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(),
          ),
        ),
        Positioned(
          top: 30.0,
          left: 20.0,
          child: SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(),
          ),
        ),
        Positioned(
          top: 70.0,
          left: 20.0,
          child: SizedBox(
            width: 30,
            height: 30,
            child: CircularProgressIndicator(),
          ),
        ),
        Positioned(
          bottom: 10.0,
          right: 10.0,
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          bottom: 30.0,
          right: -60.0,
          child: Container(
            width: 200,
            height: 210,
            child: Image.asset('assets/images/splah-watch.png'),
          ),
        ),
      ],
    );
  }
}
