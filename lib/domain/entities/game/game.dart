import 'package:cubik_club/domain/entities/game/game_tags.dart';
import 'package:cubik_club/domain/entities/game/publisher.dart';
import 'package:cubik_club/domain/entities/qr_code_data.dart';
export './game_tags.dart';

class Game implements IQrCodeAble {
  final int id;
  final String name;
  final String description;
  final List<String>? completeSet;
  final GameTags tags;
  final String rules;
  final String? rulesFileLink;
  final String coverLink;
  final List<String>? imagesLinks;

  const Game._create({
    required this.id,
    required this.name,
    required this.description,
    required this.tags,
    required this.rules,
    required this.coverLink,
    this.imagesLinks,
    this.rulesFileLink,
    this.completeSet,
  });

  factory Game({
    required int id,
    required String name,
    required String description,
    required GameTags tags,
    required String rules,
    List<String>? completeSet,
    int ageLimit = 0,
    int complexity = 1,
  }) {
    return Game._create(
      id: id,
      name: name,
      description: description,
      tags: tags,
      rules: rules,
      completeSet: completeSet,
      coverLink: '',
      imagesLinks: [],
    );
  }

  factory Game.preview({
    required int id,
    required String name,
    required List<String> genres,
  }) {
    return Game._create(
      id: id,
      name: name,
      description: '',
      tags: GameTags.partiallyEmpty(genres: genres),
      rules: '',
      coverLink: 'coverLink',
    );
  }

  static Game fromJson(Map<dynamic, dynamic> json) {
    List<String>? imagesLinks;
    List? imagesList = json['images_links'] as List?;
    if (imagesList != null) {
      imagesLinks = [];
      for (int i = 0; i < imagesList.length; i++) {
        imagesLinks.add(imagesList[i] as String);
      }
    }

    return Game._create(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      tags: GameTags(
        genres: List.from(json['genres']),
        ageLimit: json['age_limit'],
        complexity: json['age_limit'],
        playersRange: List.from(json['players_range']),
        durationRange: List.from(json['duration_range']),
        publisher: Publisher(id: json['publisher_id'], name: 'Publisher'),
      ),
      completeSet:
          json['complete_set'] == null ? null : List.from(json['complete_set']),
      rules: json['rules'],
      coverLink: json['cover_image_link'],
      rulesFileLink: json['rules_file_link'],
      imagesLinks: imagesLinks,
    );
  }

  @override
  String getQrValue() => 'board-game_$id';

  @override
  String getQrTitle() => 'Настольная игра';

  @override
  String getQrPrefix() => 'game';
}
