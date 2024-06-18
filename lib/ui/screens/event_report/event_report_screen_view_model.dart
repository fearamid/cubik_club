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

  void updateState({
    bool? isReportView,
  }) {
    _state = _EventReportScreenViewModelState(
      report: _state.report,
      isReportView: isReportView ?? _state.isReportView,
    );
    notifyListeners();
  }

  void onToggleScreenViewButtonPressed() {}

  Future<void> onGameTilePressed(BuildContext context, Game game) async {
    await MainNavigation.toGameScreen(context, game: game);
  }
}
