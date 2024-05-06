import 'package:cubik_club/domain/entities/user.dart';
import 'package:flutter/material.dart';

class _ViewModelState {
  final String login;
  final String password;
  final String name;
  final String surname;
  final Genders gender;

  const _ViewModelState({
    this.login = '',
    this.password = '',
    this.name = '',
    this.surname = '',
    this.gender = Genders.undefined,
  });

  _ViewModelState copyWith({
    String? login,
    String? password,
    String? name,
    String? surname,
    Genders? gender,
  }) {
    return _ViewModelState(
      login: login ?? this.login,
      password: password ?? this.password,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      gender: gender ?? this.gender,
    );
  }
}

class RegistrationViewModel extends ChangeNotifier {
  var _state = const _ViewModelState();
  get state => _state;
  // final AccountCreateService service = AccountCreateService();

  final PageController controller = PageController();
  int currentPageIndex = 0;

  void updateState({
    String? name,
    String? surname,
    String? password,
    String? clubName,
  }) {
    _state = _state.copyWith(
      name: name,
      surname: surname,
      password: password,
    );
    notifyListeners();
  }

  void updateCurrentPageIndex(int index) {
    currentPageIndex = index;
    notifyListeners();
  }

  void onStepOneContinueButtonPressed() {
    // if (!_canActionOnMain(currentStep)) return;

    if (currentPageIndex == 3) {
      // TODO: To next page action
      return;
    }

    int page = (currentPageIndex + 1).toInt();
    controller.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void onBackButtonPressed(BuildContext context) {
    if (currentPageIndex == 0) {
      Navigator.of(context).pop();
      return;
    }

    int page = (currentPageIndex - 1).toInt();
    controller.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  bool isStepOneComplete() {
    bool isComplete = _state.name.isNotEmpty && _state.surname.isNotEmpty;

    return isComplete;
  }

  bool isStepTwoComplete() {
    return true;
  }

  bool isStepThreeComplete() {
    return true;
  }

  bool isVerificationComplete() {
    return true;
  }
}
