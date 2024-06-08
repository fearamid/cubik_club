import 'package:cubik_club/utils/constants/colors.dart';
import 'package:cubik_club/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class GameCover extends StatelessWidget {
  const GameCover({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: Image.asset(CCImages.tomato),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: CCAppColors.lightBackground,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Iconsax.arrow_left_2_copy,
                size: 35,
                color: CCAppColors.secondary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
