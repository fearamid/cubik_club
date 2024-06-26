import 'package:cubik_club/ui/common/components/auth_page_template.dart';
import 'package:cubik_club/ui/screens/registration/registration_view_model.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:cubik_club/utils/constants/image_strings.dart';
import 'package:cubik_club/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<RegistrationViewModel>();
    return SingleChildScrollView(
      child: SafeArea(
        child: AuthPageTemplate(
          image: CCImages.accountCreateVerification,
          title: CCTexts.accountCreateVerificationTitle,
          // '${CCTexts.accountCreateVerificationSubTitle}\n${viewModel.state.phoneNumber}'
          subtitle: 'Any subtitle...',
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
            // PinCodeTextField(
            //   appContext: context,
            //   length: 4,
            //   keyboardType: TextInputType.number,
            //   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            //   animationType: AnimationType.none,
            //   textStyle: const TextStyle(
            //       fontSize: 25,
            //       fontWeight: FontWeight.w600,
            //       color: CCAppColors.secondary),
            //   pinTheme: PinTheme(
            //     borderRadius: const BorderRadius.all(Radius.circular(20)),
            //     fieldHeight: 70,
            //     fieldWidth: 70,
            //     shape: PinCodeFieldShape.box,
            //     inactiveColor: CCAppColors.lightHighlightBackground,
            //     activeColor: CCAppColors.accentGreen,
            //     selectedColor: CCAppColors.accentBlue,
            //     errorBorderColor: CCAppColors.primary,
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Не приходит SMS?'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Отправить еще раз'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
