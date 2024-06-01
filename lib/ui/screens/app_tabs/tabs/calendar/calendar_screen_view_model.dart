import 'package:cubik_club/domain/entities/event.dart';
import 'package:flutter/material.dart';

class _CalendarScreenViewModelState {
  final DateTime? selectedDay;
  final int currentEventIndex;

  _CalendarScreenViewModelState({
    this.selectedDay,
    this.currentEventIndex = 0,
  });
}

class CalendarScreenViewModel extends ChangeNotifier {
  var _state = _CalendarScreenViewModelState(selectedDay: DateTime.now());
  get state => _state;

  Map<DateTime, List<Event>> events = {
    DateTime.utc(2024, 4, 7): [
      Event(
        title: 'Томатная атака',
        description:
            'Устраиваем ковбойский вечер. Если вы готовы грабить караваны, стрелять с двух рук и носить шляпу, то ждем вас. Ждем вас!',
        coverLink: '',
        startDateTime: DateTime.now(),
        endDateTime: DateTime.now(),
      ),
    ],
    DateTime.utc(2024, 4, 15): [
      Event(
        title: 'Сырное лобби',
        description:
            'Устраиваем ковбойский вечер. Если вы готовы грабить караваны, стрелять с двух рук и носить шляпу, то ждем вас. Ждем вас!',
        coverLink: '',
        startDateTime: DateTime.now(),
        endDateTime: DateTime.now(),
      ),
      Event(
        title: 'Мышеловка',
        description:
            'Если вы готовы грабить караваны, стрелять с двух рук и носить шляпу, то ждем вас.',
        coverLink: '',
        startDateTime: DateTime.now(),
        endDateTime: DateTime.now(),
      ),
      Event(
        title: 'Чеддер пати',
        description:
            'Устраиваем ковбойский вечер. Если вы готовы грабить караваны, стрелять с двух рук и носить шляпу, то ждем вас. Ждем вас!',
        coverLink: '',
        startDateTime: DateTime.now(),
        endDateTime: DateTime.now(),
      ),
    ],
    DateTime.utc(2024, 4, 20): [
      Event(
        title: 'Встреча ковбоев',
        description:
            'Устраиваем ковбойский вечер. Если вы готовы грабить караваны, стрелять с двух рук и носить шляпу, то ждем вас. Ждем вас!',
        coverLink: '',
        startDateTime: DateTime.now(),
        endDateTime: DateTime.now(),
      )
    ],
  };

  void updateState({
    DateTime? selectedDay,
    DateTime? focusedDay,
    int? currentEventIndex,
  }) {
    _state = _CalendarScreenViewModelState(
      selectedDay: selectedDay ?? _state.selectedDay,
      currentEventIndex: currentEventIndex ?? _state.currentEventIndex,
    );
    notifyListeners();
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    updateState(selectedDay: selectedDay);
  }

  List<Event> eventsBuilder(DateTime day) {
    return events[day] ?? [];
  }

  List<Event>? getCurrentDateEventsList(DateTime date) {
    if (events.containsKey(date)) {
      return events[date];
    }
    return null;
  }

  void onCurrentEventChange(int index) {
    updateState(currentEventIndex: index);
  }
}
