import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_watch/screens/add_product_screen.dart';
import 'package:shop_watch/screens/orders_screen.dart';
import 'package:shop_watch/screens/tabs_screen.dart';
import 'package:shop_watch/screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            title: Text('Hello there!'),
            automaticallyImplyLeading: false,
            elevation: 0,
          ),
          Spacer(),
          ListTile(
            leading: Icon(Icons.shopping_basket),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('My profile'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.storage),
            title: Text('My products'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProducts.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.add_box),
            title: Text('Add products'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AddProductScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {},
          ),
          Spacer(),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.grey[300],
            ),
            title: Text(
              'Logout',
              style: TextStyle(
                color: Colors.grey[400],
              ),
            ),
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}
