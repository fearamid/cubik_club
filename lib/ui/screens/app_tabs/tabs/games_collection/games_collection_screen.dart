import 'package:cubik_club/domain/entities/game/game.dart';
import 'package:cubik_club/ui/common/components/search_top_bar.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/games_collection/widgets/game_thumbnail.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/games_collection/widgets/random_game_button.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/games_collection/widgets/search_filters_button.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:cubik_club/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class GamesCollectionScreen extends StatelessWidget {
  const GamesCollectionScreen({super.key});

  static const List<Game> games = [
    Game(
      id: '',
      name: 'Монополия',
      description: 'Крутая игра',
      tags: GameTags(
        genres: ['стратегия'],
        author: 'ppplay',
        ageLimit: 16,
        playersRange: [2, 3],
        duration: 34,
      ),
    ),
    Game(
      id: '',
      name: 'Дуополия',
      description: 'Крутая игра',
      tags: GameTags(
        genres: ['хоррор'],
        author: 'western',
        ageLimit: 18,
        playersRange: [2, 3],
        duration: 20,
      ),
    ),
    Game(
      id: '',
      name: 'Роскошь Дуэль',
      description: 'Крутая игра',
      tags: GameTags(
        genres: ['команда'],
        author: 'apikos',
        ageLimit: 12,
        playersRange: [2, 3],
        duration: 12,
      ),
    ),
    Game(
      id: '',
      name: 'Игра',
      description: 'Крутая игра',
      tags: GameTags(
        genres: ['стратегия'],
        author: 'volters',
        ageLimit: 18,
        playersRange: [2, 3],
        duration: 60,
      ),
    ),
    Game(
      id: '',
      name: 'Inspo',
      description: 'Крутая игра',
      tags: GameTags(
        genres: ['стратегия'],
        author: 'ppplay',
        ageLimit: 12,
        playersRange: [2, 3],
        duration: 20,
      ),
    ),
    Game(
      id: '',
      name: 'Кубикс',
      description: 'Крутая игра',
      tags: GameTags(
        genres: ['стратегия'],
        author: 'ppplay',
        ageLimit: 6,
        playersRange: [2, 3],
        duration: 45,
      ),
    ),
    Game(
      id: '',
      name: 'Викинги',
      description: 'Крутая игра',
      tags: GameTags(
        genres: ['стратегия'],
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
          toolbarHeight: 105,
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
