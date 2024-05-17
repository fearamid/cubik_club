import 'package:cubik_club/domain/services/auth/auth_service.dart';
import 'package:cubik_club/ui/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

class LoaderScreenViewModel {
  final _authService = AuthService();
  BuildContext context;

  LoaderScreenViewModel(this.context) {
    initialize();
  }

  void initialize() async {
    try {
      final isAuth =
          await _authService.checkAuth().timeout(const Duration(seconds: 2));
      if (isAuth) {
        _goToAppScreen();
      } else {
        _goToOnboardingScreen();
      }
    } catch (e) {
      _goToOnboardingScreen();
    }
  }

  void _goToOnboardingScreen() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Screens.onboarding, (_) => false);
  }

  void _goToAppScreen() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Screens.appTabs, (_) => false);
  }
}
