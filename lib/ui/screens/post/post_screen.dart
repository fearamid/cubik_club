import 'package:cached_network_image/cached_network_image.dart';
import 'package:cubik_club/domain/entities/event.dart';
import 'package:cubik_club/domain/entities/game/game.dart';
import 'package:cubik_club/ui/screens/post/widgets/games_list.dart';
import 'package:cubik_club/ui/screens/post/widgets/post_description.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

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
                  _PostCover(event.coverLink),
                  const SizedBox(height: 20),
                  PostDescription(
                    name: event.title,
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

class _PostCover extends StatelessWidget {
  final String coverLink;
  const _PostCover(this.coverLink);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: CachedNetworkImage(
              imageUrl: coverLink,
              fit: BoxFit.cover,
            ),
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
