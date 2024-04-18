import 'package:cubik_club/utils/constants/colors.dart';
import 'package:flutter/cupertino.dart';

class SettingsTile extends StatelessWidget {
  final String label;
  final Widget action;
  final String? description;
  final bool isNeedConfirmation;
  final String confirmationText;

  final Icon? icon;

  const SettingsTile({
    super.key,
    required this.label,
    required this.action,
    this.description,
    this.icon,
    this.isNeedConfirmation = false,
    this.confirmationText = 'Вы уверены?',
  });

  factory SettingsTile.toggle({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
    Icon? icon,
    String? description,
  }) {
    return SettingsTile(
      label: label,
      action: _TileActionsFactory.makeToggle(value, onChanged),
      description: description,
      icon: icon,
    );
  }

  factory SettingsTile.value({
    required String label,
    String? description,
    Icon? icon,
  }) {
    return SettingsTile(
      label: label,
      action: _TileActionsFactory.makeValue(),
      description: description,
      icon: icon,
    );
  }

  factory SettingsTile.options({
    required String label,
    String? description,
    Icon? icon,
  }) {
    return SettingsTile(
      label: label,
      action: _TileActionsFactory.makeOptions(),
      description: description,
      icon: icon,
    );
  }

  List<Widget> createChildren() {
    List<Widget> children = [];

    if (icon != null) {
      children.add(icon!);
    }

    if (description != null) {
      children.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 20, height: 1),
            ),
            const SizedBox(height: 7),
            Text(
              description!,
              style: const TextStyle(
                  fontSize: 16, color: CCAppColors.secondary, height: 1),
            )
          ],
        ),
      );
    } else {
      children.add(Text(
        label,
        style: const TextStyle(fontSize: 20),
      ));
    }

    children.add(action);

    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.orange,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: createChildren(),
      ),
    );
  }
}

class _TileActionsFactory {
  static Widget makeToggle(bool value, ValueChanged<bool> onChanged) {
    return CupertinoSwitch(
      activeColor: CCAppColors.accentGreen,
      trackColor: CCAppColors.accentRed,
      value: value,
      onChanged: onChanged,
    );
  }

  static Widget makeValue() {
    return const Text('');
  }

  static Widget makeOptions() {
    return const Text('');
  }

  static Widget makeGroup() {
    return const Text('');
  }

  static Widget makeRedirect() {
    return const Text('');
  }
}
