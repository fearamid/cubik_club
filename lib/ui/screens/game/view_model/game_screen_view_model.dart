import 'package:cubik_club/domain/entities/game/game.dart';
import 'package:cubik_club/ui/navigation/main_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class _GameScreenViewModelState {
  final Game game;
  final bool liked;

  const _GameScreenViewModelState({
    required this.game,
    this.liked = false,
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
  }) {
    _state = _GameScreenViewModelState(
      game: game ?? _state.game,
    );
    notifyListeners();
  }

  void onRulesButtonPressed(BuildContext context) async {
    await MainNavigation.toPDFViewercreen(context,
        pdfLink: state.game.rulesFileLink);
  }
}

class PDFViewerCachedFromUrl extends StatelessWidget {
  const PDFViewerCachedFromUrl({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Правила игры'),
      ),
      body: const PDF().cachedFromUrl(
        url,
        placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
        maxNrOfCacheObjects: 3,
      ),
    );
  }
}
