import 'package:cubik_club/domain/entities/event.dart';
import 'package:cubik_club/domain/services/calendar_service.dart';
import 'package:cubik_club/utils/extensions/date_only_compare.dart';
import 'package:flutter/material.dart';

class _CalendarScreenViewModelState {
  final DateTime selectedDay;
  final DateTime focusedDay;
  final int currentEventIndex;
  final Map<DateTime, List<Event>> events;

  _CalendarScreenViewModelState({
    required this.focusedDay,
    required this.selectedDay,
    this.events = const {},
    this.currentEventIndex = 0,
  });
}

class CalendarScreenViewModel extends ChangeNotifier {
  late _CalendarScreenViewModelState _state;
  _CalendarScreenViewModelState get state => _state;

  CalendarScreenViewModel() {
    _state = _CalendarScreenViewModelState(
      selectedDay: DateTime.now(),
      focusedDay: DateTime.now(),
    );
  }

  final _calendarService = CalendarService();

  void updateState({
    DateTime? selectedDay,
    DateTime? focusedDay,
    int? currentEventIndex,
    Map<DateTime, List<Event>>? events,
  }) {
    _state = _CalendarScreenViewModelState(
      selectedDay: selectedDay ?? _state.selectedDay,
      currentEventIndex: currentEventIndex ?? _state.currentEventIndex,
      focusedDay: focusedDay ?? _state.focusedDay,
      events: events ?? _state.events,
    );
    notifyListeners();
  }

  Future<List<Map<dynamic, dynamic>>> loadCalendarEvents() async {
    return _calendarService.getCalendarEvents(state.focusedDay);
  }

  Future<void> onPageChanged(DateTime focusedDay) async {
    updateState(focusedDay: focusedDay);
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    updateState(selectedDay: selectedDay);
  }

  List<Event> eventLoader(DateTime day) {
    List<Event>? events;
    _state.events.forEach((key, value) {
      if (key.isSameDate(day)) {
        events = _state.events[key];
      }
    });

    return events ?? [];
  }

  Event parseEvent(Map<dynamic, dynamic>? json) {
    if (json == null) {
      throw Error();
    }

    return Event.calendarPreview(
        id: json['id'],
        coverLink: json['cover_link'],
        startDateTime: DateTime.parse('${json['tstz_range'][0]}'),
        endDateTime: DateTime.parse('${json['tstz_range'][1]}'),
        title: json['title']);
  }

  void addEventsMap(List<Map<dynamic, dynamic>> eventsList) {
    try {
      Map<DateTime, List<Event>> markersMap = {};
      for (var elem in eventsList) {
        final event = parseEvent(elem);

        if (markersMap[event.startDateTime] == null) {
          markersMap[event.startDateTime] = [event];
        } else {
          markersMap[event.startDateTime]?.add(event);
        }
      }

      _state = _CalendarScreenViewModelState(
        focusedDay: _state.focusedDay,
        selectedDay: _state.selectedDay,
        events: markersMap,
      );
    } catch (e) {
      print(e);
    }
  }

  List<Event>? getCurrentDateEventsList(DateTime selectedDay) {
    List<Event>? events = [];
    state.events.forEach((key, value) {
      if (key.isSameDate(selectedDay)) {
        events.addAll(value);
      }
    });

    return events;
  }

  void onCurrentEventChange(int index) {
    updateState(currentEventIndex: index);
  }
}
