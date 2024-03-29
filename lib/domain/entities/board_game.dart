class CommunityLink {}

class PlayersRange {
  final int min;
  final int max;
  final int? optimal;

  PlayersRange._create({
    required this.min,
    required this.max,
    this.optimal,
  });

  factory PlayersRange({
    required min,
    required max,
    optimal,
  }) {
    final minValue = min <= 0 ? 1 : min;
    final maxValue = max < minValue ? min : max;
    int? optimalValue = optimal;

    if (optimal > maxValue) {
      optimalValue = maxValue;
    } else if (optimal < minValue) {
      optimalValue = minValue;
    }

    return PlayersRange._create(
        min: minValue, max: maxValue, optimal: optimalValue);
  }
}

class BoardGameParameters {
  final List<String> genres;
  final int ageLimit;
  final String author;
  final int playersRange;
  final int duration;

  const BoardGameParameters({
    required this.genres,
    required this.author,
    required this.ageLimit,
    required this.playersRange,
    required this.duration,
  });
}

class BoardGame {
  final String name;
  final String description;
  final BoardGameParameters parameters;
  final List<CommunityLink> communityLinks;

  const BoardGame({
    required this.name,
    required this.description,
    required this.parameters,
    required this.communityLinks,
  });
}
