import "package:cubik_club/utils/constants/colors.dart";
import "package:flutter/material.dart";

class CCOutlinedButtonTheme {
  CCOutlinedButtonTheme._();

  static final OutlinedButtonThemeData lightTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
    elevation: 0,
    foregroundColor: CCAppColors.secondary,
    side: const BorderSide(
      width: 1,
      color: CCAppColors.lightHighlightBackground,
    ),
    textStyle: const TextStyle(
      fontSize: 18,
      color: CCAppColors.secondary,
      fontWeight: FontWeight.normal,
    ),
    padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 40),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ));

  static final OutlinedButtonThemeData darkTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
    elevation: 0,
    foregroundColor: CCAppColors.secondary,
    side: const BorderSide(
      width: 1,
      color: CCAppColors.darkHighlightBackground,
    ),
    textStyle: const TextStyle(
      fontSize: 18,
      color: CCAppColors.secondary,
      fontWeight: FontWeight.normal,
    ),
    padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 40),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ));
}
