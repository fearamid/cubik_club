import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class _SessionProviderKeys {
  static const _refreshToken = 'refresh_token';
  static const _accessToken = 'access_token';
  static const _accessTokenExpiration = 'access_token_expiration';
}

class JWTProvider {
  final _storage = const FlutterSecureStorage();

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    required int accessTokenExpiration,
  }) async {
    await saveAccessToken(accessToken, accessTokenExpiration);
    await saveRefreshToken(refreshToken);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: _SessionProviderKeys._accessToken);
  }

  Future<void> saveAccessToken(String value, int tokenExpiration) async {
    await _storage.write(key: _SessionProviderKeys._accessToken, value: value);
    await _storage.write(
      key: _SessionProviderKeys._accessTokenExpiration,
      value: tokenExpiration.toString(),
    );
  }

  Future<void> clearAccessToken() async {
    await _storage.delete(key: _SessionProviderKeys._accessToken);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _SessionProviderKeys._refreshToken);
  }

  Future<void> saveRefreshToken(String value) async {
    await _storage.write(key: _SessionProviderKeys._refreshToken, value: value);
  }

  Future<void> clearRefreshToken() async {
    await _storage.delete(key: _SessionProviderKeys._refreshToken);
  }
}
