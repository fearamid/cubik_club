import 'package:cubik_club/domain/services/auth/auth_service.dart';
import 'package:cubik_club/ui/screen_factory/screen_factory.dart';
import 'package:flutter/material.dart';

class _AppTabsViewModelState {
  final int selectedPageIndex;

  _AppTabsViewModelState({
    this.selectedPageIndex = 2,
  });
}

class AppTabsViewModel extends ChangeNotifier {
  AppTabsViewModel();

  final _authService = AuthService();
  final _pageController = PageController(initialPage: 2);
  PageController get controller => _pageController;

  var _state = _AppTabsViewModelState();
  get state => _state;

  final List<Widget> bottomNavigationScreens = [
    const Center(child: Text('Помощник')),
    ScreenFactory().makeCalendar(),
    ScreenFactory().makeMain(),
    ScreenFactory().makeGamesCollection(),
    ScreenFactory().makeProfile(),
  ];

  void updateState({
    int? selectedPageIndex,
  }) {
    _state = _AppTabsViewModelState(
      selectedPageIndex: selectedPageIndex ?? _state.selectedPageIndex,
    );
    notifyListeners();
  }

  onBottomNavigationBarTap(int index) {
    if (_state.selectedPageIndex == index) return;
    updateState(selectedPageIndex: index);

    controller.jumpToPage(_state.selectedPageIndex);
  }

  Future<void> onLogoutButtonPressed(BuildContext context) async {
    await _authService.logout();
    Navigator.of(context).pushNamedAndRemoveUntil('/loader', (route) => false);
  }
}
