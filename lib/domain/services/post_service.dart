import 'package:cubik_club/domain/entities/event.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockEventService {
  final _sharedPreferences = SharedPreferences.getInstance();

  Future<List<Event>> getPostList() async {
    return [
      const Event(name: '', description: ''),
      const Event(name: '', description: ''),
      const Event(name: '', description: ''),
      const Event(name: '', description: ''),
      const Event(name: '', description: ''),
      const Event(name: '', description: ''),
    ];
  }
}
