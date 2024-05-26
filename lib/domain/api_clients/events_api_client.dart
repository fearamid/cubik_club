import 'package:cubik_club/domain/api_clients/api_client.dart';

class EventsApiClient {
  static const String _basePath = "";

  final _apiClient = ApiClient();

  Future<List<Map<dynamic, dynamic>>> getRelevantEvents() async {
    final response = await _apiClient.get(
      path: '/events/relevant',
    );

    final events = (await ApiClient.getJson<List<dynamic>>(response))
        .map((e) => Map.from(e))
        .toList();

    return events;
  }
}
