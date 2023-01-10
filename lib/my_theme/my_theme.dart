import 'package:flutter/material.dart';

class MyTheme {
  static const Color lightPrimary = Color(0xFF5D9CEC);
  static const Color darkPrimary = Color(0xFF060E1E);
  static const Color itemDarkColor = Color(0xFF141922);
  static const Color colorGrey = Color(0xFFC8C9CB);
  static const Color colorWhite = Color(0xFFFFFFFF);
  static const Color colorGreen = Color(0xFF61E757);
  static const Color lightScaffoldBackground = Color(0xFFDFECDB);
  static const Color darkScaffoldBackground = Color(0xFF060E1E);

  static final lightTheme = ThemeData(
      primaryColor: lightPrimary,
      appBarTheme: const AppBarTheme(color: lightPrimary),
      scaffoldBackgroundColor: lightScaffoldBackground,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        selectedIconTheme: IconThemeData(
          color: lightPrimary,
          size: 36,
        ),
        unselectedIconTheme: IconThemeData(
          color: colorGrey,
          size: 36,
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(18),
            topLeft: Radius.circular(18),
          ),
        ),
      ),
      textTheme: const TextTheme(
          headline5: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          headline6: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)));
  static final darkTheme = ThemeData(
    primaryColor: lightPrimary,
    appBarTheme: const AppBarTheme(color: lightPrimary),
    scaffoldBackgroundColor: darkScaffoldBackground,
    bottomAppBarTheme: const BottomAppBarTheme(
      color: itemDarkColor,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      selectedIconTheme: IconThemeData(
        color: lightPrimary,
        size: 36,
      ),
      unselectedIconTheme: IconThemeData(
        color: colorGrey,
        size: 36,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: itemDarkColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(18),
          topLeft: Radius.circular(18),
        ),
      ),
    ),
    textTheme: const TextTheme(
        headline5: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: colorWhite),
        headline6: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: colorWhite)),
    iconTheme: const IconThemeData(color: colorWhite),
  );
}
