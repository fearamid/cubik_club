import 'package:cubik_club/ui/screens/settings/settings_screen_view_model.dart';
import 'package:cubik_club/ui/screens/settings/widgets/account_group/account_group_view_model.dart';
import 'package:cubik_club/ui/screens/settings/widgets/settings_group.dart';
import 'package:cubik_club/ui/screens/settings/widgets/settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountGroup {
  const AccountGroup();

  List<Widget> createTiles(BuildContext context) {
    final model = context.read<SettingsScreenViewModel>();
    final List<Widget> accountTiles = [
      _DarkModeToggle.build(context),
      SettingsTile.value(
        label: 'Email',
        description: 'Настройка Email',
      ),
      SettingsTile.value(
        label: 'Пароль',
        description: 'Настройка пароля',
      ),
      ElevatedButton(
        onPressed: () => model.onLogoutButtonPressed(context),
        child: const Text('Выйти'),
      ),
    ];

    return accountTiles;
  }

  Widget build(BuildContext context) {
    return SettingsGroup(
      label: 'Аккаунт',
      tiles: createTiles(context),
    );
  }
}

abstract class _DarkModeToggle {
  const _DarkModeToggle();

  static Widget build(BuildContext context) {
    final model = context.read<AccountGroupViewModel>();
    final darkMode = context.watch<AccountGroupViewModel>().state.darkMode;

    return SettingsTile.toggle(
      label: 'Темная тема',
      description: 'Включить темный режим',
      value: darkMode,
      onChanged: model.onDarkModeToggle,
    );
  }
}
