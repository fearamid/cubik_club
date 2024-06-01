import 'package:cubik_club/domain/entities/event.dart';
import 'package:cubik_club/domain/entities/game/game.dart';
import 'package:cubik_club/domain/entities/qr_code_data.dart';
import 'package:cubik_club/ui/screens/registration/registration_screen.dart';
import 'package:cubik_club/ui/screens/registration/registration_view_model.dart';
import 'package:cubik_club/ui/screens/app_tabs/app_tabs.dart';
import 'package:cubik_club/ui/screens/app_tabs/app_tabs_view_model.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/calendar/calendar_screen.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/calendar/calendar_screen_view_model.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/games_collection/games_collection_screen.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/games_collection/view_model/games_collection_screen_view_model.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/main/main_screen.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/main/main_screen_view_model.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/profile/profile_screen.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/profile/profile_screen_view_model.dart';
import 'package:cubik_club/ui/screens/folders/folders_screen.dart';
import 'package:cubik_club/ui/screens/folders/folders_screen_view_model.dart';
import 'package:cubik_club/ui/screens/game_screen/game_screen.dart';
import 'package:cubik_club/ui/screens/game_screen/view_model/game_screen_view_model.dart';
import 'package:cubik_club/ui/screens/loader/loader_screen.dart';
import 'package:cubik_club/ui/screens/loader/loader_screen_view_model.dart';
import 'package:cubik_club/ui/screens/login/login_screen.dart';
import 'package:cubik_club/ui/screens/login/login_screen_view_model.dart';
import 'package:cubik_club/ui/screens/navigation_error/navigation_error_screen.dart';
import 'package:cubik_club/ui/screens/onboarding/onboarding_screen.dart';
import 'package:cubik_club/ui/screens/onboarding/view_model/onboarding_screen_view_model.dart';
import 'package:cubik_club/ui/screens/event/event_screen.dart';
import 'package:cubik_club/ui/screens/event/view_model/event_screen_view_model.dart';
import 'package:cubik_club/ui/screens/qr_code/qr_code_screen.dart';
import 'package:cubik_club/ui/screens/qr_code/qr_code_screen_view_model.dart';
import 'package:cubik_club/ui/screens/scanner/qr_scanner_screen.dart';
import 'package:cubik_club/ui/screens/scanner/qr_scanner_screen_view_model.dart';
import 'package:cubik_club/ui/screens/settings/settings_screen.dart';
import 'package:cubik_club/ui/screens/settings/settings_screen_view_model.dart';
import 'package:cubik_club/ui/screens/settings/widgets/account_group/account_group_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenFactory {
  Widget makeRegistration() {
    return ChangeNotifierProvider(
      create: (_) => RegistrationViewModel(),
      child: const RegistrationScreen(),
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

  Widget makeNavigationError([String? errorText]) {
    return NavigationErrorScreen(errorText: errorText);
  }

  Widget makePost(BuildContext context) {
    final event = ModalRoute.of(context)?.settings.arguments;

    if (event == null || event is! Event) {
      return makeNavigationError(
          'Не удалось получить информацию о мероприятии.');
    }

    return ChangeNotifierProvider(
      create: (_) => EventScreenViewModel(event),
      child: EventScreen(
        event: event,
      ),
    );
  }

  Widget makeScanner() {
    return ChangeNotifierProvider(
      create: (_) => QrScannerScreenViewModel(),
      child: const QrScannerScreen(),
    );
  }

  Widget makeFolders() {
    return ChangeNotifierProvider(
      create: (_) => FoldersScreenViewModel(),
      child: const FoldersScreen(),
    );
  }

  Widget makeCalendar() {
    return ChangeNotifierProvider(
      create: (_) => CalendarScreenViewModel(),
      child: const CalendarScreen(),
    );
  }

  Widget makeGamesCollection() {
    return ChangeNotifierProvider(
      create: (_) => GamesCollectionScreenViewModel(),
      child: const GamesCollectionScreen(),
    );
  }

  Widget makeMain() {
    return ChangeNotifierProvider(
      create: (_) => MainScreenViewModel(),
      child: const MainScreen(),
    );
  }

  Widget makeProfile() {
    return ChangeNotifierProvider(
      create: (_) => ProfileScreenViewModel(),
      child: const ProfileScreen(),
    );
  }

  Widget makeGame(BuildContext context) {
    final game = ModalRoute.of(context)?.settings.arguments;

    if (game == null || game is! Game) {
      return makeNavigationError('Не удалось получить информацию о игре.');
    }

    return ChangeNotifierProvider(
      create: (_) => GameScreenViewModel(),
      child: GameScreen(
        game: game,
      ),
    );
  }

  Widget makeSettings() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingsScreenViewModel>(
            create: (_) => SettingsScreenViewModel()),
        ChangeNotifierProvider<AccountGroupViewModel>(
            create: (_) => AccountGroupViewModel()),
      ],
      child: const SettingsScreen(),
    );
  }

  Widget makeQrCode(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;

    if (arguments == null || arguments is! IQrCodeAble) {
      return makeNavigationError('Не удалось получить информацию о qr-коде.');
    }

    final IQrCodeAble qrCodeEntity = arguments;

    return ChangeNotifierProvider(
      create: (_) => QrCodeScreenViewModel(),
      child: QrCodeScreen(qrCodeEntity),
    );
  }
}
