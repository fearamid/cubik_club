import 'package:cubik_club/domain/entities/game/publisher.dart';

class GameTags {
  final List<String> genres;
  final int ageLimit;
  final int complexity;
  final Publisher author;
  final List<int> playersRange;
  final List<int> durationRange;
  final Publisher publisher;

  const GameTags({
    required this.genres,
    required this.author,
    required this.ageLimit,
    required this.complexity,
    required this.playersRange,
    required this.durationRange,
    required this.publisher,
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
