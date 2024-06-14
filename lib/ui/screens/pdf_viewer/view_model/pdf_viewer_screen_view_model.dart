import 'dart:io';

import 'package:cubik_club/ui/common/components/export/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:path_provider/path_provider.dart';

class _PDFViewerScreenViewModelState {
  final String pdfLink;
  final int currentPage;
  final int totalPages;
  final String filePath;

  _PDFViewerScreenViewModelState({
    this.pdfLink = '',
    this.currentPage = 1,
    this.totalPages = 1,
    this.filePath = '',
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
    String? filePath,
  }) {
    _state = _PDFViewerScreenViewModelState(
      pdfLink: pdfLink ?? _state.pdfLink,
      currentPage: currentPage ?? _state.currentPage,
      totalPages: totalPages ?? _state.totalPages,
      filePath: filePath ?? _state.filePath,
    );
    notifyListeners();
  }

  void onViewCreated(PDFViewController controller) {
    _controller = controller;
  }

  void onRender(int? totalPages) {
    updateState(totalPages: totalPages ?? _state.totalPages);
  }

  void onPdfPageChanged(int? page, int? total) {
    if (page != null) {
      updateState(currentPage: page + 1);
    }
  }

  void whenDone(String filePath) {
    _state = _PDFViewerScreenViewModelState(filePath: filePath);
  }

  void onDowloadButtonPressed(BuildContext context) async {
    // // final appDocumentDir = await getApplicationDocumentsDirectory();
    // final directory = await getDownloadsDirectory();
    // // const directory = '/storage/emulated/0/Dowload';
    // File(state.filePath).copySync('${directory?.path}/rules.pdf');
    // final file = File('${directory?.path}/rules.pdf');

    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return Center(
    //       child: Container(
    //         color: Colors.white,
    //         child: Text('Путь до файла: ${'${directory?.path}/rules.pdf'}'),
    //       ),
    //     );
    //   },
    // );

    print(state.pdfLink);
    // final flutterMediaDownloaderPlugin = MediaDownload();
    // await flutterMediaDownloaderPlugin.downloadMedia(context, state.pdfLink);
  }
}
