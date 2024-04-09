import 'package:flutter/material.dart';

class AccounGroupViewModelState {
  final bool darkMode;

  const AccounGroupViewModelState({
    this.darkMode = true,
  });
}

class AccounGroupViewModel extends ChangeNotifier {
  var _state = const AccounGroupViewModelState();
  get state => _state;

  void updateState({
    bool? darkMode,
  }) {
    _state = AccounGroupViewModelState(
      darkMode: darkMode ?? _state.darkMode,
    );
    notifyListeners();
  }

  void onDarkModeToggle(bool newValue) {
    updateState(darkMode: newValue);
  }
}
