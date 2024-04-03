import 'package:cubik_club/ui/screens/onboarding/onboarding_screen.dart';
import 'package:cubik_club/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingSkip extends StatelessWidget {
  const OnboardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: CCDeviceUtils.getAppBarHeight(),
      right: 10,
      child: TextButton(
        onPressed: context.read<OnboardingScreenViewModel>().skipPage,
        child: Text('в конец', style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }
}
