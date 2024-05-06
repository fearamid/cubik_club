import 'package:cubik_club/ui/common/components/components.dart';

import 'package:cubik_club/ui/screens/registration/registration_view_model.dart';
import 'package:cubik_club/ui/screens/registration/widgets/back_button.dart';
import 'package:cubik_club/utils/constants/image_strings.dart';
import 'package:cubik_club/utils/constants/texts.dart';
import 'package:cubik_club/utils/formatters/login_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class StepTwoPage extends StatelessWidget {
  const StepTwoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RegistrationViewModel>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: AuthPageTemplate(
            image: CCImages.accountCreateStep2,
            title: CCTexts.accountCreateStep2Title,
            subtitle: CCTexts.accountCreateStep2SubTitle,
            mainAction: const _RegistrationButton(),
            optionalAction: const RegistrationBackButton(),
            body: [
              const _LoginInputField(),
              const SizedBox(height: 20),
              PasswordTextField(
                controller: viewModel.passwordController,
                onChanged: (password) =>
                    viewModel.updateState(password: password),
              ),
              const SizedBox(height: 20),
              PasswordTextField(
                controller: viewModel.repeatPasswordController,
                onChanged: (password) =>
                    viewModel.updateState(repeatPassword: password),
                obscureButton: false,
                label: 'Повторите пароль',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginInputField extends StatelessWidget {
  const _LoginInputField();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RegistrationViewModel>();
    return TextField(
      controller: viewModel.loginController,
      onChanged: (login) => viewModel.updateState(login: login),
      keyboardType: TextInputType.name,
      inputFormatters: [
        LengthLimitingTextInputFormatter(25),
        LoginInputFormatter()
      ],
      decoration: const InputDecoration(
        labelText: 'Логин',
      ),
    );
  }
}

class _RegistrationButton extends StatelessWidget {
  const _RegistrationButton();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RegistrationViewModel>();
    return ElevatedButton(
      onPressed: () => viewModel.onRegistrationButtonPressed(context),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: double.infinity),
        child: const Text("Создать", textAlign: TextAlign.center),
      ),
    );
  }
}
