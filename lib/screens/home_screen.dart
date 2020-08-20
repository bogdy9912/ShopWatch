import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_watch/providers/categories.dart';
import 'package:shop_watch/widgets/item_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_watch/widgets/list_view_home.dart';

class HomeScreen extends StatefulWidget {
  String selectedTab;

  HomeScreen({this.selectedTab});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var _currentPageIndex = 1;

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              RotatedBox(
                quarterTurns: 3,
                child: SizedBox(
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: DefaultTabController(
                      initialIndex: _currentPageIndex,
                      length: 3,
                      child: TabBar(
                        indicatorColor: Colors.white,
                        labelColor: Theme.of(context).primaryColor,
                        unselectedLabelColor: Colors.grey[400],
                        tabs: <Widget>[
                          Tab(
                            child: FittedBox(
                                child: Text(
                              'Upcoming',
                              style: TextStyle(fontSize: 12),
                            )),
                          ),
                          Tab(
                            child: FittedBox(
                                child: Text(
                              'Recomended',
                              style: TextStyle(fontSize: 12),
                            )),
                          ),
                          Tab(
                            child: FittedBox(
                                child: Text(
                              'New',
                              style: TextStyle(fontSize: 12),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ListViewHome(
                  height: 250, width: 300, selectedBrand: widget.selectedTab),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              Text(
                'Discounted',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {},
              )
            ],
          ),
          ListViewHome(
              height: 150, width: 300, selectedBrand: widget.selectedTab),
          Row(
            children: [
              SizedBox(
                width: 15,
              ),
              Text(
                'More',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {},
              )
            ],
          ),
          ListViewHome(
              height: 130, width: 300, selectedBrand: widget.selectedTab),
        ],
      ),
    );
  }
}
