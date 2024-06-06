import 'package:cubik_club/domain/entities/qr_code_data.dart';

class Event implements IQrCodeAble {
  final DateTime startDateTime;
  final DateTime endDateTime;
  final String title;
  final String description;
  final String coverLink;
  final bool? booking;
  // final DateTime dateTime;
  // final List<BoardGame> gamesList;

  const Event({
    required this.startDateTime,
    required this.endDateTime,
    required this.title,
    required this.description,
    required this.coverLink,
    this.booking,
  });

  static Event fromJson(Map<dynamic, dynamic> json) {
    return Event(
      title: '${json['title']}',
      description: '${json['description']}',
      coverLink: '${json['cover_link']}',
      startDateTime: DateTime.parse('${json['tstz_range'][0]}'),
      endDateTime: DateTime.parse('${json['tstz_range'][1]}'),
    );
  }

  @override
  String getQrValue() => title;

  @override
  String getQrTitle() => "Мероприятие";

  @override
  String getQrPrefix() => 'event';
}
