import 'package:cubik_club/ui/common/widgets/auth_page_template.dart';
import 'package:cubik_club/ui/common/widgets/components/password_text_field.dart';
import 'package:cubik_club/ui/screens/account_create/account_create_view_model.dart';

import 'package:cubik_club/utils/constants/image_strings.dart';
import 'package:cubik_club/utils/constants/texts.dart';
import 'package:cubik_club/utils/formatters/password_input_formatter.dart';
import 'package:cubik_club/utils/formatters/ru_phone_input_formatter.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountCreateStepThreePage extends StatelessWidget {
  const AccountCreateStepThreePage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<AccountCreateViewModel>();
    return SingleChildScrollView(
      child: AuthPageTemplate(
        image: CCImages.accountCreateStep3,
        title: CCTexts.accountCreateStep3Title,
        subtitle: CCTexts.accountCreateStep3SubTitle,
        mainAction: ElevatedButton(
          onPressed: () => viewModel.onMainButtonPressed(
              currentStep: AccountCreateSteps.three),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: double.infinity),
            child: const Text("Далее", textAlign: TextAlign.center),
          ),
        ),
        optionalAction: OutlinedButton(
          onPressed: () => viewModel.onOptionalButtonPressed(context),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: double.infinity),
            child: const Text("Назад", textAlign: TextAlign.center),
          ),
        ),
        body: [
          TextField(
            controller: viewModel.phoneNumberController,
            onChanged: (phoneNumber) {
              viewModel.updateState(phoneNumber: phoneNumber);
            },
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
            controller: viewModel.repeatPasswordController,
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
