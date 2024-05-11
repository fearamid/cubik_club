import 'dart:convert';

import 'package:cubik_club/domain/api_clients/api_client.dart';

class UserApiClient {
  static const String _basePath = "/";

  final _apiClient = ApiClient();

  // Future<Map<String, dynamic>> getUserDataByAccessToken(
  //     String accessToken) async {
  //   // final response = await _apiClient.get(
  //   //   path: '$_basePath/user',
  //   //   headers: {
  //   //     "Authorization": 'Bearer $accessToken',
  //   //     "Content-Type": "application/json; charset=utf-8",
  //   //   },
  //   // );
  //   final String text = accessToken.split('.')[1];
  //   final decoded = base64.decode(text);
  //   final String jsonString = utf8.decode(decoded);

  //   // base64Decode(accessToken);

  //   // final json = await ApiClient.getJson(response);

  //   // switch (response.statusCode) {
  //   //   case 200:
  //   //     break;
  //   //   default:
  //   //     throw UserApiClientError();
  //   // }
  // }
}

class UserApiClientError {
  String get error => 'Произошла ошибка получения информации о пользователе';
}
