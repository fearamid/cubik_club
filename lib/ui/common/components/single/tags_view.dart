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
                    _formatTagValue(keys[index], tagsList[keys[index]]),
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

  static String _formatGenre(List<String> value) {
    return value.isNotEmpty ? value.join(', ').toCapitalized() : 'Нет';
  }

  static String _formatPlayersRange(List<int> value) {
    final min = value[0];
    final max = value[1];

    if (min == max) {
      if (min >= 2 || min <= 4) return '$min человека';
      return '$min человек';
    }
    return '${value.join('—')} человек';
  }

  static String _formatDurationRange(List<int> value) {
    final min = value[0];
    final max = value[1];

    if (min == max) {
      return '$min минут';
    }
    return '${value.join('—')} минут';
  }

  static String _formatTagValue(String key, dynamic value) {
    switch (key) {
      case 'Жанр':
        return _formatGenre(value as List<String>);
      case 'Возраст':
        return '$value+';
      case 'Сложность':
        return '$value из 5';
      case 'Игроки':
        return _formatPlayersRange(value as List<int>);
      case 'Длительность':
        return _formatDurationRange(value as List<int>);
      case 'Издатель':
        return value.toString();
      default:
        return 'Нет';
    }
  }

  factory TagsView.shortWrap({
    required GameTags tags,
    double spacing = 8,
  }) {
    return TagsView._build(
      tags: tags,
      spacing: spacing,
      widgetBuilder: (tags) {
        final String genres = _formatTagValue('Жанр', tags.genres);

        return Text(
          genres,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: CCAppColors.secondary, fontSize: 16),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return widgetBuilder(tags);
  }
}
