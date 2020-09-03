import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_watch/screens/add_product_screen.dart';

class ItemListUserProducts extends StatelessWidget {
  final String productId;
  final String productBrand;
  final String productName;
  final String imageURL;
  ItemListUserProducts(
      {this.productId, this.imageURL, this.productBrand, this.productName});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${productBrand}'),
      subtitle: Text('${productName}'),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageURL),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () async {
                final product = await FirebaseFirestore.instance
                    .collection('watches')
                    .doc(productId)
                    .get();
                print(product.data());
                Navigator.of(context).pushNamed(AddProductScreen.routeName,
                    arguments: product.data());
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete_outline,
                color: Colors.red,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
