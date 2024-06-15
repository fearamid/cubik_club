import 'package:cubik_club/domain/entities/game/game.dart';
import 'package:cubik_club/domain/entities/qr_code_data.dart';

class Event implements IQrCodeAble {
  final int id;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final String title;
  final String description;
  final String coverLink;
  final List<String>? imagesLinks;
  final bool? booking;
  final List<Game>? games;

  const Event({
    required this.id,
    required this.startDateTime,
    required this.endDateTime,
    required this.title,
    required this.description,
    required this.coverLink,
    this.imagesLinks,
    this.booking,
    this.games,
  });

  static Event calendarPreview({
    required int id,
    required String coverLink,
    required DateTime startDateTime,
    required DateTime endDateTime,
    required String title,
  }) {
    return Event(
      id: id,
      startDateTime: startDateTime,
      endDateTime: endDateTime,
      title: title,
      coverLink: coverLink,
      description: '',
    );
  }

  static Event fromJson(Map<dynamic, dynamic> json) {
    List<Game>? games;
    final List? gamesList = (json['board_games'] as List?);
    if (gamesList != null) {
      games = [];
      for (int i = 0; i < gamesList.length; i++) {
        games.add(
          Game.preview(
            id: gamesList[i]['id'],
            name: gamesList[i]['name'],
            genres: gamesList[i]['genres'] ?? [],
          ),
        );
      }
    }

    List<String>? imagesLinks;
    List? imagesList = json['images_links'] as List?;
    if (imagesList != null) {
      imagesLinks = [];
      for (int i = 0; i < imagesList.length; i++) {
        imagesLinks.add(imagesList[i] as String);
      }
    }

    return Event(
      id: json['id'],
      title: '${json['title']}',
      description: '${json['description']}',
      coverLink: '${json['cover_link']}',
      startDateTime: DateTime.parse('${json['tstz_range'][0]}'),
      endDateTime: DateTime.parse('${json['tstz_range'][1]}'),
      games: games,
      imagesLinks: imagesLinks,
    );
  }

  @override
  String getQrValue() => title;

  @override
  String getQrTitle() => "Мероприятие";

  @override
  String getQrPrefix() => 'event';
}
