class GameTags {
  final List<String> genres;
  final int ageLimit;
  final String author;
  final List<int> playersRange;
  final int duration;

  const GameTags({
    required this.genres,
    required this.author,
    required this.ageLimit,
    required this.playersRange,
    required this.duration,
  });

  Map<String, dynamic> toMap() {
    return {
      "genres": genres,
      "ageLimit": ageLimit,
      "author": author,
      "playersRange": playersRange,
      "duration": duration,
    };
  }

  List<List<dynamic>> toList() {
    return [
      ["Жанр", genres],
      ["Автор", author],
      ["Возраст", ageLimit],
      ["Кол-во игроков", playersRange],
      ["Длительность", duration],
    ];
  }
}
