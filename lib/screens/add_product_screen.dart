import 'package:flutter/material.dart';
import 'package:shop_watch/forms/add_product_form.dart';
import 'package:shop_watch/widgets/app_drawer.dart';

class AddProductScreen extends StatelessWidget {
  static const routeName = '/add-product-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add product'),
      ),
      drawer: AppDrawer(),
      body: AddProductForm(),
    );
  }
}
