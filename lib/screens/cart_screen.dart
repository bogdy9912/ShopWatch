import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_watch/providers/cart.dart';
import '../widgets/cart_item.dart' as Crt;

class CartScreen extends StatelessWidget {
  static const routeName = '/cart-screen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        actionsIconTheme: IconTheme.of(context).copyWith(color: Colors.white),
        iconTheme: IconTheme.of(context).copyWith(color: Colors.white),
        title: Text(
          'My Bag',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Total',
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                Chip(
                  label: Text('\$' + cart.totalAmount()),
                ),
                OrderButton(cart: cart),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cart.itemCount,
                itemBuilder: (ctx, index) => Crt.CartItem(
                  id: cart.items.values.toList()[index].id,
                  brand: cart.items.values.toList()[index].brand,
                  name: cart.items.values.toList()[index].name,
                  price: cart.items.values.toList()[index].price,
                  quantity: cart.items.values.toList()[index].quantity,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: widget.cart.isEmpty
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              try {
                FirebaseFirestore.instance.collection('orders').doc().set({
                  'total': widget.cart.totalAmount(),
                  'items': widget.cart.items.values
                      .toList()
                      .map((e) => {
                            'id': e.id,
                            'brand': e.brand,
                            'name': e.name,
                            'price': e.price,
                            'quantity': e.quantity,
                          })
                      .toList(),
                  'dateTime': DateTime.now().toIso8601String(),
                });

                setState(() {
                  _isLoading = false;
                });
                widget.cart.clear();
              } catch (errr) {
                print(errr);
              }
            },
      child: _isLoading ? CircularProgressIndicator() : Text('ORDER NOW'),
      textColor: Theme.of(context).primaryColor,
    );
  }
}
