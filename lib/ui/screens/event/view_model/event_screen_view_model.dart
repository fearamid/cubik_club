import 'package:cubik_club/domain/entities/event.dart';
import 'package:cubik_club/domain/entities/game/game.dart';
import 'package:cubik_club/ui/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

class _EventScreenViewModelState {
  final Event event;

  const _EventScreenViewModelState({
    required this.event,
  });
}

class EventScreenViewModel extends ChangeNotifier {
  var _state;
  _EventScreenViewModelState get state => _state;

  EventScreenViewModel(Event event) {
    _state = _EventScreenViewModelState(event: event);
  }

  void updateState({
    String? field,
  }) {
    _state = _EventScreenViewModelState(
      event: _state.event,
    );
    notifyListeners();
  }

  void onBookingButtonPressed() {}

  Future<void> onGameTilePressed(BuildContext context, Game game) async {
    await MainNavigation.toGameScreen(context, game: game);
  }
}
