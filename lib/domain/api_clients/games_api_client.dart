import 'dart:convert';
import 'package:cubik_club/domain/api_clients/api_client.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/games_collection/view_model/games_collection_screen_view_model.dart';

class GamesApiClient {
  static const String _basePath = "";

  final _apiClient = ApiClient();

  Future<Map<dynamic, dynamic>> getGamesCollection(
    int page,
    String searchQuery,
    GameCollectionFilters filters,
  ) async {
    final filtersJson = json.encode({
      'age_limit': filters.ageLimitFilter,
      'complexity': filters.complexityLimitFilter,
      'players_range': filters.playersRangeFilter,
      'duration_range': filters.durationRangeFilter
    });

    final response = await _apiClient.get(
      path: '/games/collection',
      queryParameters: {
        'page': '$page',
        'search': base64.encode(utf8.encode(searchQuery)).toString(),
        'filters': base64.encode(utf8.encode(filtersJson)).toString(),
      },
    );
    return (await ApiClient.getJson<Map<dynamic, dynamic>>(response));
  }

  Future<Map<dynamic, dynamic>> getRandomGame() async {
    final response = await _apiClient.get(
      path: '/games/random',
    );
    return (await ApiClient.getJson<Map<dynamic, dynamic>>(response));
  }

  Future<List<Map<dynamic, dynamic>>> getGamesListByIds(
      List<int> idList) async {
    final response = await _apiClient.get(
      path: '/games',
      queryParameters: {'ids': idList},
    );

    final games = (await ApiClient.getJson<List<dynamic>>(response))
        .map((e) => Map.from(e))
        .toList();

    return games;
  }
}
