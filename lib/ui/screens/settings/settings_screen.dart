import 'package:cubik_club/ui/common/widgets/components/section.dart';
import 'package:cubik_club/ui/screens/settings/settings_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  // TODO: remake
  final List<String> settingsTiles = const [
    'Уведомления',
    'Внешний вид',
    'Выйти'
  ];

  @override
  Widget build(BuildContext context) {
    final model = context.read<SettingsScreenViewModel>();
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
