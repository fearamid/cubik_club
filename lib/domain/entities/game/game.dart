import 'package:cubik_club/domain/entities/game/game_tags.dart';
import 'package:cubik_club/domain/entities/qr_code_data.dart';
export './game_tags.dart';

class Game implements IQrCodeAble {
  final String id;
  final String name;
  final String description;
  final GameTags tags;

  const Game({
    required this.id,
    required this.name,
    required this.description,
    required this.tags,
  });

  @override
  String generateQr() {
    return 'board-game_$id';
  }

  @override
  String generateQrTitle() {
    return 'Настольная игра';
  }
}
