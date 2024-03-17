import 'package:cubik_club/features/authentication/screens/onboarding/onboarding_screen.dart';
import 'package:cubik_club/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingNextButton extends StatelessWidget {
  const OnboardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: CCDeviceUtils.getBottomNavigationBarHeight(),
      right: 20,
      child: ElevatedButton(
        onPressed: () => context.read<ViewModel>().nextPage(context),
        style: ElevatedButton.styleFrom(shape: const CircleBorder()),
        child: const Icon(
          Icons.navigate_next,
          size: 45,
        ),
      ),
    );
  }
}
