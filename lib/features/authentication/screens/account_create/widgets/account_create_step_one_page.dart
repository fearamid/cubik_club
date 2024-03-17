import 'package:cubik_club/common/widgets/auth_page_template.dart';
import 'package:cubik_club/features/authentication/view_models/account_create_view_model.dart';
import 'package:cubik_club/utils/constants/image_strings.dart';
import 'package:cubik_club/utils/constants/texts.dart';
import 'package:cubik_club/utils/formatters/cyrillic_only_input_formatter.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

class AccountCreateStepOnePage extends StatelessWidget {
  const AccountCreateStepOnePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<AccountCreateViewModel>();
    return SingleChildScrollView(
      child: AuthPageTemplate(
        image: CCImages.accountCreateStep1,
        title: CCTexts.accountCreateStep1Title,
        subTitle: CCTexts.accountCreateStep1SubTitle,
        isActionsHorizontal: true,
        onFirstPressed: () => viewModel.onOptionalButtonPressed(context),
        onSecondPressed: () =>
            viewModel.onMainButtonPressed(currentStep: AccountCreateSteps.one),
        body: [
          TextField(
            controller: viewModel.nameController,
            onChanged: (name) => viewModel.updateState(name: name),
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            inputFormatters: [
              LengthLimitingTextInputFormatter(15),
              CyrillicOnlyInputFormatter(),
            ],
            decoration: const InputDecoration(
              labelText: 'Имя',
            ),
          ),
          const SizedBox(height: 19),
          TextField(
            controller: viewModel.surnameController,
            onChanged: (surname) => viewModel.updateState(surname: surname),
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            inputFormatters: [
              LengthLimitingTextInputFormatter(25),
              CyrillicOnlyInputFormatter(),
            ],
            decoration: const InputDecoration(
              labelText: 'Фамилия',
            ),
          ),
        ],
      ),
    );
  }
}
