import 'package:cubik_club/domain/entities/game/game.dart';
import 'package:cubik_club/ui/common/components/export/components.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class LinkTile extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Widget? description;
  const LinkTile({
    super.key,
    required this.onPressed,
    required this.title,
    required this.description,
  });

  static LinkTile withTags({
    required VoidCallback onPressed,
    required String title,
    required GameTags tags,
  }) {
    return LinkTile(
      onPressed: onPressed,
      title: title,
      description: TagsView.shortWrap(tags: tags),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      onTap: () => onPressed(),
      child: Container(
        padding: const EdgeInsets.only(
          left: 20,
          top: 15,
          bottom: 20,
          right: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: CCAppColors.lightHighlightBackground,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            const Icon(
              Iconsax.arrow_right_3_copy,
              size: 30,
              color: CCAppColors.lightHighlightBackground,
            ),
          ],
        ),
      ),
    );
  }
}
