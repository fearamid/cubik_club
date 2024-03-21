import 'package:cubik_club/features/authentication/screens/account_create/account_create_screen.dart';
import 'package:cubik_club/features/authentication/screens/login/login_screen.dart';
import 'package:cubik_club/features/authentication/screens/onboarding/onboarding_screen.dart';
import 'package:cubik_club/ui/app_screen.dart';
import 'package:cubik_club/ui/loader_screen.dart';
import 'package:cubik_club/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: CCAppTheme.lightTheme,
      darkTheme: CCAppTheme.darkTheme,
      // home: LoaderScreen.create(),
      routes: {
        '/login': (_) => LoginScreen.create(),
        '/onboarding': (_) => OnboardingScreen.create(),
        '/account_create': (_) => AccountCreateScreen.create(),
        '/main': (_) => AppScreen.create(),
        '/loader': (_) => LoaderScreen.create(),
      },
      initialRoute: '/loader',
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Произошла ошибка навигации.'),
                  const SizedBox(height: 30),
                  OutlinedButton(
                      onPressed: () {
                        final canPop = Navigator.of(context).canPop();
                        if (canPop) {
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text('Назад'))
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
