import 'package:cubik_club/domain/api_clients/auth_api_client.dart';
import 'package:cubik_club/domain/data_providers/jwt_provider.dart';
import 'package:cubik_club/domain/data_providers/user_provider.dart';
import 'package:cubik_club/domain/entities/user.dart';
import 'package:cubik_club/domain/services/user/user_service.dart';

class AuthService {
  final _jwtProvider = JWTProvider();
  final _authApiClient = AuthApiClient();
  final _userProvider = UserProvider();
  final _userService = UserService();

  Future<bool> checkAuth() async {
    final accessToken = await _jwtProvider.getAccessToken();
    return accessToken != null && accessToken != '';
  }

  Future<void> registration(User user, {required String password}) async {
    final Map<String, dynamic> response;

    try {
      response = await _authApiClient.registration(
        login: user.login,
        password: password,
        name: user.name,
        surname: user.surname,
        gender: user.genderChar,
      );
    } catch (e) {
      rethrow;
    }

    await _saveTokensInMemory(response);
  }

  Future<void> login(String login, String password) async {
    final Map<String, dynamic> response;

    try {
      response = await _authApiClient.login(login, password);
    } catch (e) {
      rethrow;
    }

    await _saveTokensInMemory(response);

    final user = await _userService.getUserDataFromAccessToken();

    await _userProvider.addUser(user);
  }

  Future<void> logout() async {
    await _jwtProvider.clearAccessToken();
  }

  Future<void> _saveTokensInMemory(response) async {
    await _jwtProvider.saveTokens(
      accessToken: response['accessToken'],
      refreshToken: response['refreshToken'],
      accessTokenExpiration: response['accessTokenExpiration'],
    );
  }
}
