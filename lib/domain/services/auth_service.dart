import 'package:cubik_club/domain/data_providers/auth_api_provider.dart';
import 'package:cubik_club/domain/data_providers/session_data_provider.dart';

class AuthService {
  // TODO: ApiClient для авторизации
  final _sessionDataProvider = SessionDataProvider();
  final _authApiProvider = AuthApiProvider();

  Future<bool> checkAuth() async {
    final apiKey = await _sessionDataProvider.apiKey();
    return apiKey != null && apiKey != '';
  }

  Future<void> login(String login, String password) async {
    final apiKey = await _authApiProvider.login(login, password);
    await _sessionDataProvider.saveApiKey(apiKey);
  }

  Future<void> logout() async {
    await _sessionDataProvider.clearApiKey();
  }
}
