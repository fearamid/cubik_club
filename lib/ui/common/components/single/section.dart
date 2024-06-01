// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double? height;
  final double? width;
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
    this.height,
    this.width,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          height: height,
          width: width,
          alignment: alignment,
          padding: EdgeInsets.symmetric(
            horizontal: paddingHorizontal,
            vertical: paddingVertical,
          ),
          child: child,
        ),
      ),
    );
  }
}
