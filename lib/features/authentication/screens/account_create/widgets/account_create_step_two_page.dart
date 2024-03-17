import 'package:cubik_club/common/widgets/auth_page_template.dart';

import 'package:cubik_club/features/authentication/view_models/account_create_view_model.dart';
import 'package:cubik_club/utils/constants/image_strings.dart';
import 'package:cubik_club/utils/constants/texts.dart';
import 'package:cubik_club/utils/formatters/club_name_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountCreateStepTwoPage extends StatelessWidget {
  const AccountCreateStepTwoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<AccountCreateViewModel>();
    return SingleChildScrollView(
      child: AuthPageTemplate(
        image: CCImages.accountCreateStep2,
        title: CCTexts.accountCreateStep2Title,
        subTitle: CCTexts.accountCreateStep2SubTitle,
        onFirstPressed: () => viewModel.onOptionalButtonPressed(context),
        onSecondPressed: () =>
            viewModel.onMainButtonPressed(currentStep: AccountCreateSteps.two),
        body: [
          const Text(CCTexts.accountCreateStep2Description),
          const SizedBox(height: 15),
          TextField(
            controller: viewModel.clubNameController,
            onChanged: (clubName) => viewModel.updateState(),
            inputFormatters: [
              ClubNameInputFormatter(),
            ],
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              labelText: 'Клубное имя',
            ),
          ),
        ],
      ),
    );
  }
}
