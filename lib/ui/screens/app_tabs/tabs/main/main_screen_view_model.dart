import 'package:cubik_club/ui/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

class _MainScreenViewModelState {
  const _MainScreenViewModelState();
}

class MainScreenViewModel extends ChangeNotifier {
  var _state = const _MainScreenViewModelState();
  get state => _state;

  void onQrScannerButtonPressed(BuildContext context) {
    Navigator.of(context).pushNamed(Screens.scanner);
  }

  void onSliderPageChanged(int index) {}

  void onTabPressed(int tab) {}

  void onFiltersPressed() {}

  Future<void> onRefreshPage() async {}
}
