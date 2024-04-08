import 'package:cubik_club/domain/entities/event.dart';
import 'package:flutter/material.dart';

class _CalendarScreenViewModelState {
  final DateTime? selectedDay;

  _CalendarScreenViewModelState({
    this.selectedDay,
  });
}

class CalendarScreenViewModel extends ChangeNotifier {
  var _state = _CalendarScreenViewModelState(selectedDay: DateTime.now());
  get state => _state;

  Map<DateTime, List<Event>> selectedEvents = {
    DateTime.utc(2024, 4, 7): [
      const Event(
        name: 'Томатная атака',
        description:
            'Устраиваем ковбойский вечер. Если вы готовы грабить караваны, стрелять с двух рук и носить шляпу, то ждем вас. Ждем вас!',
      ),
    ],
    DateTime.utc(2024, 4, 15): [
      const Event(
        name: 'Сырное лобби 1 СЫР СЫРНЫ',
        description:
            'Устраиваем ковбойский вечер. Если вы готовы грабить караваны, стрелять с двух рук и носить шляпу, то ждем вас. Ждем вас!',
      ),
      const Event(
        name: 'Сырное лобби 2',
        description:
            'Если вы готовы грабить караваны, стрелять с двух рук и носить шляпу, то ждем вас.',
      ),
      const Event(
        name: 'Сырное лобби 2',
        description:
            'Устраиваем ковбойский вечер. Если вы готовы грабить караваны, стрелять с двух рук и носить шляпу, то ждем вас. Ждем вас!',
      ),
    ],
    DateTime.utc(2024, 4, 20): [
      const Event(
        name: 'Встреча ковбоев',
        description:
            'Устраиваем ковбойский вечер. Если вы готовы грабить караваны, стрелять с двух рук и носить шляпу, то ждем вас. Ждем вас!',
      )
    ],
  };

  void updateState({
    DateTime? selectedDay,
    DateTime? focusedDay,
  }) {
    _state = _CalendarScreenViewModelState(
      selectedDay: selectedDay ?? _state.selectedDay,
    );
    notifyListeners();
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    updateState(selectedDay: selectedDay);
  }

  List<Event> eventsBuilder(DateTime day) {
    return selectedEvents[day] ?? [];
  }

  List<Event>? createCurrentDateEvent(DateTime date) {
    if (selectedEvents.containsKey(date)) {
      return selectedEvents[date];
    }
    return null;
  }
}
