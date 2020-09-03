import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_watch/providers/categories.dart';
import 'package:shop_watch/screens/add_product_screen.dart';
import 'package:shop_watch/screens/home_screen.dart';
import 'package:shop_watch/size_config.dart';
import 'package:shop_watch/forms/add_product_form.dart';
import 'package:shop_watch/widgets/app_drawer.dart';
import 'package:shop_watch/widgets/badge.dart';
import 'package:shop_watch/widgets/custom_tab_view.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs-screen';
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  var _selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
      drawer: AppDrawer(),
      body: CustomTabView(
        initPosition: _selectedPageIndex,
        itemCount: categories.categoriesCount,
        tabBuilder: (ctx, index) => Tab(
          text: categories.categories[index],
        ),
        pageBuilder: (ctx, index) => HomeScreen(
          selectedTab: categories.categories[index],
        ),
      ),
    );
  }
}
