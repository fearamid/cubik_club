import "package:cubik_club/utils/constants/colors.dart";
import "package:flutter/material.dart";

class CCElevatedButtonTheme {
  CCElevatedButtonTheme._();

  static final ElevatedButtonThemeData lightTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: CCAppColors.primary,
      disabledBackgroundColor: CCAppColors.lightHighlightBackground,
      disabledForegroundColor: CCAppColors.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      textStyle: const TextStyle(
          fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
      side: BorderSide.none,
    ),
  );

  static final ElevatedButtonThemeData darkTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(double.infinity, 20),
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: CCAppColors.primary,
      disabledBackgroundColor: CCAppColors.darkHighlightBackground,
      disabledForegroundColor: CCAppColors.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      textStyle: const TextStyle(
          fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
      side: BorderSide.none,
    ),
  );
}
