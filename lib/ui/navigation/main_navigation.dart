import 'package:cubik_club/domain/entities/event.dart';
import 'package:cubik_club/domain/entities/event_report.dart';
import 'package:cubik_club/domain/entities/game/game.dart';
import 'package:cubik_club/domain/entities/qr_code_data.dart';
import 'package:cubik_club/ui/screen_factory/screen_factory.dart';
import 'package:flutter/material.dart';

abstract class Screens {
  static const login = '/login';
  static const onboarding = "/onboarding";
  static const registration = "/registration";
  static const appTabs = "/app_tabs";
  static const loader = "/loader";
  static const navigationError = "/navigation_error";
  static const scanner = "/scanner";
  static const calendar = "/calendar";
  static const main = "/main";
  static const profile = "/profile";
  static const gamesCollection = "/games_collection";
  static const settings = "/settings";
  static const event = "/event";
  static const eventReport = "/event_report";
  static const qrCode = "/qr_code";
  static const folders = "/folders";
  static const game = "/game";
  static const pdfViewer = "/pdf_viewer";
}

class MainNavigation {
  final _screenFactory = ScreenFactory();

  Map<String, WidgetBuilder> get routes => <String, WidgetBuilder>{
        Screens.login: (_) => _screenFactory.makeLogin(),
        Screens.onboarding: (_) => _screenFactory.makeOnboarding(),
        Screens.registration: (_) => _screenFactory.makeRegistration(),
        Screens.appTabs: (_) => _screenFactory.makeAppTabs(),
        Screens.loader: (_) => _screenFactory.makeLoader(),
        Screens.scanner: (_) => _screenFactory.makeScanner(),
        Screens.calendar: (_) => _screenFactory.makeCalendar(),
        Screens.main: (_) => _screenFactory.makeMain(),
        Screens.profile: (_) => _screenFactory.makeProfile(),
        Screens.gamesCollection: (_) => _screenFactory.makeGamesCollection(),
        Screens.settings: (_) => _screenFactory.makeSettings(),
        Screens.event: (context) => _screenFactory.makeEvent(context),
        Screens.qrCode: (context) => _screenFactory.makeQrCode(context),
        Screens.folders: (_) => _screenFactory.makeFolders(),
        Screens.game: (context) => _screenFactory.makeGame(context),
        Screens.pdfViewer: (context) => _screenFactory.makePDFViewer(context),
        Screens.eventReport: (context) =>
            _screenFactory.makeEventReport(context)
      };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      default:
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeNavigationError(),
        );
    }
  }

  static Future<void> toEventScreen(BuildContext context,
      {required Event event, bool replacement = false}) async {
    if (replacement) {
      await Navigator.of(context)
          .pushReplacementNamed(Screens.event, arguments: event);
    } else {
      await Navigator.of(context).pushNamed(Screens.event, arguments: event);
    }
  }

  static Future<void> toEventReportScreen(BuildContext context,
      {required EventReport report}) async {
    await Navigator.of(context)
        .pushNamed(Screens.eventReport, arguments: report);
  }

  static Future<void> toPDFViewercreen(
    BuildContext context, {
    required String? pdfLink,
  }) async {
    await Navigator.of(context)
        .pushNamed(Screens.pdfViewer, arguments: pdfLink);
  }

  static Future<void> toLoaderScreen(BuildContext context) async {
    await Navigator.of(context).pushNamed(Screens.loader);
  }

  static Future<void> toScannerScreen(BuildContext context) async {
    await Navigator.of(context).pushNamed(Screens.scanner);
  }

  static Future<void> toSettingsScreen(BuildContext context) async {
    await Navigator.of(context).pushNamed(Screens.settings);
  }

  static Future<void> toFoldersScreen(BuildContext context) async {
    await Navigator.of(context).pushNamed(Screens.folders);
  }

  static Future<void> toQrCodeScreen(BuildContext context,
      {required IQrCodeAble entity}) async {
    await Navigator.of(context).pushNamed(Screens.qrCode, arguments: entity);
  }

  static Future<void> toAppTabsScreen(BuildContext context) async {
    if (!context.mounted) return;

    await Navigator.of(context)
        .pushNamedAndRemoveUntil(Screens.appTabs, (route) => false);
  }

  static Future<dynamic> toRegistrationScreen(BuildContext context) async {
    final result = await Navigator.of(context).pushNamed(Screens.registration);
    return result;
  }

  static Future<void> toGameScreen(BuildContext context,
      {required Game game, bool replacement = false}) async {
    if (replacement) {
      await Navigator.of(context)
          .pushReplacementNamed(Screens.game, arguments: game);
    } else {
      await Navigator.of(context).pushNamed(Screens.game, arguments: game);
    }
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) => const Text('Новый виджет');
}
