import 'package:flutter/material.dart';

class ImageSplashHolder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 100,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          //border: Border.all(width: 1),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 7,
                spreadRadius: 1,
                offset: Offset(0, 3)),
          ]),
      child: Center(
        child: IconButton(
          icon: Icon(Icons.add_circle_outline),
          color: Colors.grey,
          onPressed: () {},
        ),
      ),
    );
  }
}
