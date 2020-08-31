import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_watch/size_config.dart';

class FavoriteIcon extends StatefulWidget {
  bool favorite;
  final String id;

  FavoriteIcon({@required this.favorite, @required this.id});
  @override
  _FavoriteIconState createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  void toggleFav() async {
    var currUser = FirebaseAuth.instance.currentUser;
    try {
      await FirebaseFirestore.instance
          .collection('usersData')
          .doc('${currUser.uid}/favorites')
          .set(
        {
          '${widget.id}': !widget.favorite,
        },
      );
    } catch (err) {
      print(err);
    }

    setState(
      () {
        widget.favorite = !widget.favorite;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: SizeConfig.screenWidth * 0.135, // sau 50
          height: SizeConfig.screenWidth * 0.135, // sau 50
          decoration: BoxDecoration(
            color: widget.favorite ? Colors.pink[300] : Colors.grey[300],
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        Icon(
          widget.favorite ? Icons.favorite : Icons.favorite_border,
          color: Colors.white,
        ),
      ],
    );
  }
}
