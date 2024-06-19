import 'package:cubik_club/domain/entities/event.dart';
import 'package:cubik_club/domain/services/calendar_service.dart';
import 'package:cubik_club/domain/services/events_service.dart';
import 'package:cubik_club/ui/navigation/main_navigation.dart';
import 'package:cubik_club/utils/extensions/date_only_compare.dart';
import 'package:flutter/material.dart';

class _CalendarScreenViewModelState {
  final DateTime selectedDay;
  final DateTime focusedDay;
  final int currentEventIndex;
  final Map<DateTime, List<Event>> events;
  final Map<int, Event>? currentEventsList;

  _CalendarScreenViewModelState({
    required this.focusedDay,
    required this.selectedDay,
    this.events = const {},
    this.currentEventIndex = 0,
    this.currentEventsList,
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
  final _eventsService = EventsService();

  void updateState({
    DateTime? selectedDay,
    DateTime? focusedDay,
    int? currentEventIndex,
    Map<DateTime, List<Event>>? events,
    Map<int, Event>? currentEventsList,
    bool notify = true,
  }) {
    _state = _CalendarScreenViewModelState(
      selectedDay: selectedDay ?? _state.selectedDay,
      currentEventIndex: currentEventIndex ?? _state.currentEventIndex,
      focusedDay: focusedDay ?? _state.focusedDay,
      events: events ?? _state.events,
      currentEventsList: currentEventsList,
    );
    if (notify) {
      notifyListeners();
    }
  }

  Future<List<Map<dynamic, dynamic>>> loadCalendarEvents() async {
    return _calendarService.getCalendarEvents(state.focusedDay);
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

  void onCurrentEventChanged(int index) {
    updateState(currentEventIndex: index);
  }

  Future<void> onCurrentEventTap(BuildContext context, int currentId) async {
    try {
      final json = await _eventsService.getEventsListFromIds([currentId]);
      final event = Event.fromJson(json[0]);

      await MainNavigation.toEventScreen(context, event: event);
    } catch (e) {
      return;
    }
  }

  // Future<void> onCurrentEventTap(
  //     BuildContext context, List<Event> previewEvents, int currentId) async {
  //   if (state.currentEventsList != null) {
  //     final event = state.currentEventsList?[currentId];

  //     if (event == null) {
  //       return;
  //     } else {
  //       print('GOTO');
  //       MainNavigation.toEventcreen(context, event: event);
  //       return;
  //     }
  //   }

  //   List<int> idList = [];
  //   for (var event in previewEvents) {
  //     idList.add(event.id);
  //   }

  //   if (idList.isNotEmpty) {
  //     print('API CALL');
  //     final jsonList = await _eventsService.getEventsListFromIds(idList);
  //     final Map<int, Event> eventsMap = {};
  //     for (var elem in jsonList) {
  //       final event = Event.fromJson(elem);
  //       eventsMap[event.id] = event;
  //     }
  //     updateState(currentEventsList: eventsMap, notify: false);
  //     if (eventsMap[currentId] != null) {
  //       print('GOTO AFTER API CALL');
  //       MainNavigation.toEventcreen(context, event: eventsMap[currentId]!);
  //     }
  //   }
  // }
}
