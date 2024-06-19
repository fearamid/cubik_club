import 'package:cubik_club/domain/api_clients/api_client.dart';
import 'package:cubik_club/domain/entities/promotion.dart';

class PromotionsApiClient {
  static const String _basePath = "";

  final _apiClient = ApiClient();

  Future<List<Promotion>> getPromotions() async {
    final response = await _apiClient.get(
      path: '/promotions',
    );

    final jsons = (await ApiClient.getJson<List<dynamic>>(response))
        .map((e) => Map.from(e))
        .toList();

    List<Promotion>? promotions = [];
    for (var json in jsons) {
      try {
        promotions.add(Promotion.fromJson(json));
      } catch (e) {}
    }

    return promotions;
  }
}
