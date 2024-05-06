import 'package:cubik_club/ui/screens/registration/registration_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationBackButton extends StatelessWidget {
  const RegistrationBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RegistrationViewModel>();
    return OutlinedButton(
      onPressed: () => viewModel.onBackButtonPressed(context),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: double.infinity),
        child: const Text("Назад", textAlign: TextAlign.center),
      ),
    );
  }
}
