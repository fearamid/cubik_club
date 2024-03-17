import 'package:cubik_club/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:cubik_club/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:cubik_club/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:cubik_club/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import "package:cubik_club/utils/constants/image_strings.dart";
import "package:cubik_club/utils/constants/texts.dart";
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class ViewModel extends ChangeNotifier {
  final pageController = PageController();
  int currentPageIndex = 0;

  void updatePageIndicator(int index) {
    currentPageIndex = index;
  }

  // Jump to the specific dot selected page
  void dotNavigationClick(int index) {
    currentPageIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // Update Current Index & Jump to next page
  Future<void> nextPage(BuildContext context) async {
    if (currentPageIndex == 2) {
      // Навигация к следующим страницам после анбординга
      await Navigator.of(context).pushReplacementNamed('/login');
    } else {
      int page = currentPageIndex + 1;
      pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Update Current Index & jump to the last page
  void skipPage() {
    currentPageIndex = 2;
    pageController.animateToPage(
      2,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (context) => ViewModel(),
      lazy: false,
      child: const OnboardingScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Onboarding pages
          PageView(
            controller: context.read<ViewModel>().pageController,
            onPageChanged: (index) =>
                context.read<ViewModel>().updatePageIndicator(index),
            children: const [
              OnboardingPage(
                image: CCImages.onBoardingImage1,
                title: CCTexts.onBoardingTitle1,
                subtitle: CCTexts.onBoardingSubTitle1,
              ),
              OnboardingPage(
                image: CCImages.onBoardingImage2,
                title: CCTexts.onBoardingTitle2,
                subtitle: CCTexts.onBoardingSubTitle2,
              ),
              OnboardingPage(
                image: CCImages.onBoardingImage3,
                title: CCTexts.onBoardingTitle3,
                subtitle: CCTexts.onBoardingSubTitle3,
              ),
            ],
          ),

          // Skip Button
          const OnboardingSkip(),

          // Dot Navigation
          const OnboardingDotNavigation(),

          // Action Button
          const OnboardingNextButton()
        ],
      ),
    );
  }
}
