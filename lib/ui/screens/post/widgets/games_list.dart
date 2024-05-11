import 'package:cubik_club/domain/entities/game/game.dart';
import 'package:flutter/material.dart';

import '../../../common/components/export/components.dart';

class GamesList extends StatelessWidget {
  final List<Game> games;
  final void Function(Game game) onGamePressed;

  const GamesList({
    super.key,
    required this.games,
    required this.onGamePressed,
  });

  List<Widget> _noGamesEvent() {
    return const [Text('У мероприятия нет игр')];
  }

  List<Widget> _oneGameEvent() {
    return [
      Text(
        games[0].name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 3),
      GameTagsView(tags: games[0].tags),
      const SizedBox(height: 20),
      OutlinedButton(
        onPressed: () {
          onGamePressed(games[0]);
        },
        child: const Text(
          'Подробнее',
          style: TextStyle(fontWeight: FontWeight.normal),
        ),
      )
    ];
  }

  List<Widget> _multipleGamesEvent() {
    return [
      const Text(
        'Играем в эти настолки',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 10),
      ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: games.length,
        itemBuilder: (_, index) {
          final game = games[index];
          return LinkTile.withTags(
            onPressed: () {
              onGamePressed(game);
            },
            title: game.name,
            tags: game.tags,
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
      children.addAll(_oneGameEvent());
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
