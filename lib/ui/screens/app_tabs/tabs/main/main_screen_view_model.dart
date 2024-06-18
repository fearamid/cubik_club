import 'package:cubik_club/domain/entities/event.dart';
import 'package:cubik_club/domain/services/events_service.dart';
import 'package:cubik_club/ui/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

enum TabsCategoryType { announcements, reports, other }

class _MainScreenViewModelState {
  final Map<String, int> sliderPosts;
  final TabsCategoryType currentTabsCategory;
  const _MainScreenViewModelState({
    this.currentTabsCategory = TabsCategoryType.announcements,
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
  _MainScreenViewModelState get state => _state;

  void updateState({
    Map<String, int>? sliderPosts,
    TabsCategoryType? currentTabsCategory,
    bool notify = true,
  }) {
    _state = _MainScreenViewModelState(
      currentTabsCategory: currentTabsCategory ?? _state.currentTabsCategory,
      sliderPosts: sliderPosts ?? _state.sliderPosts,
    );
    if (notify) {
      notifyListeners();
    }
  }

  void onQrScannerButtonPressed(BuildContext context) {
    MainNavigation.toScannerScreen(context);
  }

  Future<List<Map<dynamic, dynamic>>> loadRelevantEvents() async {
    return _eventsService.getRelevantEvents();
  }

  Event parseEvent(Map<dynamic, dynamic>? eventJson) {
    if (eventJson == null) {
      throw Error();
    }
    return Event.fromJson(eventJson);
  }

  void onSliderPageChanged(int index) {}

  void onSliderPagePressed(int index) {}

  void onTabPressed(int tab) {
    TabsCategoryType type;

    switch (tab) {
      case 0:
        type = TabsCategoryType.announcements;
      case 1:
        type = TabsCategoryType.reports;
      case 2:
        type = TabsCategoryType.other;
      default:
        type = TabsCategoryType.announcements;
    }

    if (state.currentTabsCategory.index != type.index) {
      updateState(currentTabsCategory: type);
    }
  }

  void onFiltersPressed() {}

  Future<void> onRefreshPage() async {}
}
