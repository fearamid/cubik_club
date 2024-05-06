import 'package:cubik_club/domain/entities/user.dart';
import 'package:cubik_club/ui/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

class _ProfileScreenViewModelState {
  const _ProfileScreenViewModelState();
}

class ProfileScreenViewModel extends ChangeNotifier {
  var _state = const _ProfileScreenViewModelState();
  get state => _state;

  void updateState() {
    _state = const _ProfileScreenViewModelState();
    notifyListeners();
  }

  void onSettingsButtonPressed(BuildContext context) {
    MainNavigation.toSettingsScreen(context);
  }

  void onQrCodeButtonPressed(BuildContext context) {
    // TODO: change to User
    MainNavigation.toQrCodeScreen(
      context,
      entity: const User(
        name: 'Дмитрий',
        surname: 'Калашников',
        login: 'user_283471023',
        gender: Genders.male,
      ),
    );
  }

  void onFoldersButtonPressed(BuildContext context) {
    MainNavigation.toFoldersScreen(context);
  }
}
