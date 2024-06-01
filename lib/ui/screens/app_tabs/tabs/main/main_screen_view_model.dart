import 'package:cubik_club/domain/entities/event.dart';
import 'package:cubik_club/domain/services/events_service.dart';
import 'package:cubik_club/ui/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

class _MainScreenViewModelState {
  final Map<String, int> sliderPosts;
  const _MainScreenViewModelState({
    this.sliderPosts = const <String, int>{
      "dfsdf": 2,
      'fsdfsdf': 232,
      "fsfsf": 11
    },
  });
}

class MainScreenViewModel extends ChangeNotifier {
  MainScreenViewModel();
  final _eventsService = EventsService();

  var _state = const _MainScreenViewModelState();
  get state => _state;

  void updateState({
    Map<String, int>? sliderPosts,
  }) {
    _state = _MainScreenViewModelState(
      sliderPosts: sliderPosts ?? _state.sliderPosts,
    );
    notifyListeners();
  }

  void onQrScannerButtonPressed(BuildContext context) {
    MainNavigation.toScannerScreen(context);
  }

  Future<List<Map<dynamic, dynamic>>> loadRelevantEvents() async {
    return await _eventsService.getRelevantEvents();
  }

  Event parseEvent(Map<dynamic, dynamic>? eventJson) {
    if (eventJson == null) {
      throw Error();
    }
    return Event.fromJson(eventJson);
  }

  void onSliderPageChanged(int index) {}

  void onSliderPagePressed(int index) {}

  void onTabPressed(int tab) {}

  void onFiltersPressed() {}

  Future<void> onRefreshPage() async {}
}
