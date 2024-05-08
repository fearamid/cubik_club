import 'package:cubik_club/domain/entities/qr_code_data.dart';

enum Genders { male, female, undefined }

class User implements IQrCodeAble {
  final String login;
  final String name;
  final String surname;
  final Genders _gender;

  const User({
    required this.name,
    required this.surname,
    required this.login,
    required Genders gender,
  }) : _gender = gender;

  get gender => _gender;

  String get genderChar {
    switch (_gender) {
      case Genders.male:
        return 'm';
      case Genders.female:
        return 'f';
      case Genders.undefined:
        return 'u';
    }
  }

  @override
  String generateQr() {
    return login;
  }

  @override
  String generateQrTitle() {
    return 'Пользователь';
  }
}
