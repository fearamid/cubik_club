import 'package:cubik_club/domain/api_clients/api_client.dart';

class AuthApiClient {
  static const String _basePath = "/auth";

  final _apiClient = ApiClient();

  Future<Map<String, dynamic>> registration({
    required String login,
    required String password,
    required String name,
    required String surname,
    required String gender,
  }) async {
    final response = await _apiClient.post(
      path: '$_basePath/registration',
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: {
        "login": login,
        "password": password,
        "name": name,
        "surname": surname,
        "gender": gender,
      },
    );
    final json = await ApiClient.getJson(response);

    switch (response.statusCode) {
      case 200:
        break;
      case 409:
        throw AuthClientUserAlreadyExistError();
      case 500:
        throw AuthClientRegistrationFatalError();
      default:
        throw AuthClientFatalError();
    }

    return json;
  }

  Future<Map<String, dynamic>> login(String login, String password) async {
    final response = await _apiClient.post(
      path: '$_basePath/login',
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: {
        "login": login,
        "password": password,
      },
    );

    final json = await ApiClient.getJson(response);

    switch (response.statusCode) {
      case 200:
        break;
      case 404:
        throw AuthClientNonExistUser();
      case 401:
        throw AuthClientIncorrectLoginData();
      case 500:
        throw AuthClientLoginFatalError();
      default:
        throw AuthClientFatalError();
    }

    return json;
  }

  Future<void> logout(String refreshToken) async {
    final response = await _apiClient.post(
      path: '$_basePath/logout',
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: {
        "refreshToken": refreshToken,
      },
    );

    switch (response.statusCode) {
      case 500:
        throw AuthClientLogoutFatalError();
      default:
        throw AuthClientFatalError();
    }
  }

  Future<Map<String, dynamic>> refresh(String refreshToken) async {
    final response = await _apiClient.post(
      path: '$_basePath/refresh',
      headers: {
        "Content-Type": "application/json; charset=utf-8",
      },
      body: {
        "refreshToken": refreshToken,
      },
    );

    final json = await ApiClient.getJson(response);

    switch (response.statusCode) {
      case 200:
        break;
      case 401:
        throw AuthClientUnauthorized();
      case 403:
        throw AuthClientForbidden();
      case 500:
        throw AuthClientRefreshFatalError();
      default:
        throw AuthClientFatalError();
    }

    return json;
  }
}

abstract class AuthApiClientError {
  String get error;
}

class AuthClientIncorrectLoginData implements AuthApiClientError {
  @override
  String get error => 'Неверный логин или пароль';
}

class AuthClientNonExistUser implements AuthApiClientError {
  @override
  String get error => 'Пользователь не найден';
}

class AuthClientRegistrationFatalError implements AuthApiClientError {
  @override
  String get error => 'Fatal: ошибка регистрации';
}

class AuthClientLoginFatalError implements AuthApiClientError {
  @override
  String get error => 'Fatal: ошибка входа';
}

class AuthClientUserAlreadyExistError implements AuthApiClientError {
  @override
  String get error => 'Пользователь с таким логином уже существует';
}

class AuthClientRefreshFatalError implements AuthApiClientError {
  @override
  String get error => 'Fatal: ошибка обновления токена';
}

class AuthClientLogoutFatalError implements AuthApiClientError {
  @override
  String get error => 'Fatal: ошибка выхода';
}

class AuthClientUnauthorized implements AuthApiClientError {
  @override
  String get error => 'Unauthorized';
}

class AuthClientForbidden implements AuthApiClientError {
  @override
  String get error => 'Forbidden';
}

class AuthClientFatalError implements AuthApiClientError {
  @override
  String get error => 'Fatal: Неизвестная ошибка авторизации';
}
