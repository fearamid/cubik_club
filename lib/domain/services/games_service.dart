import 'package:cubik_club/domain/api_clients/games_api_client.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/games_collection/view_model/games_collection_screen_view_model.dart';

class GamesService {
  final _gamesApiClient = GamesApiClient();

  Future<Map<dynamic, dynamic>> getGamesCollection({
    int page = 1,
    String searchQuery = '',
    required GameCollectionFilters filters,
  }) async {
    return await _gamesApiClient.getGamesCollection(page, searchQuery, filters);
  }

  Future<Map<dynamic, dynamic>> getRandomGame() async {
    return await _gamesApiClient.getRandomGame();
  }
}
