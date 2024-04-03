import 'package:cubik_club/ui/screens/account_create/account_create_screen.dart';
import 'package:cubik_club/ui/screens/account_create/account_create_view_model.dart';
import 'package:cubik_club/ui/screens/app_tabs/app_tabs.dart';
import 'package:cubik_club/ui/screens/app_tabs/app_tabs_view_model.dart';
import 'package:cubik_club/ui/screens/loader/loader_screen.dart';
import 'package:cubik_club/ui/screens/loader/loader_screen_view_model.dart';
import 'package:cubik_club/ui/screens/login/login_screen.dart';
import 'package:cubik_club/ui/screens/login/login_screen_view_model.dart';
import 'package:cubik_club/ui/screens/navigation_error/navigation_error_screen.dart';
import 'package:cubik_club/ui/screens/onboarding/onboarding_screen.dart';
import 'package:cubik_club/ui/screens/onboarding/onboarding_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenFactory {
  Widget makeAccountCreate() {
    return ChangeNotifierProvider(
      create: (_) => AccountCreateViewModel(),
      child: const AccountCreateScreen(),
    );
  }

  Widget makeAppTabs() {
    return ChangeNotifierProvider(
      create: (_) => AppTabsViewModel(),
      child: const AppTabs(),
    );
  }

  Widget makeLoader() {
    return Provider(
      create: (context) => LoaderScreenViewModel(context),
      lazy: false,
      child: const LoaderScreen(),
    );
  }

  Widget makeLogin() {
    return ChangeNotifierProvider(
      create: (_) => LoginScreenViewModel(),
      child: const LoginScreen(),
    );
  }

  Widget makeOnboarding() {
    return ChangeNotifierProvider(
      create: (context) => OnboardingScreenViewModel(),
      lazy: false,
      child: const OnboardingScreen(),
    );
  }

  Widget makeNavigationError() {
    return const NavigationErrorScreen();
  }
}
