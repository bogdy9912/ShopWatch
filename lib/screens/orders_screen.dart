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
            //print(snapshot.data.documents.length);
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                print(snapshot.data.documents[index].data()['amount']);
                return OrderItem(Order(
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
                ));
              },
            );
        },
      ),
    );
  }
}
