import 'package:cubik_club/ui/screens/settings/settings_screen_view_model.dart';
import 'package:cubik_club/ui/screens/settings/widgets/account_group/account_group.dart';
import 'package:cubik_club/ui/screens/settings/widgets/account_group/account_group_view_model.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<SettingsScreenViewModel>();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text(
          'Настройки',
          style: TextStyle(fontSize: 22),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2_copy),
          iconSize: 35,
          color: CCAppColors.secondary,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const AccountGroup().build(context),
                const SizedBox(height: 20),
                // const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => model.onLogoutButtonPressed(context),
                  child: const Text('Выйти'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
