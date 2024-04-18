import 'package:cubik_club/ui/common/components/single/section.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class SettingsGroup extends StatelessWidget {
  final String label;
  final List<Widget> tiles;

  const SettingsGroup({
    super.key,
    required this.tiles,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: tiles.length,
            itemBuilder: (_, index) => tiles[index],
            separatorBuilder: (_, __) => const Divider(
              height: 25,
              thickness: 1,
              color: CCAppColors.lightHighlightBackground,
            ),
          )
        ],
      ),
    );
  }
}
