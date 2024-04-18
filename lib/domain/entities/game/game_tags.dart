class GameTags {
  final String genres;
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
}
