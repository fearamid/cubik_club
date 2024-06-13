import 'package:cubik_club/domain/entities/game/game.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:cubik_club/utils/extensions/string_casing_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TagsView extends StatelessWidget {
  final GameTags tags;
  final double spacing;
  final Widget Function(GameTags tags) widgetBuilder;

  const TagsView._build({
    required this.tags,
    required this.spacing,
    required this.widgetBuilder,
  });

  factory TagsView({
    required GameTags tags,
    double spacing = 10,
  }) {
    return TagsView._build(
      tags: tags,
      spacing: spacing,
      widgetBuilder: (tags) {
        final tagsList = tags.toCyrillicMap();
        final keys = tagsList.keys.toList();

        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: tagsList.length,
          itemBuilder: (_, index) {
            return Row(
              children: [
                Expanded(
                  child: Text(
                    keys[index],
                    style: const TextStyle(
                      fontSize: 16,
                      color: CCAppColors.secondary,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    tagsList[keys[index]].toString(),
                    // _getTagValueByIndex(tagsList, index),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            );
          },
          separatorBuilder: (_, __) => SizedBox(height: spacing),
        );
      },
    );
  }

  factory TagsView.shortWrap({
    required GameTags tags,
    List<int> tagsIndexes = const [0, 4, 1],
    double spacing = 8,
  }) {
    return TagsView._build(
      tags: tags,
      spacing: spacing,
      widgetBuilder: (tags) {
        final tagsList = tags.toValueList();
        final String tag1 = _getTagValueByIndex(tagsList, tagsIndexes[0]);
        final String tag2 = _getTagValueByIndex(tagsList, tagsIndexes[1]);
        final String tag3 = _getTagValueByIndex(tagsList, tagsIndexes[2]);

        return Text(
          '$tag1 / $tag2 / $tag3',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: CCAppColors.secondary, fontSize: 16),
        );
      },
    );
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
    final String tagName = list[index];
    final value = list[index][1];

    return _formatValueByTagName(tagName, value);
  }

  @override
  Widget build(BuildContext context) {
    return widgetBuilder(tags);
  }
}
