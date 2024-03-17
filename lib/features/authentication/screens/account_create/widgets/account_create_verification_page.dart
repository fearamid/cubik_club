import 'package:cubik_club/common/widgets/auth_page_template.dart';
import 'package:cubik_club/features/authentication/view_models/account_create_view_model.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:cubik_club/utils/constants/image_strings.dart';
import 'package:cubik_club/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

class AccountCreateVerificationPage extends StatelessWidget {
  const AccountCreateVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<AccountCreateViewModel>();
    return SingleChildScrollView(
      child: AuthPageTemplate(
        image: CCImages.accountCreateVerification,
        title: CCTexts.accountCreateVerificationTitle,
        subTitle:
            '${CCTexts.accountCreateVerificationSubTitle}\n${viewModel.state.phoneNumber}',
        secondActionTitle: 'Подтвердить',
        onFirstPressed: () => viewModel.onOptionalButtonPressed(context),
        onSecondPressed: () => viewModel.onMainButtonPressed(
            currentStep: AccountCreateSteps.verification),
        body: [
          PinCodeTextField(
            appContext: context,
            length: 4,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            animationType: AnimationType.none,
            textStyle: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: CCAppColors.secondary),
            pinTheme: PinTheme(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              fieldHeight: 70,
              fieldWidth: 70,
              shape: PinCodeFieldShape.box,
              inactiveColor: CCAppColors.lightHighlightBackground,
              activeColor: CCAppColors.accentGreen,
              selectedColor: CCAppColors.accentBlue,
              errorBorderColor: CCAppColors.primary,
            ),
          ),
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
    );
  }
}
