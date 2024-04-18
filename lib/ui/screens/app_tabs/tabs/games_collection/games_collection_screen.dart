import 'package:cubik_club/domain/entities/game/game.dart';
import 'package:cubik_club/ui/common/components/search_top_bar.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/games_collection/games_collection_widgets.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:cubik_club/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class GamesCollectionScreen extends StatelessWidget {
  const GamesCollectionScreen({super.key});

  static const List<Game> games = [
    Game(
      name: 'Монополия',
      description: 'Крутая игра',
      tags: GameTags(
        genres: 'стратегия',
        author: 'ppplay',
        ageLimit: 16,
        playersRange: [2, 3],
        duration: 34,
      ),
    ),
    Game(
      name: 'Дуополия',
      description: 'Крутая игра',
      tags: GameTags(
        genres: 'хоррор',
        author: 'western',
        ageLimit: 18,
        playersRange: [2, 3],
        duration: 20,
      ),
    ),
    Game(
      name: 'Роскошь Дуэль',
      description: 'Крутая игра',
      tags: GameTags(
        genres: 'команда',
        author: 'apikos',
        ageLimit: 12,
        playersRange: [2, 3],
        duration: 12,
      ),
    ),
    Game(
      name: 'Игра',
      description: 'Крутая игра',
      tags: GameTags(
        genres: 'стратегия',
        author: 'volters',
        ageLimit: 18,
        playersRange: [2, 3],
        duration: 60,
      ),
    ),
    Game(
      name: 'Inspo',
      description: 'Крутая игра',
      tags: GameTags(
        genres: 'стратегия',
        author: 'ppplay',
        ageLimit: 12,
        playersRange: [2, 3],
        duration: 20,
      ),
    ),
    Game(
      name: 'Кубикс',
      description: 'Крутая игра',
      tags: GameTags(
        genres: 'стратегия',
        author: 'ppplay',
        ageLimit: 6,
        playersRange: [2, 3],
        duration: 45,
      ),
    ),
    Game(
      name: 'Викинги',
      description: 'Крутая игра',
      tags: GameTags(
        genres: 'стратегия',
        author: 'insecto',
        ageLimit: 16,
        playersRange: [2, 3],
        duration: 80,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: delete magic numbers
    final collectionItemHeight =
        (CCDeviceUtils.getScreenWidth(context) - 10) / 2 + 10 + 100;

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          titleSpacing: 0,
          backgroundColor: CCAppColors.lightBackground,
          toolbarHeight: 110,
          pinned: true,
          snap: true,
          floating: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35),
            ),
          ),
          title: SearchTopBar(
            top: 30,
            actions: [
              RandomGameButton(),
              SizedBox(width: 7),
              SearchFiltersButton(),
            ],
          ),
        ),
        SliverGrid.builder(
          itemCount: games.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1,
            mainAxisExtent: collectionItemHeight,
          ),
          itemBuilder: (context, index) {
            return GameThumbnail(
              game: games[index],
            );
          },
        ),
        const SliverToBoxAdapter(
            child: SizedBox(height: kBottomNavigationBarHeight + 60)),
      ],
    );
  }
}
