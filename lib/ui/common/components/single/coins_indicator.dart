import 'package:cubik_club/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CoinsIndicator extends StatelessWidget {
  final int value;
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
            '$value',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
              color: CCAppColors.secondary,
            ),
          ),
          SizedBox(width: spacing),
          Icon(
            Iconsax.mask_2,
            size: iconSize,
            color: CCAppColors.accentYellow,
          ),
        ],
      ),
    );
  }
}
