import 'package:cubik_club/domain/api_clients/games_api_client.dart';

class GamesService {
  final _gamesApiClient = GamesApiClient();

  Future<Map<dynamic, dynamic>> getGamesCollection(
      {int page = 1, String searchQuery = ''}) async {
    return await _gamesApiClient.getGamesCollection(page, searchQuery);
  }

  Future<Map<dynamic, dynamic>> getRandomGame() async {
    return await _gamesApiClient.getRandomGame();
  }
}
