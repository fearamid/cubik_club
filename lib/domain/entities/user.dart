import 'package:cubik_club/domain/entities/qr_code_data.dart';
import 'package:flutter/scheduler.dart';

enum Genders { male, female, undefined }

class User implements IQrCodeAble {
  final String login;
  final String role;
  final String name;
  final String surname;
  final Genders _gender;

  const User({
    this.role = 'USER',
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

  factory User.empty() {
    return const User(
      name: '',
      surname: '',
      login: '',
      gender: Genders.undefined,
    );
  }

  static Genders genderFromChar(String genderChar) {
    String char = genderChar[0].toLowerCase();

    switch (char) {
      case 'm':
        return Genders.male;
      case 'f':
        return Genders.female;
      default:
        return Genders.undefined;
    }
  }

  static User fromJson(Map<String, dynamic> userJson) {
    return User(
      name: userJson['name'],
      surname: userJson['surname'],
      login: userJson['login'],
      gender: userJson['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "login": login,
      "name": name,
      "surname": surname,
      "gender": genderChar,
      "role": role,
    };
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
