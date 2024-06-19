import 'package:cubik_club/domain/entities/game/game.dart';
import 'package:cubik_club/domain/services/games_service.dart';
import 'package:cubik_club/ui/navigation/main_navigation.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:cubik_club/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

enum CollectionDisplayMode { list, grid }

class _GamesCollectionScreenViewModelState {
  final CollectionDisplayMode displayMode;
  final String searchString;

  _GamesCollectionScreenViewModelState({
    this.displayMode = CollectionDisplayMode.list,
    this.searchString = '',
  });
}

class GamesCollectionScreenViewModel extends ChangeNotifier {
  var _state = _GamesCollectionScreenViewModelState();
  _GamesCollectionScreenViewModelState get state => _state;

  final _gamesService = GamesService();
  final searchController = TextEditingController();

  void updateState({
    CollectionDisplayMode? displayMode,
    String? searchString,
  }) {
    _state = _GamesCollectionScreenViewModelState(
      displayMode: displayMode ?? _state.displayMode,
      searchString: searchString ?? _state.searchString,
    );
    notifyListeners();
  }

  Future<void> onRandomGameButtonPressed(
    BuildContext context, {
    required WidgetBuilder builder,
  }) async {
    await showModalBottomSheet(
      context: context,
      builder: builder,
      isScrollControlled: true,
    );
  }

  Future<Map<dynamic, dynamic>> loadRandomGame() async {
    return _gamesService.getRandomGame();
  }

  Future<Map<dynamic, dynamic>> loadGamesCollection(String searhQuery) async {
    return _gamesService.getGamesCollection(page: 1, searchQuery: searhQuery);
  }

  Game parseGame(Map<dynamic, dynamic>? gameJson) {
    if (gameJson == null) {
      throw Error();
    }
    return Game.fromJson(gameJson);
  }

  List<Game> getGamesListFromData(Map? map) {
    final collectionList = (map?["collection"] as List);

    final games = List<Game>.generate(
      collectionList.length,
      (index) => parseGame(collectionList[index]),
    );

    return games;
  }

  Future<void> onGameThumbnailPressed(BuildContext context, Game game) async {
    await MainNavigation.toGameScreen(context, game: game);
  }

  void onSearchSubmitted(String value) {
    {
      if (value != state.searchString) {
        updateState(searchString: value);
      }
    }
  }

  Future<void> onSearchFiltersButtonPressed(
    BuildContext context, {
    required WidgetBuilder builder,
  }) async {
    await showModalBottomSheet(
      context: context,
      builder: builder,
      isScrollControlled: true,
    );
  }
}
