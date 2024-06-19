import 'package:cubik_club/domain/entities/qr_code_data.dart';

enum Genders { male, female, undefined }

class User implements IQrCodeAble {
  final int id;
  final String login;
  final String role;
  final String name;
  final String surname;
  final Genders _gender;

  const User({
    required this.id,
    this.role = 'USER',
    required this.name,
    required this.surname,
    required this.login,
    required Genders gender,
  }) : _gender = gender;

  get gender => _gender;

  static String genderChar(Genders gender) {
    switch (gender) {
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
      id: 0,
      name: 'Не заполнено',
      surname: 'Не заполнено',
      login: 'Не заполнено',
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
    print('CONVERT GENDER');
    print(User.genderFromChar(userJson['gender']));
    return User(
      id: userJson['id'],
      name: userJson['name'],
      surname: userJson['surname'],
      login: userJson['login'],
      gender: User.genderFromChar(userJson['gender']),
      role: userJson['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "login": login,
      "name": name,
      "surname": surname,
      "gender": genderChar(gender),
      "role": role,
    };
  }

  @override
  String getQrValue() => id.toString();

  @override
  String getQrTitle() => 'Пользователь';

  @override
  String getQrPrefix() => 'user';
}
