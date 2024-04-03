import 'package:cubik_club/domain/services/auth_service.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/calendar/calendar_screen.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/games_collection/games_collection_screen.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/main/main_screen.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class _ViewModelState {
  final int selectedPageIndex;

  _ViewModelState({
    this.selectedPageIndex = 2,
  });
}

class AppTabsViewModel extends ChangeNotifier {
  AppTabsViewModel();

  final _authService = AuthService();
  final _pageController = PageController(initialPage: 2);
  PageController get controller => _pageController;

  var _state = _ViewModelState();
  get state => _state;

  final List<Widget> bottomNavigationScreens = [
    const Center(child: Text('Помощник приложения')),
    CalendarScreen.create(),
    MainScreen.create(),
    GamesCollectionScreen.create(),
    ProfileScreen.create(),
  ];

  void updateState({
    int? selectedPageIndex,
  }) {
    _state = _ViewModelState(
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
