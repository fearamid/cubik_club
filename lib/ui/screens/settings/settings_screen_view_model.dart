import 'package:cubik_club/domain/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class SettingsScreenViewModel extends ChangeNotifier {
  final _authService = AuthService();

  void onLogoutButtonPressed(BuildContext context) {
    _authService.logout();
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }
}
