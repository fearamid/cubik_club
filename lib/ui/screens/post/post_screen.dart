import 'package:cubik_club/domain/entities/event.dart';
import 'package:cubik_club/domain/entities/game/game.dart';
import 'package:cubik_club/ui/screens/post/widgets/export/widgets.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatelessWidget {
  final Event event;

  const PostScreen({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final List<Game> games = [
      const Game(
        id: '123',
        name: 'Монополия',
        description: 'Описание игры',
        tags: GameTags(
          genres: ['стратегия', 'хоррор'],
          author: 'Westplay games',
          ageLimit: 18,
          playersRange: [2, 5],
          duration: 20,
        ),
      ),
      const Game(
        id: '123',
        name: 'Монополия',
        description: 'Описание игры',
        tags: GameTags(
          genres: ['стратегия', 'хоррор'],
          author: 'Westplay games',
          ageLimit: 18,
          playersRange: [2, 5],
          duration: 20,
        ),
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const PostCover(),
                  const SizedBox(height: 20),
                  PostDescription(
                    name: event.name,
                    description: event.description,
                  ),
                  const SizedBox(height: 20),
                  GamesList(
                    games: games,
                    onGamePressed: (Game game) {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
