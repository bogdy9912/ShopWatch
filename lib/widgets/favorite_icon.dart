import 'package:flutter/material.dart';
import 'package:shop_watch/size_config.dart';

class FavoriteIcon extends StatefulWidget {
  bool favorite;

  FavoriteIcon({@required this.favorite});
  @override
  _FavoriteIconState createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
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
        IconButton(
          icon: Icon(
            widget.favorite ? Icons.favorite : Icons.favorite_border,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
