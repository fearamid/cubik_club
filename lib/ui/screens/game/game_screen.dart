import 'package:cubik_club/ui/common/components/export/components.dart';
import 'package:cubik_club/ui/screens/game/view_model/game_screen_view_model.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const CustomAppBar(),
            SliverList(
              delegate: SliverChildListDelegate(
                const [
                  _GameCover(),
                  SizedBox(height: 20),
                  _GameTagsList(),
                  SizedBox(height: 20),
                  _GameDescription(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GameCover extends StatelessWidget {
  const _GameCover();

  @override
  Widget build(BuildContext context) {
    final game = context.read<GameScreenViewModel>().state.game;
    return CachedImageCarousel(
      coverLink: game.coverLink,
      imagesLinks: game.imagesLinks,
    );
  }
}

class _GameDescription extends StatelessWidget {
  const _GameDescription();

  @override
  Widget build(BuildContext context) {
    final game = context.read<GameScreenViewModel>().state.game;
    return Section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Описание',
            style: TextStyle(
              color: CCAppColors.lightTextPrimary,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              height: 1,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            game.description,
            style: const TextStyle(
              fontSize: 16,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

class _GameTagsList extends StatelessWidget {
  const _GameTagsList();

  @override
  Widget build(BuildContext context) {
    final game = context.read<GameScreenViewModel>().state.game;
    return Section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            game.name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          TagsView(tags: game.tags),
          const SizedBox(height: 20),
          Row(
            children: [
              OutlinedButton(
                onPressed: () {
                  context
                      .read<GameScreenViewModel>()
                      .onRulesButtonPressed(context);
                },
                child: const Text('Правила'),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Iconsax.heart_copy,
                  size: 40,
                  color: CCAppColors.secondary,
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Iconsax.bookmark_copy,
                  size: 40,
                  color: CCAppColors.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
