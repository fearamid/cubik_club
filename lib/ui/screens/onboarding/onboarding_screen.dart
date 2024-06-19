import 'package:cubik_club/ui/screens/onboarding/view_model/onboarding_screen_view_model.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import "package:cubik_club/utils/constants/image_strings.dart";
import "package:cubik_club/utils/constants/texts.dart";
import 'package:cubik_club/utils/device/device_utility.dart';
import 'package:cubik_club/utils/helpers/helper_functions.dart';
import "package:flutter/material.dart";
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<OnboardingScreenViewModel>();

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Onboarding pages
            PageView(
              controller: viewModel.pageController,
              onPageChanged: viewModel.updatePageIndicator,
              children: const [
                _OnboardingPage(
                  image: CCImages.onBoardingImage1,
                  title: CCTexts.onBoardingTitle1,
                  subtitle: CCTexts.onBoardingSubTitle1,
                ),
                _OnboardingPage(
                  image: CCImages.onBoardingImage2,
                  title: CCTexts.onBoardingTitle2,
                  subtitle: CCTexts.onBoardingSubTitle2,
                ),
                _OnboardingPage(
                  image: CCImages.onBoardingImage3,
                  title: CCTexts.onBoardingTitle3,
                  subtitle: CCTexts.onBoardingSubTitle3,
                ),
              ],
            ),

            // Skip Button
            const _SkipButton(),

            // Dot Navigation
            const _DotNavigation(),

            // Action Button
            const _NextButton()
          ],
        ),
      ),
    );
  }
}

class _DotNavigation extends StatelessWidget {
  const _DotNavigation();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = CCHelperFunctions.isDarkMode(context);
    final viewModel = context.read<OnboardingScreenViewModel>();

    return Positioned(
      bottom: CCDeviceUtils.getBottomNavigationBarHeight() + 25,
      left: 30,
      child: SmoothPageIndicator(
        effect: WormEffect(
          dotColor: CCAppColors.lightHighlightBackground,
          activeDotColor:
              isDarkMode ? CCAppColors.lightBackground : CCAppColors.primary,
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

class _NextButton extends StatelessWidget {
  const _NextButton();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: CCDeviceUtils.getBottomNavigationBarHeight(),
      right: 20,
      child: TextButton(
        onPressed: () =>
            context.read<OnboardingScreenViewModel>().nextPage(context),
        style: TextButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(15),
        ),
        child: const Icon(
          Iconsax.arrow_right_3_copy,
          size: 40,
        ),
      ),
    );
  }
}

class _SkipButton extends StatelessWidget {
  const _SkipButton();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30,
      right: 20,
      child: TextButton(
        onPressed: context.read<OnboardingScreenViewModel>().skipPage,
        child: Text(
          'Пропустить',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image, title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 0,
        right: 20,
        left: 20,
        top: 100,
      ),
      child: Column(
        children: [
          Image(
            width: CCHelperFunctions.screenHeight(context),
            // height: CCHelperFunctions.screenHeight(context) * 0.6,
            image: AssetImage(image),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
