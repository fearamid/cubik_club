import 'package:cubik_club/domain/entities/event.dart';

class EventReport {
  final int id;
  final Event event;
  final String text;
  final List<String>? imagesLinks;
  final String coverLink;
  final List<int>? participants;
  final List<int>? winners;

  EventReport({
    required this.id,
    required this.event,
    required this.text,
    required this.coverLink,
    required this.participants,
    required this.winners,
    this.imagesLinks,
  });

  static EventReport fromJson(Map<dynamic, dynamic> json) {
    return EventReport(
      id: json['report_id'],
      coverLink: '${json['report_cover_link']}',
      imagesLinks: json['report_images'],
      event: Event.fromJson(json),
      text: json['text'],
      participants: json['participants'],
      winners: json['winners'],
    );
  }
}
