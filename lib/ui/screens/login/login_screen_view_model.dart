import 'package:cubik_club/domain/data_providers/auth_api_provider.dart';
import 'package:cubik_club/domain/services/auth_service.dart';
import 'package:cubik_club/ui/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

enum LoginScreenAuthButonState { canSubmit, authProcess, disable }

class _LoginScreenViewModelState {
  final String login;
  final String password;
  final String authErrorText;
  final bool isAuthProccess;

  LoginScreenAuthButonState get authButtonState {
    if (isAuthProccess) {
      return LoginScreenAuthButonState.authProcess;
    } else if (login.isNotEmpty && password.isNotEmpty) {
      return LoginScreenAuthButonState.canSubmit;
    } else {
      return LoginScreenAuthButonState.disable;
    }
  }

  //TODO: clear values
  const _LoginScreenViewModelState({
    this.login = 'admin',
    this.password = '1234',
    this.authErrorText = '',
    this.isAuthProccess = false,
  });
}

class LoginScreenViewModel extends ChangeNotifier {
  final _authService = AuthService();

  var _state = const _LoginScreenViewModelState();
  get state => _state;

  void updateState({
    String? login,
    String? password,
    String? authErrorText,
    bool? isAuthProccess,
  }) {
    _state = _LoginScreenViewModelState(
      login: login ?? _state.login,
      password: password ?? _state.password,
      isAuthProccess: isAuthProccess ?? _state.isAuthProccess,
      authErrorText: authErrorText ?? _state.authErrorText,
    );
    notifyListeners();
  }

  void _showSnackBar(BuildContext context, {String message = ''}) {
    final snackBar = SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(message.isNotEmpty ? message : state.authErrorText));
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> onAuthButtonPressed(BuildContext context) async {
    final login = _state.login;
    final password = _state.password;

    if (login.isEmpty || password.isEmpty) return;
    updateState(authErrorText: '', isAuthProccess: true);
//TODO: добавить другие ошибки, если есть (проверка на интернет и т.д.)
    try {
      await _authService.login(login, password);
      updateState(isAuthProccess: false);
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Screens.appTabs, (route) => false);
      // TODO: переход в приложение
    } on AuthApiProviderIncorrectLoginData {
      updateState(
        authErrorText: 'Неправильный логин или пароль',
        isAuthProccess: false,
      );
      _showSnackBar(context);
    } catch (exception) {
      updateState(
        authErrorText:
            'Случилась ошибка авторизации, попробуйте повторить позже',
        isAuthProccess: false,
      );
      _showSnackBar(context);
    }
  }

  Future<void> onAccounCreateButtonPressed(BuildContext context) async {
    // TODO: right action or link?
    await Navigator.of(context).pushNamed('/account_create');
  }

  Future<void> onForgotPasswordButtonPressed(BuildContext context) async {
    // TODO: right action or link?
    // await Navigator.of(context).pushNamed('/forgot_password');
  }

  Future<void> onVkAuthButtonPressed() async {
    // TODO: vk auth
  }

  Future<void> onGoogleAuthButtonPressed() async {
    // TODO: google auth
  }

  Future<void> onTelegramAuthButtonPressed() async {
    // TODO: telegram auth
  }
}
