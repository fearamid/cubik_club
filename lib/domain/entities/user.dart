import 'package:cubik_club/domain/entities/qr_code_data.dart';

class User implements IQrCodeAble {
  final String name;
  final String surname;
  final String id;
  const User({
    required this.name,
    required this.surname,
    required this.id,
  });

  @override
  String generateQr() {
    return id;
  }

  @override
  String generateQrTitle() {
    return 'Пользователь';
  }
}
