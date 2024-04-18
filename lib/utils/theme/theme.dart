import 'package:cubik_club/utils/theme/custom_themes/dialog_theme.dart';
import 'package:cubik_club/utils/theme/custom_themes/snack_bar_theme.dart';
import 'package:cubik_club/utils/theme/custom_themes/text_button_theme.dart';
import 'package:flutter/material.dart';

import 'package:cubik_club/utils/constants/colors.dart';
import 'package:cubik_club/utils/theme/custom_themes/app_bar_theme.dart';
import 'package:cubik_club/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:cubik_club/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:cubik_club/utils/theme/custom_themes/chip_theme.dart';
import 'package:cubik_club/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:cubik_club/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:cubik_club/utils/theme/custom_themes/text_field_theme.dart';
import 'package:cubik_club/utils/theme/custom_themes/text_theme.dart';

class CCAppTheme {
  CCAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Roboto',
    brightness: Brightness.light,
    primaryColor: CCAppColors.primary,
    scaffoldBackgroundColor: CCAppColors.lightBackground,
    textTheme: CCTextTheme.lightTheme(
      CCAppColors.lightTextPrimary,
      CCAppColors.lightTextSecodary,
    ),
    elevatedButtonTheme: CCElevatedButtonTheme.lightTheme,
    appBarTheme: CCAppBarTheme.lightTheme,
    bottomSheetTheme: CCBottomSheetTheme.lightTheme,
    checkboxTheme: CCCheckoxTheme.lightTheme,
    outlinedButtonTheme: CCOutlinedButtonTheme.lightTheme,
    inputDecorationTheme: CCTextFieldTheme.lightTheme,
    chipTheme: CCChipTheme.lightTheme,
    textButtonTheme: CCTextButtonTheme.lightTheme,
    dialogTheme: CCDialogTheme.lightTheme,
    snackBarTheme: CCSnackBarTheme.lightTheme,
    // TODO: SnackBarTheme (dark, light)
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Roboto',
    brightness: Brightness.dark,
    primaryColor: CCAppColors.primary,
    scaffoldBackgroundColor: CCAppColors.darkBackground,
    textTheme: CCTextTheme.lightTheme(
      CCAppColors.darkTextPrimary,
      CCAppColors.darkTextSecondary,
    ),
    elevatedButtonTheme: CCElevatedButtonTheme.darkTheme,
    appBarTheme: CCAppBarTheme.darkTheme,
    bottomSheetTheme: CCBottomSheetTheme.darkTheme,
    checkboxTheme: CCCheckoxTheme.darkTheme,
    outlinedButtonTheme: CCOutlinedButtonTheme.darkTheme,
    inputDecorationTheme: CCTextFieldTheme.darkTheme,
    chipTheme: CCChipTheme.darkTheme,
    textButtonTheme: CCTextButtonTheme.darkTheme,
    snackBarTheme: CCSnackBarTheme.darkTheme,
    dialogTheme: CCDialogTheme.darkTheme,
  );
}
