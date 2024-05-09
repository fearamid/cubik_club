import 'package:cubik_club/ui/common/components/export/components.dart';
import 'package:cubik_club/ui/screens/registration/registration_view_model.dart';

import 'package:cubik_club/utils/constants/image_strings.dart';
import 'package:cubik_club/utils/constants/texts.dart';
import 'package:cubik_club/utils/formatters/password_input_formatter.dart';
import 'package:cubik_club/utils/formatters/ru_phone_input_formatter.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StepThreePage extends StatelessWidget {
  const StepThreePage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RegistrationViewModel>();
    return SingleChildScrollView(
      child: AuthPageTemplate(
        image: CCImages.accountCreateStep3,
        title: CCTexts.accountCreateStep3Title,
        subtitle: CCTexts.accountCreateStep3SubTitle,
        mainAction: ElevatedButton(
          onPressed: () => viewModel.onContinueButtonPressed(context),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: double.infinity),
            child: const Text("Далее", textAlign: TextAlign.center),
          ),
        ),
        optionalAction: OutlinedButton(
          onPressed: () => viewModel.onBackButtonPressed(context),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: double.infinity),
            child: const Text("Назад", textAlign: TextAlign.center),
          ),
        ),
        body: [
          TextField(
            // onChanged: (phoneNumber) {
            //   viewModel.updateState(phoneNumber: phoneNumber);
            // },
            keyboardType: TextInputType.phone,
            inputFormatters: [
              RuPhoneInputFormatter(),
            ],
            decoration: const InputDecoration(
              labelText: 'Телефон',
            ),
          ),
          const SizedBox(height: 15),
          const PasswordTextField(),
          const SizedBox(height: 15),
          TextField(
            obscureText: true,
            inputFormatters: [PasswordInputFormatter()],
            decoration: const InputDecoration(
              labelText: 'Повторите пароль',
            ),
          ),
        ],
      ),
    );
  }
}
