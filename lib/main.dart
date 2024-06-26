import 'package:cubik_club/app.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';

void initSystemUI() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.dark, // For iOS (dark icons)
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white,
    ),
  );

  initializeDateFormatting('ru');
}

void main() async {
  initSystemUI();
  const app = App();
  runApp(app);
  WidgetsFlutterBinding.ensureInitialized();
}

// TODO: fix hide toolbar from qr scanner
// TODO: добавить middleware checkAuth на сервере и отправлять заголовки авторизации при отправке на защищенные эндпоинты ('Bearer accessToken')
// TODO: add auth validators to server
