import 'dart:convert';

import 'package:cubik_club/domain/entities/game/game.dart';
import 'package:cubik_club/domain/services/games_service.dart';
import 'package:cubik_club/ui/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

enum CollectionDisplayMode { list, grid }

class _GamesCollectionScreenViewModelState {
  final CollectionDisplayMode displayMode;

  _GamesCollectionScreenViewModelState({
    this.displayMode = CollectionDisplayMode.list,
  });
}

class GamesCollectionScreenViewModel extends ChangeNotifier {
  var _state = _GamesCollectionScreenViewModelState();
  get state => _state;

  final _gamesService = GamesService();

  void updateState({
    CollectionDisplayMode? displayMode,
  }) {
    _state = _GamesCollectionScreenViewModelState(
      displayMode: displayMode ?? _state.displayMode,
    );
    notifyListeners();
  }

  void onRandomGameButtonPressed(
    BuildContext context, {
    required WidgetBuilder builder,
  }) {
    showDialog(
      context: context,
      builder: builder,
    );
  }

  Future<Map<dynamic, dynamic>> loadGamesCollection() async {
    return _gamesService.getGamesCollection(page: 1);
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

  void onGameThumbnailPressed(BuildContext context, Game game) {
    MainNavigation.toGameScreen(context, game: game);
  }

  void onSearchFiltersButtonPressed() {}

  void onDropDownFiltersChanged(int? index) {}

  void onCollectionViewModeButtonPressed(CollectionDisplayMode mode) {
    updateState(displayMode: mode);
  }
}
