// ignore_for_file: library_private_types_in_public_api

import 'package:cubik_club/domain/entities/event.dart';
import 'package:cubik_club/domain/entities/event_report.dart';
import 'package:cubik_club/domain/entities/game/game.dart';
import 'package:cubik_club/ui/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

class _EventReportScreenViewModelState {
  final EventReport report;
  final bool isReportView;

  const _EventReportScreenViewModelState({
    required this.report,
    this.isReportView = true,
  });
}

class EventReportScreenViewModel extends ChangeNotifier {
  late _EventReportScreenViewModelState _state;
  _EventReportScreenViewModelState get state => _state;

  EventReportScreenViewModel(EventReport report) {
    _state = _EventReportScreenViewModelState(report: report);
  }

  final textController = PageController();
  final coverController = PageController();

  void updateState({
    bool? isReportView,
    bool notify = true,
  }) {
    _state = _EventReportScreenViewModelState(
      report: _state.report,
      isReportView: isReportView ?? _state.isReportView,
    );
    if (notify) {
      notifyListeners();
    }
  }

  void onToggleScreenViewButtonPressed() {
    updateState(isReportView: !_state.isReportView, notify: false);
    textController.animateToPage(_state.isReportView ? 0 : 1,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    coverController.animateToPage(_state.isReportView ? 0 : 1,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  Future<void> onGameTilePressed(BuildContext context, Game game) async {
    await MainNavigation.toGameScreen(context, game: game);
  }
}
