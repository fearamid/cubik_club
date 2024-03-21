import 'package:cubik_club/features/authentication/screens/onboarding/onboarding_screen.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:cubik_club/utils/device/device_utility.dart';
import 'package:cubik_club/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingDotNavigation extends StatelessWidget {
  const OnboardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = CCHelperFunctions.isDarkMode(context);
    final viewModel = context.read<OnboardingScreenViewModel>();

    return Positioned(
      bottom: CCDeviceUtils.getBottomNavigationBarHeight() + 25,
      left: 30,
      child: SmoothPageIndicator(
        effect: WormEffect(
          activeDotColor: isDarkMode
              ? CCAppColors.lightBackground
              : CCAppColors.darkBackground,
          dotHeight: 12,
          dotWidth: 12,
          spacing: 20,
        ),
        controller: viewModel.pageController,
        onDotClicked: (index) => viewModel.dotNavigationClick(index),
        count: 3,
      ),
    );
  }
}
