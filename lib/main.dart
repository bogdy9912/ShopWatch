import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_watch/providers/categories.dart';
import 'package:shop_watch/screens/home_screen.dart';
import 'package:shop_watch/screens/tabs_screen.dart';
import 'package:shop_watch/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Categories(),
      child: MaterialApp(
        title: 'ShopWatch',
        theme: buildThemeData(context),
        home: TabsScreen(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ShopWatch'),
      ),
      body: Center(),
    );
  }
}
