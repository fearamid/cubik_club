import 'package:cubik_club/domain/entities/game/publisher.dart';

class GameTags {
  final List<String> genres;
  final int ageLimit;
  final int complexity;
  final Publisher author;
  final List<int> playersRange;
  final List<int> durationRange;

  const GameTags({
    required this.genres,
    required this.author,
    required this.ageLimit,
    required this.complexity,
    required this.playersRange,
    required this.durationRange,
  });

  Map<String, dynamic> toJson() {
    return {
      "genres": genres,
      "ageLimit": ageLimit,
      "author": author,
      "playersRange": playersRange,
      "duration": durationRange,
    };
  }

  List<List<dynamic>> toList() {
    return [
      ["Жанр", genres],
      ["Автор", author],
      ["Возраст", ageLimit],
      ["Кол-во игроков", playersRange],
      ["Длительность", durationRange],
    ];
  }
}

class PlayersRange {
  final int min;
  final int max;

  PlayersRange._create(this.min, this.max);

  factory PlayersRange(int min, int max) {
    if (min > max) {}

    return PlayersRange._create(min, max);
  }
}
