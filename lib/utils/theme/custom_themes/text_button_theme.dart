import "package:cubik_club/utils/constants/colors.dart";
import "package:flutter/material.dart";

class CCTextButtonTheme {
  CCTextButtonTheme._();

  static final TextButtonThemeData lightTheme = TextButtonThemeData(
      style: OutlinedButton.styleFrom(
    elevation: 0,
    foregroundColor: CCAppColors.secondary,
    textStyle: const TextStyle(
      fontSize: 16,
      color: CCAppColors.secondary,
      fontWeight: FontWeight.normal,
    ),
    padding: const EdgeInsets.all(0),
  ));

  static final TextButtonThemeData darkTheme = TextButtonThemeData(
      style: OutlinedButton.styleFrom(
    elevation: 0,
    foregroundColor: CCAppColors.secondary,
    textStyle: const TextStyle(
      fontSize: 16,
      color: Colors.white,
      fontWeight: FontWeight.normal,
    ),
    padding: const EdgeInsets.all(0),
  ));
}
