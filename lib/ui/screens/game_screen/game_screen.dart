import 'package:cubik_club/domain/entities/game/game.dart';
import 'package:cubik_club/ui/screens/game_screen/widgets/widgets.dart';
import 'package:flutter/material.dart';

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
