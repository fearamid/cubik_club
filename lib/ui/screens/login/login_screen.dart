import 'package:cubik_club/ui/screens/login/login_screen_view_model.dart';
import 'package:cubik_club/utils/formatters/login_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cubik_club/ui/common/components/auth_page_template.dart';
import 'package:cubik_club/ui/common/components/single/password_text_field.dart';
import 'package:cubik_club/ui/screens/login/widgets/login_with.dart';
import 'package:cubik_club/utils/constants/image_strings.dart';
import 'package:cubik_club/utils/constants/texts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<LoginScreenViewModel>();

    return Scaffold(
      body: SingleChildScrollView(
        child: AuthPageTemplate(
          image: CCImages.loginImage,
          title: CCTexts.loginHeaderTitle,
          subtitle: CCTexts.loginHeaderSubTitle,
          isActionsHorizontal: false,
          mainAction: const _MainActionButton(),
          optionalAction: const _OptionalActionButton(),
          marginBodyBottom: 40,
          body: [
            TextField(
              controller: viewModel.loginController,
              onChanged: (text) => viewModel.updateState(login: text),
              inputFormatters: [
                LoginInputFormatter(),
              ],
              decoration: const InputDecoration(
                labelText: 'Логин',
              ),
            ),
            const SizedBox(height: 15),
            PasswordTextField(
              controller: viewModel.passwordController,
              onChanged: (text) => viewModel.updateState(password: text),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}

class _MainActionButton extends StatelessWidget {
  const _MainActionButton();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<LoginScreenViewModel>();

    final authButtonState = context
        .select((LoginScreenViewModel value) => value.state.authButtonState);

    final onAuthButtonPressed =
        authButtonState == LoginScreenAuthButonState.canSubmit
            ? () async {
                await viewModel.onLoginButtonPressed(context);
              }
            : null;

    return ElevatedButton(
      onPressed: onAuthButtonPressed,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: double.infinity),
        child: const Text("Войти", textAlign: TextAlign.center),
      ),
    );
  }
}

class _OptionalActionButton extends StatelessWidget {
  const _OptionalActionButton();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<LoginScreenViewModel>();
    return OutlinedButton(
      onPressed: () => viewModel.onRegistrationButtonPressed(context),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: double.infinity),
        child: const Text("Создать аккаунт", textAlign: TextAlign.center),
      ),
    );
  }
}

class _VkLoginButton extends LoginWithButton {
  _VkLoginButton()
      : super(
          icon: Icons.circle_notifications_rounded,
          onPressed: () {
            //TODO: Vk auth
          },
        );
}

class _GoogleLoginButton extends LoginWithButton {
  _GoogleLoginButton()
      : super(
          icon: Icons.circle_notifications_rounded,
          onPressed: () {
            //TODO: Google auth
          },
        );
}


// TODO: сделать это всё в одном виджете (используется только тут, зачем универсальность extraActions?)

      //  extraActions: [
      //       const SizedBox(height: 15),
      //       LoginWith(
      //         children: [
      //           _VkLoginButton(),
      //           _GoogleLoginButton(),
      //         ],
      //       ),
      //     ],


                // Align(
            //   alignment: Alignment.centerRight,
            //   child: TextButton(
            //     onPressed: () =>
            //         viewModel.onForgotPasswordButtonPressed(context),
            //     child: const Text('Забыли пароль?'),
            //   ),
            // ),