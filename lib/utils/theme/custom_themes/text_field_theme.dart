import 'package:cubik_club/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CCTextFieldTheme {
  CCTextFieldTheme._();

  static InputDecorationTheme lightTheme = InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
    errorMaxLines: 3,
    prefixIconColor: CCAppColors.secondary,
    suffixIconColor: CCAppColors.secondary,
    // constraints: const BoxConstraints.expand(),
    labelStyle: const TextStyle().copyWith(
        fontSize: 16,
        color: CCAppColors.secondary,
        fontWeight: FontWeight.w400),
    hintStyle: const TextStyle().copyWith(
        fontSize: 16,
        color: CCAppColors.secondary,
        fontWeight: FontWeight.w400),
    errorStyle: const TextStyle(fontStyle: FontStyle.normal),
    floatingLabelStyle:
        const TextStyle().copyWith(color: CCAppColors.secondary),
    border: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
            width: 2, color: CCAppColors.lightHighlightBackground)),
    enabledBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
            width: 2, color: CCAppColors.lightHighlightBackground)),
    focusedBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(width: 2, color: CCAppColors.accentBlue)),
    errorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(width: 2, color: CCAppColors.primary)),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(width: 2, color: CCAppColors.primary)),
  );

  static InputDecorationTheme darkTheme = InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
    errorMaxLines: 3,
    prefixIconColor: CCAppColors.secondary,
    suffixIconColor: CCAppColors.secondary,
    // constraints: const BoxConstraints.expand(),
    labelStyle: const TextStyle().copyWith(
      fontSize: 16,
      color: CCAppColors.secondary,
      fontWeight: FontWeight.w400,
    ),
    hintStyle: const TextStyle().copyWith(
      fontSize: 16,
      color: CCAppColors.secondary,
      fontWeight: FontWeight.w400,
    ),
    errorStyle: const TextStyle(fontStyle: FontStyle.normal),
    floatingLabelStyle:
        const TextStyle().copyWith(color: CCAppColors.secondary),
    border: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
            width: 2, color: CCAppColors.darkHighlightBackground)),
    enabledBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
            width: 2, color: CCAppColors.darkHighlightBackground)),
    focusedBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(width: 2, color: CCAppColors.accentBlue)),
    errorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(width: 2, color: CCAppColors.primary)),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(width: 2, color: CCAppColors.primary)),
  );
}
