import 'package:flutter/material.dart';

class AppTheme {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    canvasColor: Colors.black,
    backgroundColor: Color(0xFF121212),
    primaryColor: Colors.green,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    canvasColor: Colors.white, //Color(0xFFB0B3B8)
    backgroundColor: Colors.white,
    primaryColor: Colors.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
  );
}
