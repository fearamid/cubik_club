import 'package:cubik_club/common/widgets/components/section.dart';
import 'package:cubik_club/domain/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class _ViewModel extends ChangeNotifier {
  final _authService = AuthService();

  void onLogoutButtonPressed(BuildContext context) {
    _authService.logout();
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => _ViewModel(),
      child: const SettingsScreen(),
    );
  }

  // TODO: remake
  final List<String> settingsTiles = const [
    'Уведомления',
    'Внешний вид',
    'Выйти'
  ];

  @override
  Widget build(BuildContext context) {
    final model = context.read<_ViewModel>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Настройки'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList.separated(
            itemCount: 3,
            itemBuilder: (context, index) {
              final String tileText = settingsTiles[index];
              switch (tileText) {
                case 'Выйти':
                  return Section(
                    child: ElevatedButton(
                      onPressed: () => model.onLogoutButtonPressed(context),
                      child: Text(tileText),
                    ),
                  );
              }

              return Section(child: Text(tileText));
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10);
            },
          ),
        ],
      ),
    );
  }
}
