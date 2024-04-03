import 'package:flutter/material.dart';

class OnboardingScreenViewModel extends ChangeNotifier {
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
