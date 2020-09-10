import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_watch/providers/cart.dart';
import 'package:shop_watch/widgets/quantity_widget_form.dart';

class CartItem extends StatefulWidget {
  final String id;
  final String brand;
  final String name;
  final String price;
  String quantity;

  CartItem({
    @required this.brand,
    @required this.id,
    @required this.name,
    @required this.price,
    @required this.quantity,
  });

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  void setQuantity(String quant) {
    setState(() {
      widget.quantity = quant;
      Provider.of<Cart>(context, listen: false).setQuant(widget.id, quant);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                Container(
                  height: 130,
                  width: 130,
                  child: Transform.rotate(
                      angle: pi / 5,
                      child: Image.asset(
                          'assets/images/Omega-De-Ville-Tourbillon-RMV.png')),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Text(
                  widget.brand,
                  style: TextStyle(color: Colors.grey[400], fontSize: 11),
                ),
                SizedBox(
                  height: 10,
                ),
                QuantityWidgetForm(setQuantity, widget.quantity),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
