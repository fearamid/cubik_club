import 'dart:convert';

import 'package:cubik_club/domain/entities/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class _UserProviderKeys {
  static const String user = 'user';
}

class UserProvider {
  final _secureStorage = const FlutterSecureStorage();

  Future<void> addUser(User user) async {
    await _secureStorage.write(
      key: _UserProviderKeys.user,
      value: jsonEncode(user.toJson()),
    );
  }

  Future<User> getUser() async {
    final String? userJson =
        await _secureStorage.read(key: _UserProviderKeys.user);

    if (userJson == null) {
      throw UserReceivingError();
    }

    final User user = jsonDecode(userJson);

    return user;
  }
}

class UserReceivingError {
  String get error => "Ошибка получения данных пользоватя из памяти";
}
