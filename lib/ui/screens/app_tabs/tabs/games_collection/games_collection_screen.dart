import 'package:cubik_club/domain/entities/game/game.dart';
import 'package:cubik_club/domain/entities/game/publisher.dart';
import 'package:cubik_club/ui/common/components/search_top_bar.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/games_collection/view_model/games_collection_screen_view_model.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/games_collection/widgets/game_thumbnail.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/games_collection/widgets/random_game_button.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/games_collection/widgets/search_filters_button.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:cubik_club/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GamesCollectionScreen extends StatelessWidget {
  const GamesCollectionScreen({super.key});

  static List<Game> games = [
    Game(
      id: 1,
      name: 'Монополия',
      description: 'Крутая игра',
      tags: const GameTags(
        genres: ['стратегия'],
        ageLimit: 16,
        playersRange: [2, 3],
        durationRange: [45, 60],
        complexity: 0,
        publisher: Publisher(id: 1, name: 'z'),
      ),
      rules: '',
    ),
    Game(
      id: 2,
      name: 'Дуополия',
      description: 'Крутая игра',
      tags: const GameTags(
        genres: ['хоррор'],
        ageLimit: 18,
        playersRange: [2, 3],
        durationRange: [45, 60],
        complexity: 0,
        publisher: Publisher(id: 1, name: 'z'),
      ),
      rules: '',
    ),
    Game(
      id: 3,
      name: 'Роскошь Дуэль',
      description: 'Крутая игра',
      tags: const GameTags(
        genres: ['команда'],
        ageLimit: 12,
        playersRange: [2, 3],
        durationRange: [45, 60],
        complexity: 0,
        publisher: Publisher(id: 1, name: 'z'),
      ),
      rules: '',
    ),
    Game(
      id: 4,
      name: 'Игра',
      description: 'Крутая игра',
      tags: const GameTags(
        genres: ['стратегия'],
        ageLimit: 18,
        playersRange: [2, 3],
        durationRange: [45, 60],
        complexity: 0,
        publisher: Publisher(id: 1, name: 'z'),
      ),
      rules: '',
    ),
    Game(
      id: 5,
      name: 'Inspo',
      description: 'Крутая игра',
      tags: const GameTags(
        genres: ['стратегия'],
        ageLimit: 12,
        playersRange: [2, 3],
        durationRange: [45, 60],
        complexity: 0,
        publisher: Publisher(id: 1, name: 'z'),
      ),
      rules: '',
    ),
    Game(
      id: 6,
      name: 'Кубикс',
      description: 'Крутая игра',
      tags: const GameTags(
        genres: ['стратегия'],
        ageLimit: 6,
        playersRange: [2, 3],
        durationRange: [45, 60],
        complexity: 0,
        publisher: Publisher(id: 1, name: 'z'),
      ),
      rules: '',
    ),
    Game(
      id: 7,
      name: 'Викинги',
      description: 'Крутая игра',
      tags: const GameTags(
        genres: ['стратегия'],
        ageLimit: 16,
        playersRange: [2, 3],
        durationRange: [45, 60],
        complexity: 0,
        publisher: Publisher(id: 1, name: 'z'),
      ),
      rules: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: delete magic numbers
    final collectionItemHeight =
        (CCDeviceUtils.getScreenWidth(context) - 10) / 2 + 10 + 100;

    return const CustomScrollView(
      slivers: [
        _SearchAppBar(),
        _GamesCollectionList(),
        // SliverGrid.builder(
        //   itemCount: games.length,
        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2,
        //     crossAxisSpacing: 10,
        //     mainAxisSpacing: 10,
        //     childAspectRatio: 1,
        //     mainAxisExtent: collectionItemHeight,
        //   ),
        //   itemBuilder: (context, index) {
        //     return GameThumbnail(
        //       game: games[index],
        //     );
        //   },
        // ),
        SliverToBoxAdapter(
            child: SizedBox(height: kBottomNavigationBarHeight + 45)),
      ],
    );
  }
}

class _GamesCollectionList extends StatelessWidget {
  const _GamesCollectionList({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<GamesCollectionScreenViewModel>();
    return FutureBuilder<Map<dynamic, dynamic>>(
      future: viewModel.loadGamesCollection(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.active:
            return const SliverToBoxAdapter(
              child: Center(
                child: Text('Загружаем данные...'),
              ),
            );
          case ConnectionState.done:
            break;
          default:
        }

        if (snapshot.hasError) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text(snapshot.error.toString()),
            ),
          );
        }

        final games = (snapshot.data?['collection']);
        // final games = List<String>.from(snapshot.data?['collection'] as List);
        print(games.runtimeType);

        // TODO: delete magic numbers
        final collectionItemHeight =
            (CCDeviceUtils.getScreenWidth(context) - 10) / 2 + 10 + 100;

        return SliverGrid.builder(
          itemCount: games?.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1,
            mainAxisExtent: collectionItemHeight,
          ),
          itemBuilder: (context, index) {
            // final game = viewModel.parseGame(games?[index]);
            return Text(games.toString());
            // return GameThumbnail(game: game);
          },
        );
      },
    );
  }
}

class _SearchAppBar extends StatelessWidget {
  const _SearchAppBar();

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      titleSpacing: 0,
      backgroundColor: CCAppColors.lightBackground,
      toolbarHeight: 105,
      snap: true,
      floating: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      title: SearchTopBar(
        actions: [
          RandomGameButton(),
          SizedBox(width: 7),
          SearchFiltersButton(),
        ],
      ),
    );
  }
}
