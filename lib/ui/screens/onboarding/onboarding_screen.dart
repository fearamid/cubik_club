import 'package:cubik_club/ui/screens/onboarding/view_model/onboarding_screen_view_model.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import "package:cubik_club/utils/constants/image_strings.dart";
import "package:cubik_club/utils/constants/texts.dart";
import 'package:cubik_club/utils/device/device_utility.dart';
import 'package:cubik_club/utils/helpers/helper_functions.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<OnboardingScreenViewModel>();

    return Scaffold(
      body: Stack(
        children: [
          // Onboarding pages
          PageView(
            controller: viewModel.pageController,
            onPageChanged: (index) => viewModel.updatePageIndicator(index),
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
    );
  }
}

class _DotNavigation extends StatelessWidget {
  const _DotNavigation({super.key});

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

class _NextButton extends StatelessWidget {
  const _NextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: CCDeviceUtils.getBottomNavigationBarHeight(),
      right: 20,
      child: ElevatedButton(
        onPressed: () =>
            context.read<OnboardingScreenViewModel>().nextPage(context),
        style: ElevatedButton.styleFrom(shape: const CircleBorder()),
        child: const Icon(
          Icons.navigate_next,
          size: 45,
        ),
      ),
    );
  }
}

class _SkipButton extends StatelessWidget {
  const _SkipButton({super.key});

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

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({
    super.key,
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
        children: [
          SizedBox(
            height: CCDeviceUtils.getAppBarHeight() + 40,
          ),
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
