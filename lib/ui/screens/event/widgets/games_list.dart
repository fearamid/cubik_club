import 'package:cubik_club/domain/entities/game/game.dart';
import 'package:cubik_club/ui/common/components/export/components.dart';
import 'package:flutter/material.dart';

class GamesList extends StatelessWidget {
  final List<Game> games;
  final bool report;
  final void Function(Game game) onTap;

  const GamesList({
    super.key,
    required this.games,
    required this.onTap,
    this.report = false,
  });

  List<Widget> _noGamesEvent() {
    return [
      report
          ? const Text('У мероприятия не было игр')
          : const Text('У мероприятия нет игр'),
    ];
  }

  List<Widget> _oneGameEvent() {
    return [
      Text(
        games[0].name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 3),
      TagsView(tags: games[0].tags),
      const SizedBox(height: 20),
      OutlinedButton(
        onPressed: () => onTap(games[0]),
        child: const Text(
          'Подробнее',
          style: TextStyle(fontWeight: FontWeight.normal),
        ),
      )
    ];
  }

  List<Widget> _multipleGamesEvent() {
    return [
      report
          ? const Text(
              'Играли в эти настолки',
              maxLines: 1,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            )
          : const Text(
              'Играем в эти настолки',
              maxLines: 1,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
      const SizedBox(height: 10),
      ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: games.length,
        itemBuilder: (_, index) {
          return LinkTile.withTags(
            onPressed: () => onTap(games[index]),
            title: games[index].name,
            tags: games[index].tags,
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 20),
      )
    ];
  }

  List<Widget> _createChildren() {
    List<Widget> children = [];

    if (games.isEmpty) {
      children.addAll(_noGamesEvent());
    } else if (games.length == 1) {
      children.addAll(_multipleGamesEvent());
    } else {
      children.addAll(_multipleGamesEvent());
    }

    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _createChildren(),
      ),
    );
  }
}
