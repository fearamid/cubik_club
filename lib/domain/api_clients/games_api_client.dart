import 'dart:convert';
import 'package:cubik_club/domain/api_clients/api_client.dart';

class GamesApiClient {
  static const String _basePath = "";

  final _apiClient = ApiClient();

  Future<Map<dynamic, dynamic>> getGamesCollection(
      int page, String searchQuery) async {
    final response = await _apiClient.get(
      path: '/games/collection',
      queryParameters: {
        'page': '$page',
        'search': base64.encode(utf8.encode(searchQuery)).toString()
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
