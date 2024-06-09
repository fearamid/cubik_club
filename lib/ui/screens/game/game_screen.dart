import 'package:cubik_club/domain/entities/game/game.dart';
import 'package:cubik_club/ui/common/components/export/components.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          const CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const _GameCover(),
                const SizedBox(height: 20),
                _GameTagsList(
                  gameName: game.name,
                  tags: const ['стратегия', '18+', 'westplay'],
                ),
                const SizedBox(height: 20),
                _GameDescription(
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

class _GameCover extends StatelessWidget {
  const _GameCover({super.key});

  @override
  Widget build(BuildContext context) {
    // final game = context.read<GameScreenViewModel>().state.event;
    return const CachedImageCarousel(
      coverLink: 'ЗАГЛУШКА',
      // imagesLinks: event.imagesLinks,
    );
  }
}

class _GameDescription extends StatelessWidget {
  final String name;
  final String description;

  const _GameDescription({
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Описание',
            style: TextStyle(
              color: CCAppColors.lightTextPrimary,
              fontSize: 25,
              fontWeight: FontWeight.w700,
              height: 1,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            description,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: CCAppColors.lightTextPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _GameTagsList extends StatelessWidget {
  final String gameName;
  final List<String> tags;

  const _GameTagsList({
    required this.gameName,
    required this.tags,
  });

  List<Widget> _createChildren() {
    List<Widget> children = [
      Text(
        gameName,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 3),
    ];

    for (int i = 0; i < tags.length; i++) {
      children.add(
        Text(
          tags[i],
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      );
    }

    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _createChildren(),
      ),
    );
  }
}
