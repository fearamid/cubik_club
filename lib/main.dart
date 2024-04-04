import 'package:cubik_club/app.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

void initSystemUI() {
  WidgetsFlutterBinding.ensureInitialized();
// TODO: fix hide toolbar from qr scanner
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ],
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.light, // For iOS (dark icons)
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white,
    ),
  );

  initializeDateFormatting('ru');
}

void main() {
  initSystemUI();
  // Todo: Add Widgets Binding
  // Todo: Init Local Storage
  // Todo: Await Native Splash
  // Todo: Initialize Firebase
  // Todo: Initialize Authentification
  const app = App();
  runApp(app);
}
