import 'package:cubik_club/domain/entities/game/game_tags.dart';
export './game_tags.dart';

class Game {
  final String name;
  final String description;
  final GameTags tags;

  const Game({
    required this.name,
    required this.description,
    required this.tags,
  });
}
