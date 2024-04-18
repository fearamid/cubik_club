import 'package:flutter/material.dart';

import '../post/widgets/widgets.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const PostCover(),
                const SizedBox(height: 20),
                const PostDescription(
                  name: 'event.name',
                  description: 'event.description',
                ),
                const SizedBox(height: 20),
                const GamesList(["Монополия", "Другая игра"]),
                const SizedBox(height: kBottomNavigationBarHeight + 60),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
