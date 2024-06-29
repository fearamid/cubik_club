import 'package:cubik_club/ui/common/components/export/components.dart';
import 'package:cubik_club/ui/screens/onboarding/view_model/onboarding_screen_view_model.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import "package:cubik_club/utils/constants/image_strings.dart";
import "package:cubik_club/utils/constants/texts.dart";
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

            // const _SkipButton(),

            const _DotNavigation(),

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
      bottom: 10 + (30 - 5),
      left: 20,
      child: SmoothPageIndicator(
        effect: WormEffect(
          dotColor: CCAppColors.lightHighlightBackground,
          activeDotColor:
              isDarkMode ? CCAppColors.lightBackground : CCAppColors.primary,
          dotHeight: 10,
          dotWidth: 10,
          spacing: 20,
        ),
        controller: viewModel.pageController,
        count: 3,
      ),
    );
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton();

  @override
  Widget build(BuildContext context) {
    final onPressed = context.read<OnboardingScreenViewModel>().nextPage;

    return Positioned(
      bottom: 10,
      right: 20,
      child: CustomIconButton(
        onPressed: () => onPressed(context),
        icon: Iconsax.arrow_right_3_copy,
        size: 40,
        color: CCAppColors.primary,
        padding: const EdgeInsets.only(left: 10, right: 0, top: 10, bottom: 10),
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
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: AssetImage(image)),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
