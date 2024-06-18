import 'dart:convert';

import 'package:cubik_club/domain/api_clients/api_client.dart';

class EventsApiClient {
  static const String _basePath = "";

  final _apiClient = ApiClient();

  Future<List<Map<dynamic, dynamic>>> getRelevantEvents(
      String searchQuery) async {
    final response = await _apiClient.get(
      path: '/events/relevant',
      queryParameters: {'search': base64.decode(searchQuery).toString()},
    );

    final events = (await ApiClient.getJson<List<dynamic>>(response))
        .map((e) => Map.from(e))
        .toList();

    return events;
  }

  Future<List<Map<dynamic, dynamic>>> getEventsReports(
      String searchQuery) async {
    final response = await _apiClient.get(
      path: '/events/reports',
      queryParameters: {'search': base64.decode(searchQuery).toString()},
    );

    final events = (await ApiClient.getJson<List<dynamic>>(response))
        .map((e) => Map.from(e))
        .toList();

    return events;
  }

  Future<List<Map<dynamic, dynamic>>> getEventsListFromIds(
      List<int> idList) async {
    final response = await _apiClient.get(
      path: '/events',
    );

    final events = (await ApiClient.getJson<List<dynamic>>(response))
        .map((e) => Map.from(e))
        .toList();

    return events;
  }
}
