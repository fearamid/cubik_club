import 'package:cubik_club/domain/api_clients/events_api_client.dart';

class EventsService {
  final _eventsApiClient = EventsApiClient();

  Future<List<Map<dynamic, dynamic>>> getRelevantEvents() async {
    return await _eventsApiClient.getRelevantEvents();
  }

  Future<List<Map<dynamic, dynamic>>> getEventsReports() async {
    return await _eventsApiClient.getEventsReports();
  }

  Future<List<Map<dynamic, dynamic>>> getEventsListFromIds(
      List<int> idList) async {
    return await _eventsApiClient.getEventsListFromIds(idList);
  }
}
