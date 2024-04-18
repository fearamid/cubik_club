import 'package:cubik_club/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class TagsList extends StatelessWidget {
  final List<String> tags;
  final double spacing;
  const TagsList(
    this.tags, {
    super.key,
    this.spacing = 10,
  });

  List<Widget> _create() {
    List<Widget> widgets = [];
    final tagsCount = tags.length;

    for (int i = 0; i < tagsCount; i++) {
      if (tagsCount == 1 || i == tagsCount - 1) {
        widgets.add(
          Text(
            tags[i],
            style: const TextStyle(fontSize: 18, color: CCAppColors.secondary),
          ),
        );
        return widgets;
      }

      widgets.addAll([
        Text(
          tags[i],
          style: const TextStyle(fontSize: 18, color: CCAppColors.secondary),
        ),
        SizedBox(width: spacing),
        Container(
          width: 5,
          height: 5,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: CCAppColors.lightHighlightBackground,
          ),
        ),
        SizedBox(width: spacing),
      ]);
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: _create(),
    );
  }
}
