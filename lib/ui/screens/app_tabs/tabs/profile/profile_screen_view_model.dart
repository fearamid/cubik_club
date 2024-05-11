import 'package:cubik_club/domain/entities/user.dart';
import 'package:cubik_club/domain/services/user/user_service.dart';
import 'package:cubik_club/ui/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

class _ProfileScreenViewModelState {
  final User user;
  const _ProfileScreenViewModelState({
    required this.user,
  });
}

class ProfileScreenViewModel extends ChangeNotifier {
  _ProfileScreenViewModelState get state => _state;
  var _state = _ProfileScreenViewModelState(user: User.empty());

  ProfileScreenViewModel() {}

  void updateState({
    User? user,
  }) {
    _state = _ProfileScreenViewModelState(
      user: user ?? _state.user,
    );
    notifyListeners();
  }

  Future<User> getUserDataAsync() async {
    final User user = await UserService().getUserDataFromAccessToken();
    // updateState(user: user);
    return user;
  }

  void onSettingsButtonPressed(BuildContext context) {
    MainNavigation.toSettingsScreen(context);
  }

  void onQrCodeButtonPressed(BuildContext context) {
    // TODO: change to User
    MainNavigation.toQrCodeScreen(
      context,
      entity: state.user,
    );
  }

  void onFoldersButtonPressed(BuildContext context) {
    MainNavigation.toFoldersScreen(context);
  }
}
