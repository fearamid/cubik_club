abstract class AuthApiProviderError {}

class AuthApiProviderIncorrectLoginData extends AuthApiProviderError {}

class AuthApiProvider {
  // TODO: Change logic
  Future<String> login(String login, String password) async {
    final isSuccess = login == 'admin' && password == '1234';

    if (isSuccess) {
      return 'fake_api_key';
    } else {
      throw AuthApiProviderIncorrectLoginData();
    }
  }
}
