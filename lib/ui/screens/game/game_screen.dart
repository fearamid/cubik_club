import 'package:cubik_club/domain/entities/game/game.dart';
import 'package:cubik_club/ui/screens/game/widgets/widgets.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({
    super.key,
    required this.game,
  });

  final Game game;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: const Icon(Iconsax.arrow_left_2_copy),
              iconSize: 35,
              color: CCAppColors.secondary,
              onPressed: () => Navigator.of(context).pop(),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            snap: true,
            floating: true,
            backgroundColor: CCAppColors.lightBackground,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const GameCover(),
                const SizedBox(height: 20),
                GameTagsList(
                  gameName: game.name,
                  tags: const ['стратегия', '18+', 'westplay'],
                ),
                const SizedBox(height: 20),
                GameDescription(
                  name: game.name,
                  description: game.description,
                ),
                const SizedBox(height: kBottomNavigationBarHeight + 60),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
