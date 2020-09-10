import 'package:flutter/material.dart';
import 'package:shop_watch/constants.dart';

ThemeData buildThemeData(BuildContext context) {
  return ThemeData(
    primaryColor: bogPrimaryColor,
    primarySwatch: MaterialColor(bogPrimaryColor.value, {
      50: Color(0xFFC4C0D8),
      100: Color(0xFF958DB9),
      200: Color(0xFF7267A2),
      300: Color(0xFF5F558B),
      400: Color(0xFF2C273F),
      500: bogPrimaryColor,
      600: Color(0xFF1A1826),
      700: Color(0xFF111019),
      800: Color(0xFF08080C),
      900: Color(0xFF08080C) // same as 800: because no more shades
    }),
    appBarTheme: AppBarTheme.of(context).copyWith(
      color: Colors.white,
      actionsIconTheme: IconTheme.of(context).copyWith(color: bogPrimaryColor),
      iconTheme: IconTheme.of(context).copyWith(color: bogPrimaryColor),
      textTheme: TextTheme(
        headline6: TextStyle(
            fontSize: 24, color: bogPrimaryColor, fontWeight: FontWeight.bold),
      ),
    ),

/*
    appBarTheme: AppBarTheme.of(context).copyWith(
      color: bogPrimaryColor,
      actionsIconTheme: IconTheme.of(context).copyWith(color: Colors.white),
      iconTheme: IconTheme.of(context).copyWith(color: Colors.white),
      textTheme: TextTheme(
        headline6: TextStyle(
            fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),*/
    scaffoldBackgroundColor: Colors.white,
    accentColor: bogSecondaryColor,
  );
}
