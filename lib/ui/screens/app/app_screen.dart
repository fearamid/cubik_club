import 'package:cubik_club/ui/screens/calendar/calendar_screen.dart';
import 'package:cubik_club/ui/screens/games_collection/games_collection_screen.dart';
import 'package:cubik_club/ui/screens/post/post_screen.dart';
import 'package:cubik_club/ui/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';

import 'package:cubik_club/domain/services/auth_service.dart';
import 'package:cubik_club/ui/screens/main/main_screen.dart';
import 'package:cubik_club/utils/constants/colors.dart';

class _ViewModelState {
  final int selectedPageIndex;

  _ViewModelState({
    this.selectedPageIndex = 2,
  });
}

class _ViewModel extends ChangeNotifier {
  _ViewModel();

  final _authService = AuthService();
  final _pageController = PageController(initialPage: 2);
  PageController get controller => _pageController;

  var _state = _ViewModelState();
  _ViewModelState get state => _state;

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

class AppScreen extends StatelessWidget {
  const AppScreen({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => _ViewModel(),
      child: const AppScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<_ViewModel>();
    final selectedPageIndex =
        context.watch<_ViewModel>().state.selectedPageIndex;
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: _AppBottomNavigation(pageIndex: selectedPageIndex),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: viewModel.controller,
        children: viewModel.bottomNavigationScreens,
      ),

      // const SizedBox(height: 20),
      // ElevatedButton(
      //   onPressed: () => viewModel.onLogoutButtonPressed(context),
      //   child: const Text('Выход'),
      // )
    );
  }
}

class _AppBottomNavigation extends StatelessWidget {
  final int pageIndex;
  const _AppBottomNavigation({
    Key? key,
    required this.pageIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<_ViewModel>();
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: CCAppColors.lightBackground,
          elevation: 1,
          currentIndex: pageIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: viewModel.onBottomNavigationBarTap,
          fixedColor: CCAppColors.primary,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Iconsax.grid_4_copy,
                size: 40,
                color: CCAppColors.lightHighlightBackground,
              ),
              activeIcon: Icon(Iconsax.grid_4, size: 40),
              label: 'Помощник',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Iconsax.clock_copy,
                size: 40,
                color: CCAppColors.lightHighlightBackground,
              ),
              activeIcon: Icon(Iconsax.clock, size: 40),
              label: 'События',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Iconsax.home_2_copy,
                size: 40,
                color: CCAppColors.lightHighlightBackground,
              ),
              activeIcon: Icon(Iconsax.home_2, size: 40),
              label: 'Главная',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Iconsax.copy_copy,
                size: 40,
                color: CCAppColors.lightHighlightBackground,
              ),
              activeIcon: Icon(Iconsax.copy, size: 40),
              label: 'Коллекция',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Iconsax.frame_1_copy,
                size: 40,
                color: CCAppColors.lightHighlightBackground,
              ),
              activeIcon: Icon(Iconsax.frame, size: 40),
              label: 'Профиль',
            ),
          ],
        ),
      ),
    );
  }
}
