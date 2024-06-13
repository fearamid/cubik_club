import 'package:cubik_club/domain/entities/game/game.dart';
import 'package:flutter/material.dart';

class _GameScreenViewModelState {
  final Game game;

  const _GameScreenViewModelState({
    required this.game,
  });
}

class GameScreenViewModel extends ChangeNotifier {
  late _GameScreenViewModelState _state;
  _GameScreenViewModelState get state => _state;

  GameScreenViewModel(Game game) {
    _state = _GameScreenViewModelState(game: game);
  }

  void updateState({
    String? field,
  }) {
    _state = _GameScreenViewModelState(
      game: _state.game,
    );
    notifyListeners();
  }
}
