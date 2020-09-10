import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_watch/providers/cart.dart';

class BuyButtonWidget extends StatefulWidget {
  final String id;
  final String brand;
  final String name;
  final String price;

  BuyButtonWidget(this.id, this.brand, this.name, this.price);
  @override
  _BuyButtonWidgetState createState() => _BuyButtonWidgetState();
}

class _BuyButtonWidgetState extends State<BuyButtonWidget> {
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Cart>(context, listen: false);
    return Stack(
      children: [
        Container(
          height: 60,
          width: 200,
          decoration: BoxDecoration(
            color: Color(0xFFFFFAEB),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        GestureDetector(
          onTap: () {
            cart.addProduct(widget.id, widget.brand, widget.name, widget.price);
          },
          child: Container(
            height: 60,
            width: 80,
            child: Center(
                child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '\$89.99',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )),
            decoration: BoxDecoration(
              color: Colors.pink[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        Positioned(
            right: 15,
            top: 22,
            child: Text(
              'SWIPE TO BUY',
              style: TextStyle(
                  color: Colors.pink[300], fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}
