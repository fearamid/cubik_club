import 'package:cubik_club/domain/api_clients/auth_api_client.dart';
import 'package:cubik_club/domain/entities/user.dart';
import 'package:cubik_club/domain/services/auth/auth_service.dart';
import 'package:cubik_club/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class _ViewModelState {
  final String login;
  final String password;
  final String repeatPassword;
  final String name;
  final String surname;
  final Genders gender;

  const _ViewModelState({
    this.login = '',
    this.password = '',
    this.repeatPassword = '',
    this.name = '',
    this.surname = '',
    this.gender = Genders.undefined,
  });

  //TODO: delete copyWith

  _ViewModelState copyWith({
    String? login,
    String? password,
    String? repeatPassword,
    String? name,
    String? surname,
    Genders? gender,
  }) {
    return _ViewModelState(
      login: login ?? this.login,
      password: password ?? this.password,
      repeatPassword: repeatPassword ?? this.repeatPassword,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      gender: gender ?? this.gender,
    );
  }
}

class RegistrationViewModel extends ChangeNotifier {
  var _state = const _ViewModelState();
  _ViewModelState get state => _state;

  final authService = AuthService();

  final PageController controller = PageController();
  final maxPageIndex = 1;
  int currentPageIndex = 0;

  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();

  void updateState({
    String? login,
    String? password,
    String? repeatPassword,
    String? name,
    String? surname,
    Genders? gender,
  }) {
    _state = state.copyWith(
      login: login?.toLowerCase(),
      password: password,
      repeatPassword: repeatPassword,
      name: name,
      surname: surname,
      gender: gender,
    );
    notifyListeners();
  }

  void updateCurrentPageIndex(int index) {
    currentPageIndex = index;
    notifyListeners();
  }

  void _toNextStep(BuildContext context, {void Function()? onRegistration}) {
    if (currentPageIndex == maxPageIndex) {
      if (!context.mounted) return;

      if (onRegistration == null) return;
      onRegistration();

      return;
    }

    int nextPage = (currentPageIndex + 1).toInt();
    controller.animateToPage(
      nextPage,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    if (!context.mounted) return;

    CCHelperFunctions.showSnackBar(
      context: context,
      message: message,
    );
  }

  void onContinueButtonPressed(BuildContext context) {
    final validator = isStepOneComplete();
    if (validator['complete']) {
      _toNextStep(context);
    } else {
      _showSnackBar(context, validator['error']);
    }
  }

  Future<void> onRegistrationButtonPressed(BuildContext context) async {
    final validator = isStepTwoComplete();
    if (validator['complete']) {
      final newUser = User(
        name: _state.name,
        surname: _state.surname,
        login: _state.login,
        gender: _state.gender,
      );

      try {
        await authService.registration(newUser, password: _state.password);
        _toNextStep(context, onRegistration: () {
          Navigator.pop(
              context, {"login": _state.login, "password": _state.password});
        });
      } catch (e) {
        String error = '$e';
        if (e is AuthApiClientError) error = e.error;
        _showSnackBar(context, error);
      }
    } else {
      _showSnackBar(context, validator['error']);
    }
  }

  void onGenderTabChanged(int tabIndex) {
    switch (tabIndex) {
      case 0:
        updateState(gender: Genders.male);
        break;
      case 1:
        updateState(gender: Genders.female);
        break;
      case 2:
        updateState(gender: Genders.undefined);
        break;
      default:
        updateState(gender: Genders.undefined);
        break;
    }
  }

  void onBackButtonPressed(BuildContext context) {
    if (currentPageIndex == 0) {
      Navigator.of(context).pop();
      return;
    }

    int page = (currentPageIndex - 1);
    controller.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Map<String, dynamic> isStepOneComplete() {
    bool complete = state.name.isNotEmpty && state.surname.isNotEmpty;
    Map<String, dynamic> result = {'complete': complete};

    if (!complete) {
      result.addAll({'error': 'Не все поля заполнены'});
    }

    return result;
  }

  Map<String, dynamic> isStepTwoComplete() {
    final login = state.login;
    final pass = state.password;
    final repPass = state.repeatPassword;
    Map<String, dynamic> result = {'complete': false};

    final allFilled = login.isNotEmpty && pass.isNotEmpty && repPass.isNotEmpty;
    if (!allFilled) {
      result.addAll({'error': 'Не все поля заполнены'});
      return result;
    }

    if (!(pass == repPass)) {
      result.addAll({'error': 'Пароли не совпадают'});
      return result;
    }

    result['complete'] = true;

    return result;
  }
}
