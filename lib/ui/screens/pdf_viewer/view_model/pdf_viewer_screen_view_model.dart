import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class _PDFViewerScreenViewModelState {
  final String pdfLink;
  final int currentPage;
  final int totalPages;

  _PDFViewerScreenViewModelState({
    this.pdfLink = '',
    this.currentPage = 1,
    this.totalPages = 1,
  });
}

class PDFViewerScreenViewModel extends ChangeNotifier {
  late _PDFViewerScreenViewModelState _state;
  _PDFViewerScreenViewModelState get state => _state;

  late final PDFViewController _controller;

  PDFViewerScreenViewModel(String pdfLink) {
    _state = _PDFViewerScreenViewModelState(
      pdfLink: pdfLink,
    );
  }

  void updateState({
    int? currentPage,
    int? totalPages,
    String? pdfLink,
  }) {
    _state = _PDFViewerScreenViewModelState(
      pdfLink: pdfLink ?? _state.pdfLink,
      currentPage: currentPage ?? _state.currentPage,
      totalPages: totalPages ?? _state.totalPages,
    );
    notifyListeners();
  }

  void onViewCreated(PDFViewController controller) {
    _controller = controller;
  }

  void onRender(int? totalPages) {
    updateState(totalPages: totalPages);
  }

  void onPdfPageChanged(int? page, int? total) {
    if (page != null) {
      updateState(currentPage: page + 1);
    }
  }
}
