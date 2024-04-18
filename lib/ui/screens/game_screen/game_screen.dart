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
                GameDescription(
                  name: game.name,
                  description: game.description,
                ),
                const SizedBox(height: 20),
                const TagsList(["Монополия", "Другая игра"]),
                const SizedBox(height: kBottomNavigationBarHeight + 60),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
