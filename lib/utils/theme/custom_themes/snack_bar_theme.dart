import "package:flutter/material.dart";

class CCSnackBarTheme {
  CCSnackBarTheme._();

  static const SnackBarThemeData lightTheme = SnackBarThemeData(
    contentTextStyle: TextStyle(
        color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
  );

  static const SnackBarThemeData darkTheme = SnackBarThemeData();
}
