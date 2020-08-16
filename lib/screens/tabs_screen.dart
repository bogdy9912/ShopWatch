import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_watch/providers/categories.dart';
import 'package:shop_watch/widgets/badge.dart';
import 'package:shop_watch/widgets/custom_tab_view.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  var _selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    var categories = Provider.of<Categories>(context);
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
      body: CustomTabView(
        initPosition: _selectedPageIndex,
        itemCount: categories.categoriesCount,
        tabBuilder: (ctx, index) => Tab(
          text: categories.categories[index],
        ),
        pageBuilder: (ctx, index) => Center(
          child: Text(categories.categories[index]),
        ),
      ),
    );
  }
}
