import 'package:cubik_club/domain/api_clients/events_api_client.dart';

class EventsService {
  final _eventsApiClient = EventsApiClient();

  Future<List<Map<dynamic, dynamic>>> getRelevantEvents() async {
    final events = await _eventsApiClient.getRelevantEvents();
    return events;
  }
}
