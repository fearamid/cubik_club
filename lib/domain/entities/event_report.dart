import 'package:cubik_club/domain/entities/event.dart';

class EventReport {
  final int id;
  final Event event;
  final String text;
  final List<String>? imagesLinks;
  final String coverLink;

  EventReport({
    required this.id,
    required this.event,
    required this.text,
    required this.coverLink,
    this.imagesLinks,
  });

  static EventReport fromJson(Map<dynamic, dynamic> json) {
    List<String>? imagesLinks;
    List? imagesList = json['report_images'] as List?;
    if (imagesList != null) {
      imagesLinks = [];
      for (int i = 0; i < imagesList.length; i++) {
        imagesLinks.add(imagesList[i] as String);
      }
    }

    return EventReport(
      id: json['report_id'],
      coverLink: '${json['report_cover_link']}',
      imagesLinks: imagesLinks,
      event: Event.fromJson(json),
      text: json['text'],
    );
  }
}
