import 'package:cubik_club/ui/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

class _MainScreenViewModelState {}

class MainScreenViewModel extends ChangeNotifier {
  var _state = _MainScreenViewModelState();
  get state => _state;

  void onQrScannerButtonPressed(BuildContext context) {
    Navigator.of(context).pushNamed(Screens.scanner);
  }

  void onSliderPageChanged(int index) {}
}
