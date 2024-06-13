import 'package:cubik_club/domain/entities/game/game.dart';
import 'package:cubik_club/ui/common/components/export/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

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

  void onRulesButtonPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(15),
          child: Section(
            child: const PDF(
              swipeHorizontal: true,
              fitEachPage: true,
            ).cachedFromUrl(
              'https://www.learningcontainer.com/wp-content/uploads/2019/09/sample-pdf-file.pdf',
              placeholder: (progress) => Center(child: Text('$progress %')),
              errorWidget: (error) => Center(child: Text(error.toString())),
            ),
          ),
        );
      },
    );
  }
}
