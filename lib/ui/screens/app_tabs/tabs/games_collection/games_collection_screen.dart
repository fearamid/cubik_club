import 'package:cubik_club/domain/entities/game/game.dart';
import 'package:cubik_club/ui/common/components/export/components.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/games_collection/view_model/games_collection_screen_view_model.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/games_collection/widgets/game_thumbnail.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:cubik_club/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';

class GamesCollectionScreen extends StatelessWidget {
  const GamesCollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        _SearchAppBar(),
        _GamesCollectionList(),
        SliverToBoxAdapter(
            child: SizedBox(height: kBottomNavigationBarHeight + 45)),
      ],
    );
  }
}

class _GamesCollectionList extends StatelessWidget {
  const _GamesCollectionList();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<GamesCollectionScreenViewModel>();
    final searchQuery =
        context.watch<GamesCollectionScreenViewModel>().state.searchString;
    return FutureBuilder<Map<dynamic, dynamic>>(
      future: viewModel.loadGamesCollection(searchQuery),
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

        final games = viewModel.getGamesListFromData(snapshot.data);

        const double spacing = 10;
        final mainAxisExtent =
            (CCDeviceUtils.getScreenWidth(context) - spacing) / 2 + 37;

        return SliverGrid.builder(
          itemCount: games.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
            mainAxisExtent: mainAxisExtent,
          ),
          itemBuilder: (_, index) => GameThumbnail(
            game: games[index],
            onTap: (game) => viewModel.onGameThumbnailPressed(context, game),
          ),
        );
      },
    );
  }
}

class _SearchAppBar extends StatelessWidget {
  const _SearchAppBar();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<GamesCollectionScreenViewModel>();
    return SliverAppBar(
      titleSpacing: 0,
      backgroundColor: CCAppColors.lightBackground,
      toolbarHeight: 105,
      snap: true,
      floating: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      title: SearchTopBar(
        searchController: viewModel.searchController,
        onSubmitted: viewModel.onSearchSubmitted,
        actions: const [
          _RandomGameButton(),
          SizedBox(width: 7),
          _SearchFiltersButton(),
        ],
      ),
    );
  }
}

class _RandomGameButton extends StatelessWidget {
  const _RandomGameButton();

  @override
  Widget build(BuildContext context) {
    final model = context.read<GamesCollectionScreenViewModel>();
    return CustomIconButton(
      icon: Iconsax.colorfilter_copy,
      onPressed: () async {
        final gameFuture = model.loadRandomGame();
        await model.onRandomGameButtonPressed(
          context,
          builder: (_) {
            return FutureBuilder(
              future: gameFuture,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case ConnectionState.done:
                    break;
                }

                if (snapshot.hasData && !snapshot.hasError) {
                  final game = Game.fromJson(snapshot.data!);
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: GameThumbnail(
                        onTap: (game) async {
                          await model.onGameThumbnailPressed(context, game);
                        },
                        nameMaxLines: 3,
                        game: game,
                      ),
                    ),
                  );
                }
                return const Center(
                  child: Text('Ошибка загрузки случайной игры'),
                );
              },
            );
            // return const _RandomGameThumbnail();
          },
        );
      },
    );
  }
}

class _RandomGameThumbnail extends StatelessWidget {
  const _RandomGameThumbnail();

  @override
  Widget build(BuildContext context) {
    return Center();
    // return FutureBuilder<Map<dynamic, dynamic>>(
    //   future: future(),
    //   builder: (_, snapshot) {
    //     switch (snapshot.connectionState) {
    //       case ConnectionState.none:
    //       case ConnectionState.waiting:
    //       case ConnectionState.active:
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       case ConnectionState.done:
    //         break;
    //     }

    //     if (snapshot.hasError) {
    //       return const Center(
    //           child: Text('Ошибка при получении случайной игры'));
    //     }
    //     if (!snapshot.hasData) {
    //       return const Center(child: Text('Не удалось получить данные'));
    //     }

    //   },
    // );
  }
}

class _SearchFiltersButton extends StatelessWidget {
  const _SearchFiltersButton({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<GamesCollectionScreenViewModel>();
    return CustomIconButton(
      icon: Iconsax.candle_2_copy,
      onPressed: model.onSearchFiltersButtonPressed,
    );
  }
}
