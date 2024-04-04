import 'package:cubik_club/ui/screen_factory/screen_factory.dart';
import 'package:flutter/material.dart';

abstract class Screens {
  static const login = '/login';
  static const onboarding = "/onboarding";
  static const accountCreate = "/account_create";
  static const appTabs = "/app_tabs";
  static const loader = "/loader";
  static const navigationError = "/navigation_error";
  static const scanner = "/scanner";
  static const calendar = "/calendar";
  static const main = "/main";
  static const profile = "/profile";
  static const gamesCollection = "/games_collection";
  static const settings = "/settings";
}

class MainNavigation {
  final _screenFactory = ScreenFactory();

  Map<String, WidgetBuilder> get routes => <String, WidgetBuilder>{
        Screens.login: (_) => _screenFactory.makeLogin(),
        Screens.onboarding: (_) => _screenFactory.makeOnboarding(),
        Screens.accountCreate: (_) => _screenFactory.makeAccountCreate(),
        Screens.appTabs: (_) => _screenFactory.makeAppTabs(),
        Screens.loader: (_) => _screenFactory.makeLoader(),
        Screens.scanner: (_) => _screenFactory.makeScanner(),
        Screens.calendar: (_) => _screenFactory.makeCalendar(),
        Screens.main: (_) => _screenFactory.makeMain(),
        Screens.profile: (_) => _screenFactory.makeProfile(),
        Screens.gamesCollection: (_) => _screenFactory.makeGamesCollection(),
        Screens.settings: (_) => _screenFactory.makeSettings(),
      };

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => _screenFactory.makeNavigationError(),
    );
  }
}
