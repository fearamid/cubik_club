import 'dart:convert';

import 'package:cubik_club/domain/api_clients/user_api_client.dart';
import 'package:cubik_club/domain/data_providers/jwt_provider.dart';
import 'package:cubik_club/domain/data_providers/user_provider.dart';
import 'package:cubik_club/domain/entities/user.dart';

class UserService {
  final _jwtProvider = JWTProvider();
  final _userProvider = UserProvider();

  Future<User> getUserDataFromAccessToken() async {
    final String? accessToken = await _jwtProvider.getAccessToken();
    // print("INNER TOKEN  accessToken");
    // print(accessToken);

    if (accessToken == null) {
      throw Error();
    }
    try {
      final String text = accessToken.split('.')[1];
      final String normalizedText = base64.normalize(text);

      final decoded = base64.decode(normalizedText);
      final Map<String, dynamic> json = jsonDecode(utf8.decode(decoded));

      json['gender'] = User.genderFromChar(json['gender']);

      final User user = User.fromJson(json);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<User> getUserFromMemory() async {
    return await _userProvider.getUser();
  }
}
