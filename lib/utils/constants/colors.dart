import 'package:flutter/material.dart';

abstract class CCAppColors {
  // ---------- App Basic Colors ----------

  static const Color primary = Color(0xFF6E69A9);
  static const Color secondary = Color(0xFF677381);
  static const Color accentBlue = Color(0xFF81A0D3);
  static const Color accentGreen = Color(0xFF5BBBA9);
  static const Color accentRed = Color(0xFFED7370);
  static const Color accentYellow = Color(0xFFFAC372);
  // ---------- Text Colors ----------

  static const Color errorText = Color(0xFFED7370);

  // Light
  static const Color lightTextPrimary = Color(0xFF272727);
  static const Color lightTextSecodary = Color(0xFF677381);

  // Dark
  static const Color darkTextPrimary = Colors.white;
  static const Color darkTextSecondary = Color(0xFF677381);

  // ---------- Background Colors ----------
  // Light
  static const Color lightBackground = Colors.white;
  static const Color lightSectionBackground = Color(0xFFF4F4F4);
  static const Color lightHighlightBackground = Color(0xFFD9D9D9);

  // Dark
  static const Color darkBackground = Color(0xFF181818);
  static const Color darkSectionBackground = Color(0xFF1E1E1E);
  static const Color darkHighlightBackground = Color(0xFF2B2B2B);

  // ---------- Another Colors ----------
}
