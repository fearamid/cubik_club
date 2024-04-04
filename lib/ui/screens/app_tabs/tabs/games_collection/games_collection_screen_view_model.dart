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

  void onRandomGameButtonPressed() {}

  void onSearchFiltersButtonPressed() {}

  void onDropDownFiltersChanged(int? index) {}

  void onCollectionViewModeButtonPressed(CollectionDisplayMode mode) {
    updateState(displayMode: mode);
  }
}
