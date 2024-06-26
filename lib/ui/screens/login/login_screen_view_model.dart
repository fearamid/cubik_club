import 'package:cubik_club/domain/api_clients/auth_api_client.dart';
import 'package:cubik_club/domain/services/auth/auth_service.dart';
import 'package:cubik_club/ui/navigation/main_navigation.dart';
import 'package:cubik_club/utils/helpers/helper_functions.dart';
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

  const _LoginScreenViewModelState({
    this.login = '',
    this.password = '',
    this.authErrorText = '',
    this.isAuthProccess = false,
  });
}

class LoginScreenViewModel extends ChangeNotifier {
  final _authService = AuthService();

  var _state = const _LoginScreenViewModelState();
  get state => _state;

  final loginController = TextEditingController();
  final passwordController = TextEditingController();

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

  void _showSnackBar(BuildContext context, {String? message}) {
    if (!context.mounted) return;

    CCHelperFunctions.showSnackBar(
      context: context,
      message: message,
      replaceMessage: state.authErrorText,
    );
  }

  Future<void> onLoginButtonPressed(BuildContext context) async {
    final login = _state.login;
    final password = _state.password;

    if (login.isEmpty || password.isEmpty) return;
    updateState(authErrorText: '', isAuthProccess: true);

    try {
      await _authService.login(login, password);
      updateState(isAuthProccess: false);
      await MainNavigation.toAppTabsScreen(context);
    } catch (e) {
      final String errorText;

      if (e is AuthApiClientError) {
        errorText = e.error;
      } else {
        print(e);
        errorText = e.toString();
        // errorText = 'Случилась ошибка авторизации, попробуйте повторить позже';
      }

      updateState(
        authErrorText: errorText,
        isAuthProccess: false,
      );
      _showSnackBar(context);
    }
  }

  Future<void> onRegistrationButtonPressed(BuildContext context) async {
    final result = await MainNavigation.toRegistrationScreen(context);
    if (result == null && result! is Map<String, String>) return;
    final login = result['login'].isNotEmpty ? result['login'] : '';
    final password = result['password'].isNotEmpty ? result['password'] : '';

    updateState(
      login: login,
      password: password,
    );

    loginController.text = login;
    passwordController.text = password;
  }

  //TODO: добавить другие ошибки, если есть (проверка на интернет и т.д.)

  Future<void> onForgotPasswordButtonPressed(BuildContext context) async {
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
