import 'package:flutter/material.dart';

class _CalendarScreenViewModelState {}

class CalendarScreenViewModel extends ChangeNotifier {
  var _state = _CalendarScreenViewModelState();
  get state => _state;

  void updateState() {
    _state = _CalendarScreenViewModelState();
    notifyListeners();
  }
}
