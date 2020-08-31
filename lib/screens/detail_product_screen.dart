import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_watch/size_config.dart';
import 'package:shop_watch/widgets/favorite_icon.dart';

class DetailProductScreen extends StatefulWidget {
  static const routeName = '/detail-product-screen';
  /*
  final String name;
  final String brand;
  double price;
  final String description;*/
/*
  DetailProductScreen({
    @required this.name,
    @required this.brand,
    @required this.description,
    this.price,
  });
*/
  @override
  _DetailProductScreenState createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  /*
    Future<bool> fetchFavoriteStatus() async {
      var currUser = await FirebaseAuth.instance.currentUser;
      var currUserFav = await FirebaseFirestore.instance
          .collection('usersData')
          .doc('${currUser.uid}/favorites')
          .get();
      if (currUserFav == null)
        return false;
      else if (currUserFav.get('${arg['id']}') == null)
        return false;
      else
        return true;
    }
*/
  var arg;
  bool isa = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print(isa);
    if (isa == false) {
      print('La multi ani');
      arg = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      setState(() {
        isa = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(arg);
    //   arg = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    SizeConfig().init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          arg['brand'],
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        //overflow: Overflow.visible,
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.grey,
          ),
          Positioned(
            top: AppBar().preferredSize.height,
            child: SizedBox(
              height: SizeConfig.screenHeight * 0.35,
              child: Image.asset(
                  'assets/images/Omega-De-Ville-Tourbillon-RMV.png'),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: SizeConfig.screenHeight * 0.55,
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
          ),
          Positioned(
            top: SizeConfig.screenHeight * 0.42,
            right: SizeConfig.screenWidth * 0.1,
            child: GestureDetector(
              child: FavoriteIcon(
                id: arg['id'],
                favorite: arg['favStatus'],
              ),
              onTap: () async {
                var currUser = FirebaseAuth.instance.currentUser;

                setState(() {
                  arg['favStatus'] = !arg['favStatus'];
                });

                print(arg);
                try {
                  await FirebaseFirestore.instance
                      .collection('usersData/${currUser.uid}/fav')
                      .doc('${arg['id']}')
                      .set(
                    {
                      'value': arg['favStatus'],
                    },
                  );
                } on PlatformException catch (err) {
                  print(err.message);
                } catch (error) {
                  print('err');
                }
              },
            ),
          ),
          Positioned(
            left: SizeConfig.screenWidth * 0.1,
            top: SizeConfig.screenHeight * 0.55,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  arg['brand'],
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  arg['name'],
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.05,
                ),
                Container(
                  height: SizeConfig.screenHeight * 0.115,
                  width: SizeConfig.screenWidth * 0.8,
                  child: SingleChildScrollView(
                    child: Text(
                      arg['description'],
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.05,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                  ),
                  child: Text(
                    'MORE DETAILS',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Switch(
              value: true,
              onChanged: (_) {},
            ),
          ),
        ],
      ),
    );
  }
}
