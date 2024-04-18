import 'package:cubik_club/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockUserService {
  final _sharedPreferences = SharedPreferences.getInstance();

  Future<User> read() async {
    return const User(name: 'name', surname: 'surname', id: 'id');
  }

  Future<void> write() async {}
}
