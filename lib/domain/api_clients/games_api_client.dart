import 'package:cubik_club/domain/api_clients/api_client.dart';

class GamesApiClient {
  static const String _basePath = "";

  final _apiClient = ApiClient();

  Future<Map<dynamic, dynamic>> getGamesCollection({int page = 1}) async {
    final response = await _apiClient.get(path: '/games/collection');
    final games = (await ApiClient.getJson<Map<dynamic, dynamic>>(response));
    return games;
  }
}
