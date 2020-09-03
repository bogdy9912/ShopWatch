import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_watch/screens/add_product_screen.dart';
import 'package:shop_watch/widgets/app_drawer.dart';
import 'package:shop_watch/widgets/item_list_user_products.dart';

class UserProducts extends StatelessWidget {
  static const routeName = '/user-products';

  final User user = FirebaseAuth.instance.currentUser;

  Future<void> productList() async {
    final productList = await FirebaseFirestore.instance
        .collection('watches')
        //.where('creatorId')
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My products'),
        elevation: 2,
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddProductScreen.routeName);
              })
        ],
      ),
      drawer: AppDrawer(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('watches')
            .where('creatorId', isEqualTo: user.uid)
            .snapshots(),
        builder: (ctx, futureSnapshot) {
          return futureSnapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  child: ListView.builder(
                      itemCount: futureSnapshot.data.documents.length,
                      itemBuilder: (ctx, index) {
                        final doc = futureSnapshot.data.documents;
                        return ItemListUserProducts(
                          productId: doc[index].get('id'),
                          productName: doc[index].get('name'),
                          productBrand: doc[index].get('brand'),
                          imageURL: doc[index].get('image'),
                        );
                      }),
                  onRefresh: productList,
                );
        },
      ),
    );
  }
}
