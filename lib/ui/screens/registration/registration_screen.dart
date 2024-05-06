import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cubik_club/ui/screens/registration/widgets/step_one_page.dart';
import 'package:cubik_club/ui/screens/registration/widgets/step_two_page.dart';
import 'package:cubik_club/ui/screens/registration/registration_view_model.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RegistrationViewModel>();
    return PageView(
      controller: viewModel.controller,
      onPageChanged: (index) => viewModel.updateCurrentPageIndex(index),
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        StepOnePage(),
        StepTwoPage(),
        // AccountCreateStepThreePage(),
        // AccountCreateVerificationPage(),
      ],
    );
  }
}
