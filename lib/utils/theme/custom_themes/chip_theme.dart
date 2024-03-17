import 'package:flutter/material.dart';

class CCChipTheme {
  CCChipTheme._();

  static final ChipThemeData lightTheme = ChipThemeData(
    disabledColor: Colors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: Colors.black),
    selectedColor: Colors.orange,
    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
    checkmarkColor: Colors.white,
  );

  static final ChipThemeData darkTheme = ChipThemeData(
    disabledColor: Colors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: Colors.white),
    selectedColor: Colors.orange,
    padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
    checkmarkColor: Colors.white,
  );
}
