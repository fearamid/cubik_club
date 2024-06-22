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
                  SizedBox(height: 20),
                  _GameRules()
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

class _GameRules extends StatelessWidget {
  const _GameRules();

  @override
  Widget build(BuildContext context) {
    final game = context.read<GameScreenViewModel>().state.game;
    return Section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Правила',
            style: TextStyle(
              color: CCAppColors.lightTextPrimary,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              height: 1,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            game.rules,
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
              // const _LikeButton(),
              // const SizedBox(width: 13),
              // IconButton(
              //   onPressed: () {},
              //   icon: const Icon(
              //     Iconsax.archive_minus_copy,
              //     size: 35,
              //     color: CCAppColors.lightHighlightBackground,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LikeButton extends StatelessWidget {
  const _LikeButton();

  @override
  Widget build(BuildContext context) {
    final isLiked = context.watch<GameScreenViewModel>().state.like;
    return IconButton(
      onPressed: context.read<GameScreenViewModel>().onLikeButtonPressed,
      highlightColor: isLiked ? null : CCAppColors.accentRed.withOpacity(0.5),
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (child, anim) => FadeTransition(
          opacity: child.key == const ValueKey('icon1')
              ? Tween<double>(begin: 0.5, end: 1).animate(anim)
              : Tween<double>(begin: 0.5, end: 1).animate(anim),
          child: FadeTransition(opacity: anim, child: child),
        ),
        child: isLiked
            ? const Icon(
                key: ValueKey('icon1'),
                Iconsax.heart,
                color: CCAppColors.accentRed,
                size: 35,
              )
            : const Icon(
                key: ValueKey('icon2'),
                Iconsax.heart_copy,
                color: CCAppColors.lightHighlightBackground,
                size: 35,
              ),
      ),
    );
  }
}
