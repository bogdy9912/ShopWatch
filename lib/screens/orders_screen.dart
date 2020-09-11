import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shop_watch/models/order.dart';
import 'package:shop_watch/providers/cart.dart';
import 'package:shop_watch/widgets/app_drawer.dart';
import 'package:shop_watch/widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
        backgroundColor: Theme.of(context).primaryColor,
        textTheme: TextTheme(
          headline6: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actionsIconTheme: IconTheme.of(context).copyWith(color: Colors.white),
        iconTheme: IconTheme.of(context).copyWith(color: Colors.white),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('orders').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.error != null) {
            return Center(
              child: Text('err'),
            );
          } else
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return OrderItem(
                  Order(
                    id: snapshot.data.documents[index].id,
                    amount: snapshot.data.documents[index].data()['total'],
                    dateTime: snapshot.data.documents[index].data()['dateTime'],
                    products: (snapshot.data.documents[index].data()['items']
                            as List<dynamic>)
                        .map(
                          (e) => CartItem(
                            id: e['id'],
                            brand: e['brand'],
                            name: e['name'],
                            price: e['price'],
                            quantity: e['quantity'],
                          ),
                        )
                        .toList(),
                  ),
                );
              },
            );
        },
      ),
    );
  }
}
