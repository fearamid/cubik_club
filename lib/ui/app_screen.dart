import 'package:cubik_club/domain/services/auth_service.dart';
import 'package:cubik_club/ui/main_screen.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:cubik_club/utils/constants/icons.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class _ViewModelState {
  final int selectedPageIndex;

  _ViewModelState({
    this.selectedPageIndex = 2,
  });
}

class _ViewModel extends ChangeNotifier {
  final _authService = AuthService();

  final List<Widget> widgetOptions = const [
    Center(child: Text('Помощник')),
    Center(child: Text('Календарь событий')),
    MainScreen(),
    Center(child: Text('Коллекция настольных игр')),
    Center(child: Text('Профиль')),
  ];

  var _state = _ViewModelState();
  _ViewModelState get state => _state;

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
      bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            // boxShadow: [
            //   BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            // ],
          ),
          child: ClipRRect(
              borderRadius: const SmoothBorderRadius.only(
                topLeft: SmoothRadius(cornerRadius: 35, cornerSmoothing: 0.7),
                topRight: SmoothRadius(cornerRadius: 35, cornerSmoothing: 0.7),
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: CCAppColors.lightBackground,
                elevation: 1,
                currentIndex: selectedPageIndex,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                onTap: viewModel.onBottomNavigationBarTap,
                fixedColor: CCAppColors.primary,
                items: [
                  BottomNavigationBarItem(
                    icon: Image.asset(CCAppIcons.helper, height: 40),
                    activeIcon:
                        Image.asset(CCAppIcons.helperActive, height: 40),
                    label: 'Помощник',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(CCAppIcons.calendar, height: 40),
                    activeIcon:
                        Image.asset(CCAppIcons.calendarActive, height: 40),
                    label: 'События',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(CCAppIcons.main, height: 40),
                    activeIcon: Image.asset(CCAppIcons.mainActive, height: 40),
                    label: 'Главная',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(CCAppIcons.gamesCollection, height: 40),
                    activeIcon: Image.asset(CCAppIcons.gamesCollectionActive,
                        height: 40),
                    label: 'Коллекция',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(CCAppIcons.profile, height: 40),
                    activeIcon:
                        Image.asset(CCAppIcons.profileActive, height: 40),
                    label: 'Профиль',
                  ),
                ],
              ))),
      body: viewModel.widgetOptions[selectedPageIndex],
      // const SizedBox(height: 20),
      // ElevatedButton(
      //   onPressed: () => viewModel.onLogoutButtonPressed(context),
      //   child: const Text('Выход'),
      // )
    );
  }
}
