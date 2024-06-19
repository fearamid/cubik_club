import 'package:cubik_club/domain/entities/game/publisher.dart';

class GameTags {
  final List<String> genres;
  final int ageLimit;
  final int complexity;
  final List<int> playersRange;
  final List<int> durationRange;
  final Publisher publisher;

  const GameTags({
    required this.genres,
    required this.ageLimit,
    required this.complexity,
    required this.playersRange,
    required this.durationRange,
    required this.publisher,
  });

  factory GameTags.partiallyEmpty({
    List<String>? genres,
  }) {
    return GameTags(
      genres: genres ?? [],
      ageLimit: 0,
      complexity: 0,
      playersRange: [0, 0],
      durationRange: [0, 0],
      publisher: Publisher.empty(),
    );
  }

  Map<String, dynamic> toCyrillicMap() {
    return {
      'Жанр': genres,
      'Возраст': ageLimit,
      'Сложность': complexity,
      'Игроки': playersRange,
      'Длительность': durationRange,
      'Издатель': publisher.name,
    };
  }

  List<List<dynamic>> toValueList() {
    return [
      ["Жанр", genres],
      ["Автор", publisher.name],
      ["Возраст", ageLimit],
      ["Кол-во игроков", playersRange],
      ["Длительность", durationRange],
    ];
  }
}
