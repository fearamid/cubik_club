import 'package:cubik_club/domain/entities/qr_code_data.dart';

class Event implements IQrCodeAble {
  final DateTime? dateTime;
  final String title;
  final String description;
  final String coverLink;
  // final DateTime dateTime;
  // final List<BoardGame> gamesList;

  const Event({
    this.dateTime,
    required this.title,
    required this.description,
    required this.coverLink,
  });

  @override
  String getQrValue() => title;

  @override
  String getQrTitle() => "Мероприятие";

  @override
  String getQrPrefix() => 'event';
}
