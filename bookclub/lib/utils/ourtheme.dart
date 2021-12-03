import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class OurTheme {
  Color _lightGreen = Colors.green.shade100;
  Color __lightGrey = Colors.grey.shade300;
  Color __darkGrey = Colors.grey.shade600;

  ThemeData buildTheme() {
    return ThemeData(
      canvasColor: Colors.white,
      primaryColor: _lightGreen,
      accentColor: __lightGrey,
      secondaryHeaderColor: __darkGrey,
      hintColor: __lightGrey,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: __lightGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: _lightGreen),
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: __darkGrey,
        padding: EdgeInsets.symmetric(horizontal: 20),
        minWidth: 200,
        height: 40,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
