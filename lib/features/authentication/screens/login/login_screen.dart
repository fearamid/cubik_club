import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cubik_club/common/widgets/auth_page_template.dart';
import 'package:cubik_club/common/widgets/password_text_field.dart';
import 'package:cubik_club/domain/data_providers/auth_api_provider.dart';
import 'package:cubik_club/domain/services/auth_service.dart';
import 'package:cubik_club/features/authentication/screens/login/widgets/login_with.dart';
import 'package:cubik_club/utils/constants/image_strings.dart';
import 'package:cubik_club/utils/constants/texts.dart';
import 'package:cubik_club/utils/formatters/ru_phone_input_formatter.dart';

enum _ViewModelAuthButonState { canSubmit, authProcess, disable }

class _ViewModelState {
  final String login;
  final String password;
  final String authErrorText;
  final bool isAuthProccess;

  _ViewModelAuthButonState get authButtonState {
    if (isAuthProccess) {
      return _ViewModelAuthButonState.authProcess;
    } else if (login.isNotEmpty && password.isNotEmpty) {
      return _ViewModelAuthButonState.canSubmit;
    } else {
      return _ViewModelAuthButonState.disable;
    }
  }

  _ViewModelState({
    this.login = '',
    this.password = '',
    this.authErrorText = '',
    this.isAuthProccess = false,
  });
}

class _ViewModel extends ChangeNotifier {
  final _authService = AuthService();

  var _state = _ViewModelState();
  _ViewModelState get state => _state;

  void _updateState({
    String? login,
    String? password,
    String? authErrorText,
    bool? isAuthProccess,
  }) {
    _state = _ViewModelState(
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
    _updateState(authErrorText: '', isAuthProccess: true);
//TODO: добавить другие ошибки, если есть (проверка на интернет и т.д.)
    try {
      await _authService.login(login, password);
      _updateState(isAuthProccess: false);
      Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);
      // TODO: переход в приложение
    } on AuthApiProviderIncorrectLoginData {
      _updateState(
        authErrorText: 'Неправильный логин или пароль',
        isAuthProccess: false,
      );
      _showSnackBar(context);
    } catch (exception) {
      _updateState(
        authErrorText:
            'Случилась ошибка авторизации, попробуйте повторить позже',
        isAuthProccess: false,
      );
      _showSnackBar(context);
    }
  }

  Future<void> onAccounCreateButtonPressed(BuildContext context) async {
    // TODO: right action or link?
    await Navigator.of(context).pushNamed('account_create');
  }

  Future<void> onForgotPasswordButtonPressed(BuildContext context) async {
    // TODO: right action or link?
    // await Navigator.of(context).pushNamed('/forgot_password');
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => _ViewModel(),
      child: const LoginScreen(),
    );
  }

// dfsfss
  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<_ViewModel>();
    final authButtonState =
        context.select((_ViewModel value) => value.state.authButtonState);

    final onAuthButtonPressed =
        authButtonState == _ViewModelAuthButonState.canSubmit
            ? () => viewModel.onAuthButtonPressed(context)
            : null;

    return Scaffold(
      body: SingleChildScrollView(
        child: AuthPageTemplate(
          image: CCImages.loginImage,
          title: CCTexts.loginHeaderTitle,
          subtitle: CCTexts.loginHeaderSubTitle,
          isActionsHorizontal: false,
          mainAction: ElevatedButton(
            onPressed: onAuthButtonPressed,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: double.infinity),
              child: const Text("Войти", textAlign: TextAlign.center),
            ),
          ),
          optionalAction: OutlinedButton(
            onPressed: () => viewModel.onAccounCreateButtonPressed(context),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: double.infinity),
              child: const Text("Создать аккаунт", textAlign: TextAlign.center),
            ),
          ),
          marginBodyBottom: 40,
          body: [
            TextField(
              keyboardType: TextInputType.emailAddress,
              inputFormatters: [
                // RuPhoneInputFormatter(),
              ],
              onChanged: (text) => viewModel._updateState(login: text),
              // viewModel.changeLogin,
              decoration: const InputDecoration(
                labelText: 'Телефон или email',
              ),
            ),
            const SizedBox(height: 15),
            PasswordTextField(
                onChanged: (text) => viewModel._updateState(password: text)),
            const SizedBox(height: 5),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () =>
                    viewModel.onForgotPasswordButtonPressed(context),
                child: const Text('Забыли пароль?'),
              ),
            ),
          ],
          extraActions: [
            const SizedBox(height: 15),
            LoginWith(
              children: [
                LoginWithButton(
                  icon: Icons.circle_notifications_rounded,
                  onPressed: () {
                    //TODO: Google auth
                  },
                ),
                LoginWithButton(
                  icon: Icons.circle_notifications_rounded,
                  onPressed: () {
                    //TODO: VK auth
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
