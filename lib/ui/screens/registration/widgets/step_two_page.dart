import 'package:cubik_club/ui/common/components/auth_page_template.dart';

import 'package:cubik_club/ui/screens/registration/registration_view_model.dart';
import 'package:cubik_club/utils/constants/image_strings.dart';
import 'package:cubik_club/utils/constants/texts.dart';
import 'package:cubik_club/utils/formatters/club_name_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StepTwoPage extends StatelessWidget {
  const StepTwoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RegistrationViewModel>();
    return SingleChildScrollView(
      child: AuthPageTemplate(
        image: CCImages.accountCreateStep2,
        title: CCTexts.accountCreateStep2Title,
        subtitle: CCTexts.accountCreateStep2SubTitle,
        mainAction: ElevatedButton(
          onPressed: () => viewModel.onStepOneContinueButtonPressed(),
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
          const Text(CCTexts.accountCreateStep2Description),
          const SizedBox(height: 15),
          TextField(
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
