import 'package:cubik_club/ui/screens/app_tabs/tabs/games_collection/games_collection_screen.dart';
import 'package:cubik_club/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

enum CollectionDisplayMode { list, grid }

class _GamesCollectionScreenViewModelState {
  final CollectionDisplayMode displayMode;

  _GamesCollectionScreenViewModelState({
    this.displayMode = CollectionDisplayMode.list,
  });
}

class GamesCollectionScreenViewModel extends ChangeNotifier {
  var _state = _GamesCollectionScreenViewModelState();
  get state => _state;

  void updateState({
    CollectionDisplayMode? displayMode,
  }) {
    _state = _GamesCollectionScreenViewModelState(
      displayMode: displayMode ?? _state.displayMode,
    );
    notifyListeners();
  }

  void onRandomGameButtonPressed(
    BuildContext context, {
    required WidgetBuilder builder,
  }) {
    showDialog(
      context: context,
      builder: builder,
    );
  }

  void onSearchFiltersButtonPressed() {}

  void onDropDownFiltersChanged(int? index) {}

  void onCollectionViewModeButtonPressed(CollectionDisplayMode mode) {
    updateState(displayMode: mode);
  }
}
