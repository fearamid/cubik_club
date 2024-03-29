// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final Color color;
  final double paddingVertical;
  final double paddingHorizontal;
  final AlignmentGeometry alignment;

  const Section({
    super.key,
    required this.child,
    this.borderRadius = 20,
    this.color = CCAppColors.lightSectionBackground,
    this.paddingVertical = 20,
    this.paddingHorizontal = 20,
    this.alignment = Alignment.topLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal,
        vertical: paddingVertical,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: color,
      ),
      child: child,
    );
  }
}
