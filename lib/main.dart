import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_watch/providers/categories.dart';
import 'package:shop_watch/screens/add_product_screen.dart';
import 'package:shop_watch/screens/auth_screen.dart';
import 'package:shop_watch/screens/detail_product_screen.dart';
import 'package:shop_watch/screens/tabs_screen.dart';
import 'package:shop_watch/screens/user_products_screen.dart';
import 'package:shop_watch/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                return TabsScreen();
              } else {
                return AuthScreen();
              }
            }),
        routes: {
          DetailProductScreen.routeName: (ctx) => DetailProductScreen(),
          AddProductScreen.routeName: (ctx) => AddProductScreen(),
          UserProducts.routeName: (ctx) => UserProducts(),
          TabsScreen.routeName: (ctx) => TabsScreen()
        },
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
