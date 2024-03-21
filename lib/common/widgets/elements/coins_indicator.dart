import 'package:cubik_club/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CoinsIndicator extends StatelessWidget {
  final String value;
  final double fontSize;
  final double spacing;
  final double iconSize;

  const CoinsIndicator({
    super.key,
    required this.value,
    this.fontSize = 20,
    this.spacing = 4,
    this.iconSize = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Баллы за победы и активность',
      triggerMode: TooltipTriggerMode.tap,
      child: Row(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
              color: CCAppColors.secondary,
            ),
          ),
          SizedBox(width: spacing),
          Icon(Icons.circle, size: iconSize, color: CCAppColors.accentYellow),
        ],
      ),
    );
  }
}
