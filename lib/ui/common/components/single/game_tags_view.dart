import 'package:cubik_club/domain/entities/game/game.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:cubik_club/utils/extensions/string_casing_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GameTagsView extends StatelessWidget {
  final GameTags tags;
  final double spacing;
  final Widget Function(GameTags tags) widgetBuilder;

  const GameTagsView._build({
    required this.tags,
    required this.spacing,
    required this.widgetBuilder,
  });

  factory GameTagsView({
    required GameTags tags,
    double spacing = 8,
  }) {
    return GameTagsView._build(
      tags: tags,
      spacing: spacing,
      widgetBuilder: (tags) {
        final tagsList = tags.toList();

        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: tagsList.length,
          itemBuilder: (_, index) {
            final String tagName = _getTagNameByIndex(tagsList, index);
            final String tagValue = _getTagValueByIndex(tagsList, index);

            return Row(
              children: [
                Expanded(
                  child: Text(
                    tagName,
                    style: const TextStyle(
                      fontSize: 18,
                      color: CCAppColors.secondary,
                    ),
                  ),
                ),
                Expanded(child: Text(tagValue)),
              ],
            );
          },
          separatorBuilder: (_, __) {
            return SizedBox(height: spacing);
          },
        );
      },
    );
  }

  factory GameTagsView.shortWrap({
    required GameTags tags,
    List<int> tagsIndexes = const [0, 4, 1],
    double spacing = 8,
  }) {
    return GameTagsView._build(
      tags: tags,
      spacing: spacing,
      widgetBuilder: (tags) {
        final tagsList = tags.toList();
        final String tag1 = _getTagValueByIndex(tagsList, tagsIndexes[0]);
        final String tag2 = _getTagValueByIndex(tagsList, tagsIndexes[1]);
        final String tag3 = _getTagValueByIndex(tagsList, tagsIndexes[2]);

        return Text(
          '$tag1 / $tag2 / $tag3',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: CCAppColors.secondary),
        );
      },
    );
  }

  static String _getTagNameByIndex(List list, int index) {
    return list[index][0].toString().toCapitalized();
  }

  static String _formatValueByTagName(String tagName, dynamic value) {
    switch (tagName.toLowerCase()) {
      case 'жанр':
        return (value as List<String>)
            .map((e) => e.toString())
            .toList()
            .join(", ")
            .toLowerCase();
      case 'кол-во игроков':
        if ((value as List<int>).length == 1) {
          return '${(value as List<int>)[0]}';
        }
        return 'от ${value[0]} до ${value[1]}';
      case 'длительность':
        return '~ $value мин';
      case 'возраст':
        return '$value+';
      default:
        return value.toString().toCapitalized();
    }
  }

  static String _getTagValueByIndex(List list, int index) {
    final String tagName = _getTagNameByIndex(list, index);
    final value = list[index][1];

    return _formatValueByTagName(tagName, value);
  }

  @override
  Widget build(BuildContext context) {
    return widgetBuilder(tags);
  }
}
