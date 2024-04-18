import 'package:flutter/material.dart';

class AccountGroupViewModelState {
  final bool darkMode;

  const AccountGroupViewModelState({
    this.darkMode = true,
  });
}

class AccountGroupViewModel extends ChangeNotifier {
  var _state = const AccountGroupViewModelState();
  get state => _state;

  void updateState({
    bool? darkMode,
  }) {
    _state = AccountGroupViewModelState(
      darkMode: darkMode ?? _state.darkMode,
    );
    notifyListeners();
  }

  void onDarkModeToggle(bool newValue) {
    updateState(darkMode: newValue);
  }
}
