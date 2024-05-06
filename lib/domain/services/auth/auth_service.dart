import 'package:cubik_club/domain/api_clients/auth_api_client.dart';
import 'package:cubik_club/domain/data_providers/jwt_provider.dart';

class AuthService {
  final _sessionDataProvider = JWTProvider();
  final _authApiClient = AuthApiClient();

  Future<bool> checkAuth() async {
    final accessToken = await _sessionDataProvider.getAccessToken();
    return accessToken != null && accessToken != '';
  }

  Future<void> registration(String login, String password) async {
    final Map<String, dynamic> response;

    try {
      response = await _authApiClient.registration(login, password);
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
  }

  Future<void> logout() async {
    await _sessionDataProvider.clearAccessToken();
  }

  Future<void> _saveTokensInMemory(response) async {
    await _sessionDataProvider.saveTokens(
      accessToken: response['accessToken'],
      refreshToken: response['refreshToken'],
      accessTokenExpiration: response['accessTokenExpiration'],
    );
  }
}
