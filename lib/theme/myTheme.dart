

import 'dart:ui';

import 'package:flutter/material.dart';


bool? isDarkTheme ;
class MyTheme {

  static Color myMainTheme = Colors.deepOrange ;
  static ThemeData darkTheme = ThemeData(
    colorSchemeSeed:myMainTheme ,
    brightness: Brightness.dark,
    useMaterial3: true,
  );
  static ThemeData lightTheme = ThemeData(
    colorSchemeSeed:myMainTheme ,
    useMaterial3: true,
  );
}