import 'package:cubik_club/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;
  final EdgeInsets padding;
  final VoidCallback? onPressed;

  const CustomIconButton({
    super.key,
    required this.icon,
    this.color = CCAppColors.secondary,
    this.size = 35,
    this.padding = const EdgeInsets.all(10),
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: padding,
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: size,
        color: color,
      ),
    );
  }
}
