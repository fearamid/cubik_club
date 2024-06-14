import 'package:cubik_club/domain/entities/game/game.dart';
import 'package:cubik_club/ui/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

class _GameScreenViewModelState {
  final Game game;
  final bool like;

  const _GameScreenViewModelState({
    required this.game,
    this.like = false,
  });
}

class GameScreenViewModel extends ChangeNotifier {
  late _GameScreenViewModelState _state;
  _GameScreenViewModelState get state => _state;

  GameScreenViewModel(Game game) {
    _state = _GameScreenViewModelState(game: game);
  }

  void updateState({
    Game? game,
    bool? like,
  }) {
    _state = _GameScreenViewModelState(
      game: game ?? _state.game,
      like: like ?? _state.like,
    );
    notifyListeners();
  }

  void onRulesButtonPressed(BuildContext context) async {
    await MainNavigation.toPDFViewercreen(context,
        pdfLink: state.game.rulesFileLink);
  }

  void onLikeButtonPressed() {
    updateState(like: !_state.like);
  }
}
