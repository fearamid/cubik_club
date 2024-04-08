import 'package:cubik_club/domain/entities/qr_code_data.dart';

class Event implements IQrCodeAble {
  final DateTime? dateTime;
  final String name;
  final String description;
  // final DateTime dateTime;
  // final List<BoardGame> gamesList;

  const Event({
    required this.name,
    required this.description,
    this.dateTime,
    // required this.dateTime,
    // required this.gamesList,
  });

  @override
  String generateQr() => name;

  @override
  String generateQrTitle() => "Мероприятие";
}
