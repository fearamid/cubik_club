// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:cubik_club/domain/entities/game/game.dart';
import 'package:cubik_club/domain/services/games_service.dart';
import 'package:cubik_club/ui/navigation/main_navigation.dart';

enum CollectionDisplayMode { list, grid }

class GameCollectionFilters {
  final int ageLimitFilter;
  final int complexityLimitFilter;
  final List<int> playersRangeFilter;
  final List<int> durationRangeFilter;

  const GameCollectionFilters({
    this.ageLimitFilter = 0,
    this.complexityLimitFilter = 1,
    this.playersRangeFilter = const [2, 12],
    this.durationRangeFilter = const [1, 400],
  });

  GameCollectionFilters copyWith({
    int? ageLimitFilter,
    int? complexityLimitFilter,
    List<int>? playersRangeFilter,
    List<int>? durationRangeFilter,
  }) {
    return GameCollectionFilters(
      ageLimitFilter: ageLimitFilter ?? this.ageLimitFilter,
      complexityLimitFilter:
          complexityLimitFilter ?? this.complexityLimitFilter,
      playersRangeFilter: playersRangeFilter ?? this.playersRangeFilter,
      durationRangeFilter: durationRangeFilter ?? this.durationRangeFilter,
    );
  }
}

class _GamesCollectionScreenViewModelState {
  final CollectionDisplayMode displayMode;
  final String searchString;
  final GameCollectionFilters filters;

  _GamesCollectionScreenViewModelState({
    this.displayMode = CollectionDisplayMode.list,
    this.searchString = '',
    this.filters = const GameCollectionFilters(),
  });
}

class GamesCollectionScreenViewModel extends ChangeNotifier {
  var _state = _GamesCollectionScreenViewModelState();
  _GamesCollectionScreenViewModelState get state => _state;

  final _gamesService = GamesService();
  final searchController = TextEditingController();

  void updateState({
    String? searchString,
    int? ageLimitFilter,
    int? complexityLimitFilter,
    List<int>? durationRangeFilter,
    List<int>? playersRangeFilter,
  }) {
    _state = _GamesCollectionScreenViewModelState(
      searchString: searchString ?? _state.searchString,
      filters: GameCollectionFilters(
        ageLimitFilter: ageLimitFilter ?? _state.filters.ageLimitFilter,
        complexityLimitFilter:
            complexityLimitFilter ?? _state.filters.complexityLimitFilter,
        durationRangeFilter:
            durationRangeFilter ?? _state.filters.durationRangeFilter,
        playersRangeFilter:
            playersRangeFilter ?? _state.filters.playersRangeFilter,
      ),
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

  Future<Map<dynamic, dynamic>> loadGamesCollection({
    required String searhQuery,
    required GameCollectionFilters filters,
  }) async {
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

  void onFiltersApplyButtonPressed(GameCollectionFilters filters) {
    updateState(
      ageLimitFilter: filters.ageLimitFilter,
      complexityLimitFilter: filters.complexityLimitFilter,
      durationRangeFilter: filters.durationRangeFilter,
      playersRangeFilter: filters.playersRangeFilter,
    );
  }

  void onFiltersClearButtonPressed() {}
}
