import 'package:cubik_club/ui/common/components/auth_page_template.dart';
import 'package:cubik_club/ui/screens/registration/registration_view_model.dart';
import 'package:cubik_club/ui/screens/registration/widgets/back_button.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:cubik_club/utils/constants/image_strings.dart';
import 'package:cubik_club/utils/constants/texts.dart';
import 'package:cubik_club/utils/formatters/cyrillic_only_input_formatter.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

class StepOnePage extends StatelessWidget {
  const StepOnePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: SafeArea(
        child: AuthPageTemplate(
          image: CCImages.accountCreateStep1,
          title: CCTexts.accountCreateStep1Title,
          subtitle: CCTexts.accountCreateStep1SubTitle,
          mainAction: _ContinueButton(),
          optionalAction: RegistrationBackButton(),
          body: [
            _NameInputField(),
            SizedBox(height: 20),
            _SurnameInputField(),
            SizedBox(height: 20),
            _GenderSwitch(),
          ],
        ),
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  const _ContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RegistrationViewModel>();
    return ElevatedButton(
      onPressed: () => viewModel.onStepOneContinueButtonPressed(),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: double.infinity),
        child: const Text("Далее", textAlign: TextAlign.center),
      ),
    );
  }
}

class _NameInputField extends StatelessWidget {
  const _NameInputField({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RegistrationViewModel>();
    return TextField(
      onChanged: (name) => viewModel.updateState(name: name),
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      inputFormatters: [
        LengthLimitingTextInputFormatter(25),
        CyrillicOnlyInputFormatter(),
      ],
      decoration: const InputDecoration(
        labelText: 'Имя',
      ),
    );
  }
}

class _SurnameInputField extends StatelessWidget {
  const _SurnameInputField({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RegistrationViewModel>();
    return TextField(
      onChanged: (surname) => viewModel.updateState(surname: surname),
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      inputFormatters: [
        LengthLimitingTextInputFormatter(30),
        CyrillicOnlyInputFormatter(),
      ],
      decoration: const InputDecoration(
        labelText: 'Фамилия',
      ),
    );
  }
}

class _GenderSwitch extends StatelessWidget {
  const _GenderSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RegistrationViewModel>();
    final selectedValue = context.watch<RegistrationViewModel>().state.login;
    return Column(
      children: [
        Text('fsd'),
      ],
    );
  }
}
