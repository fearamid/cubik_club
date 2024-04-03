import 'package:cubik_club/ui/screens/account_create/account_create_screen.dart';
import 'package:cubik_club/ui/screens/account_create/account_create_view_model.dart';
import 'package:cubik_club/ui/screens/app_tabs/app_tabs.dart';
import 'package:cubik_club/ui/screens/app_tabs/app_tabs_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenFactory {
  Widget makeAccountCreateScreen() {
    return ChangeNotifierProvider(
      create: (_) => AccountCreateViewModel(),
      child: const AccountCreateScreen(),
    );
  }

  Widget makeAppScreen() {
    return ChangeNotifierProvider(
      create: (_) => AppTabsViewModel(),
      child: const AppTabs(),
    );
  }
}
