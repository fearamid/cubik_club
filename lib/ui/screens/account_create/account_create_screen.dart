import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cubik_club/ui/screens/account_create/widgets/account_create_step_one_page.dart';
import 'package:cubik_club/ui/screens/account_create/widgets/account_create_step_three_page.dart';
import 'package:cubik_club/ui/screens/account_create/widgets/account_create_step_two_page.dart';
import 'package:cubik_club/ui/screens/account_create/widgets/account_create_verification_page.dart';
import 'package:cubik_club/ui/screens/account_create/account_create_view_model.dart';

class AccountCreateScreen extends StatelessWidget {
  const AccountCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<AccountCreateViewModel>();
    return Scaffold(
      body: PageView(
        controller: viewModel.controller,
        onPageChanged: (index) => viewModel.updateCurrentPageIndex(index),
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          AccountCreateStepOnePage(),
          AccountCreateStepTwoPage(),
          AccountCreateStepThreePage(),
          AccountCreateVerificationPage(),
        ],
      ),
    );
  }
}
