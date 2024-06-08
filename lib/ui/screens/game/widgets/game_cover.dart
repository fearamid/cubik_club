import 'package:cubik_club/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';

class GameCover extends StatelessWidget {
  const GameCover({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: Image.asset(CCImages.tomato),
      ),
    );
  }
}
