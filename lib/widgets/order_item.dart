import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_watch/models/order.dart';

class OrderItem extends StatefulWidget {
  final Order order;
  OrderItem(this.order);
  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.order.amount,
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              widget.order.dateTime,
              style: TextStyle(color: Colors.white),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded) Divider(),
          SingleChildScrollView(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeIn,
              height: _expanded
                  ? min(widget.order.products.length * 50.0 + 30.0, 130)
                  : 0,
              //  width: _expanded ? 400 : 0,
              decoration: BoxDecoration(
                color: Colors.grey[300],
              ),
              child: ListView(
                children: widget.order.products
                    .map((e) => ListTile(
                          title: Text(e.name),
                          subtitle: Text(e.brand),
                          trailing: Text('X' + e.quantity),
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
