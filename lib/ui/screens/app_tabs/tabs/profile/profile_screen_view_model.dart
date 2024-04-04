import 'dart:html';

import 'package:cubik_club/ui/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

class _ProfileScreenViewModelState {}

class ProfileScreenViewModel extends ChangeNotifier {
  var _state = _ProfileScreenViewModelState();
  get state => _state;

  void updateState() {
    _state = _ProfileScreenViewModelState();
    notifyListeners();
  }

  void onSettingsButtonPressed(BuildContext context) {
    Navigator.of(context).pushNamed(Screens.settings);
  }

  void onQrCodeButtonPressed(BuildContext context) {}
  void onCustomizeButtonPressed(BuildContext context) {}
  void onArchiveButtonPressed(BuildContext context) {}
}
