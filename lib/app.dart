import 'package:cubik_club/ui/navigation/main_navigation.dart';
import 'package:cubik_club/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    MainNavigation navigation = MainNavigation();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: CCAppTheme.lightTheme,
      darkTheme: CCAppTheme.darkTheme,
      routes: navigation.routes,
      initialRoute: Screens.loader,
      onGenerateRoute: (RouteSettings settings) =>
          navigation.onGenerateRoute(settings),
    );
  }
}
