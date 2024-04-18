import 'package:cubik_club/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CCDialogTheme {
  CCDialogTheme._();

  static const DialogTheme lightTheme = DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
    backgroundColor: CCAppColors.lightBackground,
    titleTextStyle: TextStyle(
      fontSize: 25,
      color: CCAppColors.lightTextPrimary,
      fontWeight: FontWeight.w700,
    ),
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.transparent,
    actionsPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
    contentTextStyle: TextStyle(
      fontSize: 18,
      color: CCAppColors.lightTextPrimary,
      fontWeight: FontWeight.normal,
    ),
  );

  static const DialogTheme darkTheme = DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
    backgroundColor: CCAppColors.darkBackground,
    titleTextStyle: TextStyle(
      fontSize: 25,
      color: CCAppColors.darkTextPrimary,
      fontWeight: FontWeight.w700,
    ),
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.transparent,
    actionsPadding: EdgeInsets.zero,
    contentTextStyle: TextStyle(
      fontSize: 18,
      color: CCAppColors.darkTextPrimary,
      fontWeight: FontWeight.normal,
    ),
  );
}
