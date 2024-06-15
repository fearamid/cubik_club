import 'package:cubik_club/domain/api_clients/calendar_api_client.dart';

class CalendarService {
  final _calendarApiClient = CalendarApiClient();

  Future<List<Map<dynamic, dynamic>>> getCalendarEvents(DateTime date) async {
    return await _calendarApiClient.getCalendarEventsList(date);
  }
}
