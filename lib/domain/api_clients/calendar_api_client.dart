import 'package:cubik_club/domain/api_clients/api_client.dart';

class CalendarApiClient {
  static const String _basePath = "";

  final _apiClient = ApiClient();

  Future<List<Map<dynamic, dynamic>>> getCalendarEventsList(
      DateTime date) async {
    final formattedDate = '${date.year}-${date.month}-${date.day}';

    final response = await _apiClient.get(path: '/calendar', queryParameters: {
      "date": formattedDate,
    });

    final events = (await ApiClient.getJson<List<dynamic>>(response))
        .map((e) => Map.from(e))
        .toList();

    return events;
  }
}
