import 'package:cubik_club/ui/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

class OnboardingScreenViewModel extends ChangeNotifier {
  final pageController = PageController();
  int currentPageIndex = 0;

  void updatePageIndicator(int index) {
    currentPageIndex = index;
  }

  Future<void> nextPage(BuildContext context) async {
    if (currentPageIndex == 2) {
      await Navigator.of(context).pushReplacementNamed(Screens.login);
    } else {
      int page = currentPageIndex + 1;
      pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void skipPage() {
    currentPageIndex = 2;
    pageController.animateToPage(
      2,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
