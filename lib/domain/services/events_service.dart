import 'package:cubik_club/domain/api_clients/events_api_client.dart';

class EventsService {
  final _eventsApiClient = EventsApiClient();

  Future<List<Map<dynamic, dynamic>>> getRelevantEvents(
      String searchQuery) async {
    return await _eventsApiClient.getRelevantEvents(searchQuery);
  }

  Future<List<Map<dynamic, dynamic>>> getEventsReports(
      String searchQuery) async {
    return await _eventsApiClient.getEventsReports(searchQuery);
  }

  Future<List<Map<dynamic, dynamic>>> getEventsListFromIds(
      List<int> idList) async {
    return await _eventsApiClient.getEventsListFromIds(idList);
  }
}
