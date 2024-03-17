import "package:flutter/material.dart";

class CCTextTheme {
  CCTextTheme._();

  static TextTheme lightTheme(Color mainTextColor, Color secondaryTextColor) {
    return TextTheme(
      headlineMedium: const TextStyle().copyWith(
          color: mainTextColor, fontSize: 20, fontWeight: FontWeight.bold),
      titleMedium: const TextStyle().copyWith(
          color: mainTextColor, fontSize: 16, fontWeight: FontWeight.bold),
      titleLarge: const TextStyle().copyWith(
          color: mainTextColor, fontSize: 25, fontWeight: FontWeight.bold),
      bodyMedium: const TextStyle().copyWith(
          color: mainTextColor, fontSize: 16, fontWeight: FontWeight.normal),
      labelLarge: const TextStyle().copyWith(
          color: secondaryTextColor, fontSize: 16, fontWeight: FontWeight.bold),
      labelMedium: const TextStyle().copyWith(
          color: secondaryTextColor, fontSize: 14, fontWeight: FontWeight.bold),
      labelSmall: const TextStyle().copyWith(
          color: secondaryTextColor,
          fontSize: 14,
          fontWeight: FontWeight.normal),
    );
  }

  static TextTheme darkTheme(Color mainTextColor, Color secondaryTextColor) {
    return TextTheme(
      headlineMedium: const TextStyle().copyWith(
          color: mainTextColor, fontSize: 20, fontWeight: FontWeight.bold),
      titleMedium: const TextStyle().copyWith(
          color: mainTextColor, fontSize: 16, fontWeight: FontWeight.bold),
      bodyMedium: const TextStyle().copyWith(
          color: mainTextColor, fontSize: 16, fontWeight: FontWeight.normal),
      labelLarge: const TextStyle().copyWith(
          color: secondaryTextColor, fontSize: 16, fontWeight: FontWeight.bold),
      labelMedium: const TextStyle().copyWith(
          color: secondaryTextColor, fontSize: 14, fontWeight: FontWeight.bold),
      labelSmall: const TextStyle().copyWith(
          color: secondaryTextColor,
          fontSize: 14,
          fontWeight: FontWeight.normal),
    );
  }
}
