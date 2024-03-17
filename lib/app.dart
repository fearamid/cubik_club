import 'package:cubik_club/features/authentication/screens/account_create/account_create_screen.dart';
import 'package:cubik_club/features/authentication/screens/login/login_screen.dart';
import 'package:cubik_club/features/authentication/screens/onboarding/onboarding_screen.dart';
import 'package:cubik_club/ui/home_screen.dart';
import 'package:cubik_club/ui/loader_screen.dart';
import 'package:cubik_club/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: CCAppTheme.lightTheme,
      darkTheme: CCAppTheme.darkTheme,
      home: LoaderScreen.create(),
      routes: {
        'login': (_) => LoginScreen.create(),
        'onboarding': (_) => OnboardingScreen.create(),
        'account_create': (_) => AccountCreateScreen.create(),
        'home': (_) => HomeScreen.create(),
        'loader': (_) => LoaderScreen.create(),
      },
    );
  }
}
