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
          itemBuilder: (_, index) => GameThumbnail(game: games[index]),
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
