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
    Navigator.of(context).pushNamed(Screens.settings);
  }

  void onQrCodeButtonPressed(BuildContext context) {
    // TODO: change to User
    Navigator.of(context).pushNamed(
      Screens.qrCode,
      arguments: const User(
        name: 'Дмитрий',
        surname: 'Калашников',
        id: 'user_283471023',
      ),
    );
  }

  void onCustomizeButtonPressed(BuildContext context) {}
  void onArchiveButtonPressed(BuildContext context) {}
}
