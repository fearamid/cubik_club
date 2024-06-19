import 'package:cubik_club/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CCBottomSheetTheme {
  CCBottomSheetTheme._();

  static const BottomSheetThemeData lightTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: CCAppColors.lightBackground,
    modalBackgroundColor: CCAppColors.lightBackground,
    surfaceTintColor: CCAppColors.lightBackground,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
  );

  static const BottomSheetThemeData darkTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: CCAppColors.darkBackground,
    modalBackgroundColor: CCAppColors.darkBackground,
    constraints: BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
  );
}
