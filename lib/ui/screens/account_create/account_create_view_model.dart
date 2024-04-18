import 'package:cubik_club/ui/screens/account_create/account_create_view_model_interface.dart';
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

class AccountCreateViewModel extends ChangeNotifier
    implements AccountCreateViewModelInteface {
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

// enum _ViewModelStepsState { canNext, disable }

// enum _ViewModelVerificationState { canSubmit, verificationProcess, disable }

// class _ViewModelState {
//   final String login;
//   final String password;
//   final String name;
//   final String phone;
//   final String clubName;
//   final String surname;
//   final String authErrorTitle;
//   final bool isAuthProccess;

//   _ViewModelState({
//     this.login = '',
//     this.password = '',
//     this.authErrorTitle = '',
//     this.phone = '',
//     this.isAuthProccess = false,
//     this.name = '',
//     this.surname = '',
//     this.clubName = '',
//   });

//   _ViewModelState copyWith({
//     String? login,
//     String? password,
//     String? name,
//     String? phone,
//     String? clubName,
//     String? surname,
//     String? authErrorTitle,
//     bool? isAuthProccess,
//   }) {
//     return _ViewModelState(
//       login: login ?? this.login,
//       password: password ?? this.password,
//       name: name ?? this.name,
//       phone: phone ?? this.phone,
//       clubName: clubName ?? this.clubName,
//       surname: surname ?? this.surname,
//       authErrorTitle: authErrorTitle ?? this.authErrorTitle,
//       isAuthProccess: isAuthProccess ?? this.isAuthProccess,
//     );
//   }
// }

// class _ViewModel extends ChangeNotifier {
//   final _authService = AuthService();

//   var _state = _ViewModelState();
//   _ViewModelState get state => _state;

//   void updateState({
//     String? login,
//     String? password,
//     String? authErrorTitle,
//     String? phone,
//     bool? isAuthProccess,
//     String? name,
//     String? surname,
//     String? clubName,
//   }) {
//     _state = _state.copyWith(
//       login: login ?? _state.login,
//       password: password ?? _state.password,
//       name: name ?? _state.name,
//       surname: surname ?? _state.surname,
//       phone: phone ?? _state.phone,
//       isAuthProccess: isAuthProccess ?? _state.isAuthProccess,
//       authErrorTitle: authErrorTitle ?? _state.authErrorTitle,
//       clubName: clubName ?? _state.clubName,
//     );
//     notifyListeners();
//   }

//   bool validateStepOne() {
//     final isEmpty = _state.name.isEmpty && _state.surname.isEmpty;
//     if (isEmpty) return false;

//     return true;
//   }

//   bool validateStepTwo() {
//     final isEmpty = _state.name.isEmpty && _state.surname.isEmpty;
//     if (isEmpty) return false;

//     return true;
//   }

//   bool validateStepThree() {
//     final isEmpty = _state.name.isEmpty && _state.surname.isEmpty;
//     if (isEmpty) return false;

//     return true;
//   }

//   bool validateVerification() {
//     final isEmpty = _state.name.isEmpty && _state.surname.isEmpty;
//     if (isEmpty) return false;

//     return true;
//   }

//   void showInfoSnackBar(BuildContext context, {String message = ''}) {
//     final snackBar = SnackBar(
//       content: Text(message.isNotEmpty ? message : state.authErrorTitle),
//     );
//     ScaffoldMessenger.of(context).hideCurrentSnackBar();
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }

//   Future<void> onAuthButtonPressed(BuildContext context) async {
//     final login = _state.login;
//     final password = _state.password;

//     if (login.isEmpty || password.isEmpty) return;
//     // _state = _state.copyWith(authErrorTitle: '', isAuthProccess: true);
//     notifyListeners();
// //TODO: добавить другие ошибки, если есть (проверка на интернет и т.д.)
//     try {
//       // await _authService.login(login, password);
//       // _state = _state.copyWith(
//       //   isAuthProccess: false,
//       // );
//       notifyListeners();

//       if (context.mounted) {
//         showInfoSnackBar(context, message: 'Вы успешно вошли');
//       }
//       // TODO: переход в приложение
//       // } on AuthApiProviderIncorrectLoginData {
//       // _state = _state.copyWith(
//       //   authErrorTitle: 'Неправильный логин или пароль',
//       //   isAuthProccess: false,
//       // );
//       notifyListeners();

//       if (context.mounted) showInfoSnackBar(context);
//     } catch (exception) {
//       // _state = _state.copyWith(
//       //   authErrorTitle:
//       //       'Случилась ошибка авторизации, попробуйте повторить позже',
//       //   isAuthProccess: false,
//       // );
//       notifyListeners();

//       if (context.mounted) showInfoSnackBar(context);
//     }
//   }
// }
