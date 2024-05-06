import 'package:cubik_club/app.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

void initSystemUI() {
// TODO: fix hide toolbar from qr scanner
// TODO: добавить middleware checkAuth на сервере и отправлять заголовки авторизации при отправке на защищенные эндпоинты ('Bearer accessToken')
// TODO: add auth validators to server

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
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

void main() async {
  initSystemUI();
  // Todo: Add Widgets Binding
  // Todo: Init Local Storage
  // Todo: Await Native Splash
  // Todo: Initialize Firebase
  // Todo: Initialize Authentification
  const app = App();
  runApp(app);
}
