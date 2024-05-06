import 'package:cubik_club/domain/entities/qr_code_data.dart';

enum Genders { male, female, undefined }

class User implements IQrCodeAble {
  final String login;
  final String name;
  final String surname;
  final Genders gender;

  const User({
    required this.name,
    required this.surname,
    required this.login,
    required this.gender,
  });

  @override
  String generateQr() {
    return login;
  }

  @override
  String generateQrTitle() {
    return 'Пользователь';
  }
}
