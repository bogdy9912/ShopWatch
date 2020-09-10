import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_watch/models/product.dart';
import 'package:shop_watch/widgets/item_home.dart';
import 'package:shop_watch/widgets/splash_item.dart';

class ListViewHome extends StatelessWidget {
  final double width;
  final double height;
  String selectedBrand;

  ListViewHome({
    @required this.height,
    @required this.width,
    this.selectedBrand,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: StreamBuilder(
          stream: selectedBrand == 'ALL'
              ? FirebaseFirestore.instance.collection('watches').snapshots()
              : FirebaseFirestore.instance
                  .collection('watches')
                  .where('brand', isEqualTo: selectedBrand)
                  .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Row(
                children: [
                  SplashItem(),
                ],
              );
            }
            final doc = snapshot.data.documents;
            print(doc);
            return ListView.builder(
              itemCount: doc.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => FittedBox(
                child: Padding(
                  padding: const EdgeInsets.only(right: 40.0),
                  child: ItemHome(
                    id: doc[index].get('id'),
                    brand: doc[index].get('brand'),
                    name: doc[index].get('name'),
                    price: doc[index].get('price'),
                    description: doc[index].get('description'),
                    // color: doc[index].get('color'),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
