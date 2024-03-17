import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cubik_club/domain/services/auth_service.dart';
import 'package:cubik_club/features/authentication/screens/account_create/widgets/account_create_step_one_page.dart';
import 'package:cubik_club/features/authentication/screens/account_create/widgets/account_create_step_three_page.dart';
import 'package:cubik_club/features/authentication/screens/account_create/widgets/account_create_step_two_page.dart';
import 'package:cubik_club/features/authentication/screens/account_create/widgets/account_create_verification_page.dart';
import 'package:cubik_club/features/authentication/view_models/account_create_view_model.dart';

enum _ViewModelStepsState { canNext, disable }

enum _ViewModelVerificationState { canSubmit, verificationProcess, disable }

class _ViewModelState {
  final String login;
  final String password;
  final String name;
  final String phone;
  final String clubName;
  final String surname;
  final String authErrorTitle;
  final bool isAuthProccess;

  _ViewModelState({
    this.login = '',
    this.password = '',
    this.authErrorTitle = '',
    this.phone = '',
    this.isAuthProccess = false,
    this.name = '',
    this.surname = '',
    this.clubName = '',
  });

  _ViewModelState copyWith({
    String? login,
    String? password,
    String? name,
    String? phone,
    String? clubName,
    String? surname,
    String? authErrorTitle,
    bool? isAuthProccess,
  }) {
    return _ViewModelState(
      login: login ?? this.login,
      password: password ?? this.password,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      clubName: clubName ?? this.clubName,
      surname: surname ?? this.surname,
      authErrorTitle: authErrorTitle ?? this.authErrorTitle,
      isAuthProccess: isAuthProccess ?? this.isAuthProccess,
    );
  }
}

class _ViewModel extends ChangeNotifier {
  final _authService = AuthService();

  var _state = _ViewModelState();
  _ViewModelState get state => _state;

  void updateState({
    String? login,
    String? password,
    String? authErrorTitle,
    String? phone,
    bool? isAuthProccess,
    String? name,
    String? surname,
    String? clubName,
  }) {
    _state = _state.copyWith(
      login: login ?? _state.login,
      password: password ?? _state.password,
      name: name ?? _state.name,
      surname: surname ?? _state.surname,
      phone: phone ?? _state.phone,
      isAuthProccess: isAuthProccess ?? _state.isAuthProccess,
      authErrorTitle: authErrorTitle ?? _state.authErrorTitle,
      clubName: clubName ?? _state.clubName,
    );
    notifyListeners();
  }

  bool validateStepOne() {
    final isEmpty = _state.name.isEmpty && _state.surname.isEmpty;
    if (isEmpty) return false;

    return true;
  }

  bool validateStepTwo() {
    final isEmpty = _state.name.isEmpty && _state.surname.isEmpty;
    if (isEmpty) return false;

    return true;
  }

  bool validateStepThree() {
    final isEmpty = _state.name.isEmpty && _state.surname.isEmpty;
    if (isEmpty) return false;

    return true;
  }

  bool validateVerification() {
    final isEmpty = _state.name.isEmpty && _state.surname.isEmpty;
    if (isEmpty) return false;

    return true;
  }

  void showInfoSnackBar(BuildContext context, {String message = ''}) {
    final snackBar = SnackBar(
      content: Text(message.isNotEmpty ? message : state.authErrorTitle),
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> onAuthButtonPressed(BuildContext context) async {
    final login = _state.login;
    final password = _state.password;

    if (login.isEmpty || password.isEmpty) return;
    // _state = _state.copyWith(authErrorTitle: '', isAuthProccess: true);
    notifyListeners();
//TODO: добавить другие ошибки, если есть (проверка на интернет и т.д.)
    try {
      // await _authService.login(login, password);
      // _state = _state.copyWith(
      //   isAuthProccess: false,
      // );
      notifyListeners();

      if (context.mounted) {
        showInfoSnackBar(context, message: 'Вы успешно вошли');
      }
      // TODO: переход в приложение
      // } on AuthApiProviderIncorrectLoginData {
      // _state = _state.copyWith(
      //   authErrorTitle: 'Неправильный логин или пароль',
      //   isAuthProccess: false,
      // );
      notifyListeners();

      if (context.mounted) showInfoSnackBar(context);
    } catch (exception) {
      // _state = _state.copyWith(
      //   authErrorTitle:
      //       'Случилась ошибка авторизации, попробуйте повторить позже',
      //   isAuthProccess: false,
      // );
      notifyListeners();

      if (context.mounted) showInfoSnackBar(context);
    }
  }
}

class AccountCreateScreen extends StatelessWidget {
  const AccountCreateScreen({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => AccountCreateViewModel(),
      child: const AccountCreateScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<AccountCreateViewModel>();
    return Scaffold(
      body: PageView(
        controller: viewModel.controller,
        onPageChanged: (index) => viewModel.updateCurrentPageIndex(index),
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          AccountCreateStepOnePage(),
          AccountCreateStepTwoPage(),
          AccountCreateStepThreePage(),
          AccountCreateVerificationPage(),
        ],
      ),
    );
  }
}
