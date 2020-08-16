import 'package:flutter/material.dart';
import 'package:shop_watch/providers/categories.dart';
import 'package:shop_watch/widgets/badge.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var categories = Provider.of<Categories>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Discover',
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          Badge(
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {},
            ),
            value: '0',
          ),
        ],
      ),
      drawer: Drawer(),
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: ListView.builder(
              itemCount: categories.categoriesCount,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) => Container(
                child: Text(categories.categories[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
