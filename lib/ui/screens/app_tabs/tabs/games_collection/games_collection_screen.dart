import 'package:cubik_club/domain/entities/game/game.dart';
import 'package:cubik_club/domain/entities/game/publisher.dart';
import 'package:cubik_club/ui/common/components/search_top_bar.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/games_collection/widgets/game_thumbnail.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/games_collection/widgets/random_game_button.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/games_collection/widgets/search_filters_button.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:cubik_club/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class GamesCollectionScreen extends StatelessWidget {
  const GamesCollectionScreen({super.key});

  static List<Game> games = [
    Game(
      id: 1,
      name: 'Монополия',
      description: 'Крутая игра',
      tags: const GameTags(
        genres: ['стратегия'],
        author: Publisher(id: 1, name: 'fsdf'),
        ageLimit: 16,
        playersRange: [2, 3],
        durationRange: 34,
      ),
      rules: '',
    ),
    Game(
      id: 2,
      name: 'Дуополия',
      description: 'Крутая игра',
      tags: const GameTags(
        genres: ['хоррор'],
        author: Publisher(id: 1, name: 'fsdf'),
        ageLimit: 18,
        playersRange: [2, 3],
        durationRange: 20,
      ),
      rules: '',
    ),
    Game(
      id: 3,
      name: 'Роскошь Дуэль',
      description: 'Крутая игра',
      tags: const GameTags(
        genres: ['команда'],
        author: Publisher(id: 1, name: 'fsdf'),
        ageLimit: 12,
        playersRange: [2, 3],
        durationRange: 12,
      ),
      rules: '',
    ),
    Game(
      id: 4,
      name: 'Игра',
      description: 'Крутая игра',
      tags: const GameTags(
        genres: ['стратегия'],
        author: Publisher(id: 1, name: 'fsdf'),
        ageLimit: 18,
        playersRange: [2, 3],
        durationRange: 60,
      ),
      rules: '',
    ),
    Game(
      id: 5,
      name: 'Inspo',
      description: 'Крутая игра',
      tags: const GameTags(
        genres: ['стратегия'],
        author: Publisher(id: 1, name: 'fsdf'),
        ageLimit: 12,
        playersRange: [2, 3],
        durationRange: 20,
      ),
      rules: '',
    ),
    Game(
      id: 6,
      name: 'Кубикс',
      description: 'Крутая игра',
      tags: const GameTags(
        genres: ['стратегия'],
        author: Publisher(id: 1, name: 'fsdf'),
        ageLimit: 6,
        playersRange: [2, 3],
        durationRange: 45,
      ),
      rules: '',
    ),
    Game(
      id: 7,
      name: 'Викинги',
      description: 'Крутая игра',
      tags: const GameTags(
        genres: ['стратегия'],
        author: Publisher(id: 1, name: 'fsdf'),
        ageLimit: 16,
        playersRange: [2, 3],
        durationRange: 80,
      ),
      rules: '',
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
            child: SizedBox(height: kBottomNavigationBarHeight + 45)),
      ],
    );
  }
}
