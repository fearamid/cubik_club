class AccountCreateService {
  final String name;
  final String surName;
  final String clubName;
  final String phoneNumber;
  final String email;
  final String password;

  const AccountCreateService({
    required this.name,
    required this.surName,
    required this.clubName,
    required this.phoneNumber,
    required this.email,
    required this.password,
  });

  bool isStepOneComplete() {
    return _validateName(name) && _validateSurname(surName);
  }

  bool _validateName(String name) {
    return RegExp(r'^[a-z]+$').hasMatch(name);
  }

  bool _validateSurname(String name) {
    return RegExp(r'^[a-z]+$').hasMatch(name);
  }

  bool _validatePhoneNumber(String phone) {
    return true;
  }

  bool _validateEmail(String phone) {
    return true;
  }
}
