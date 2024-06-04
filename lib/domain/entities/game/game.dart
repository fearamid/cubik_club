import 'package:cubik_club/domain/entities/game/game_tags.dart';
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

  @override
  String getQrValue() => 'board-game_$id';

  @override
  String getQrTitle() => 'Настольная игра';

  @override
  String getQrPrefix() => 'game';
}
