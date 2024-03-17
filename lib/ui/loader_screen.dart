import 'package:cubik_club/domain/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class _ViewModel {
  final _authService = AuthService();
  BuildContext context;

  _ViewModel(this.context) {
    initialize();
  }

  void initialize() async {
    final isAuth = await _authService.checkAuth();
    if (isAuth) {
      _goToAppScreen();
    } else {
      _goToLoginScreen();
    }
  }

  void _goToLoginScreen() {
    Navigator.of(context).pushNamedAndRemoveUntil('login', (route) => false);
  }

  void _goToAppScreen() {
    Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);
  }
}

class LoaderScreen extends StatelessWidget {
  const LoaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     themeMode: ThemeMode.light,
  //     theme: CCAppTheme.lightTheme,
  //     darkTheme: CCAppTheme.darkTheme,
  //     routes: {
  //       '/': (_) => LoginScreen.create(),
  //       // '/': (_) => OnboardingScreen.create(),
  //       '/account_create': (_) => AccountCreateScreen.create(),
  //     },
  //   );
  // }

  static Widget create() {
    return Provider(
      create: (context) => _ViewModel(context),
      lazy: false,
      child: const LoaderScreen(),
    );
  }
}
