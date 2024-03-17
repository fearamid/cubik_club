import 'package:flutter/material.dart';

enum AccountCreateSteps { one, two, three, verification }

@immutable
class _ViewModelState {
  final String name;
  final String surname;
  final String email;
  final String phoneNumber;
  final String password;
  final String clubName;

  const _ViewModelState({
    this.name = '',
    this.surname = '',
    this.email = '',
    this.phoneNumber = '',
    this.password = '',
    this.clubName = '',
  });

  _ViewModelState copyWith({
    String? name,
    String? surname,
    String? email,
    String? phoneNumber,
    String? password,
    String? clubName,
  }) {
    return _ViewModelState(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      clubName: clubName ?? this.clubName,
    );
  }
}

class AccountCreateViewModel extends ChangeNotifier {
  var state = const _ViewModelState();
  // final AccountCreateService service = AccountCreateService();

  final PageController controller = PageController();
  int currentPageIndex = 0;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController clubNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();

  void updateState({
    String? name,
    String? surname,
    String? email,
    String? phoneNumber,
    String? password,
    String? clubName,
  }) {
    state = state.copyWith(
      name: name,
      surname: surname,
      email: email,
      phoneNumber: phoneNumber,
      password: password,
      clubName: clubName,
    );
    notifyListeners();
  }

  void updateCurrentPageIndex(int index) {
    currentPageIndex = index;
    notifyListeners();
  }

  void onMainButtonPressed({required AccountCreateSteps currentStep}) {
    if (!_canActionOnMain(currentStep)) return;

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

  void onOptionalButtonPressed(BuildContext context) {
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

  bool _canActionOnMain(AccountCreateSteps step) {
    bool canAction = false;
    switch (step) {
      case AccountCreateSteps.one:
        canAction = isStepOneComplete();
        break;
      case AccountCreateSteps.two:
        canAction = isStepTwoComplete();
        break;
      case AccountCreateSteps.three:
        canAction = isStepThreeComplete();
        break;
      case AccountCreateSteps.verification:
        canAction = isVerificationComplete();
        break;
      default:
        break;
    }
    return canAction;
  }

  bool isStepOneComplete() {
    return true;
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
