// ignore_for_file: library_private_types_in_public_api

import 'package:cubik_club/domain/entities/event.dart';
import 'package:cubik_club/domain/entities/game/game.dart';
import 'package:cubik_club/domain/services/games_service.dart';
import 'package:cubik_club/ui/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

class _EventScreenViewModelState {
  final Event event;

  const _EventScreenViewModelState({
    required this.event,
  });
}

class EventScreenViewModel extends ChangeNotifier {
  late _EventScreenViewModelState _state;

  _EventScreenViewModelState get state => _state;

  EventScreenViewModel(Event event) {
    _state = _EventScreenViewModelState(event: event);
  }

  Game parseGame(Map<dynamic, dynamic>? gameJson) {
    if (gameJson == null) {
      throw Error();
    }
    return Game.fromJson(gameJson);
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
    try {
      final json = await GamesService().getGamesListByIds([game.id]);
      final fullGame = parseGame(json[0]);
      await MainNavigation.toGameScreen(context, game: fullGame);
    } catch (e) {
      return;
    }
  }
}
