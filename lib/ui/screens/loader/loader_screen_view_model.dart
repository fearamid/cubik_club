import 'package:cubik_club/domain/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class LoaderScreenViewModel {
  final _authService = AuthService();
  BuildContext context;

  LoaderScreenViewModel(this.context) {
    initialize();
  }

  void initialize() async {
    final isAuth = await _authService.checkAuth();
    if (isAuth) {
      _goToAppScreen();
    } else {
      _goToLoginScreen();
    }
  }

  void _goToLoginScreen() {
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (_) => false);
  }

  void _goToAppScreen() {
    Navigator.of(context).pushNamedAndRemoveUntil('/app_tabs', (_) => false);
  }
}
