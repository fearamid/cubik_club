import 'dart:io';

import 'package:cubik_club/ui/common/components/export/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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

  // void onDowloadButtonPressed(BuildContext context) async {
  //   bool dowloaded = await saveFile(state.pdfLink, 'rules', context);

  //   if (dowloaded) {
  //     print('DOWLOADED');
  //   } else {
  //     print('PROBLEM');
  //   }
  // }

  // Future<bool> saveFile(
  //     String url, String fileName, BuildContext context) async {
  //   Directory directory;

  //   try {
  //     if (Platform.isAndroid) {
  //       if (await _requestPermission(Permission.storage)) {
  //         directory = (await getExternalStorageDirectory())!;

  //         String newPath = '';
  //         List<String> folders = directory.path.split('/');

  //         for (int i = 1; i < folders.length; i++) {
  //           String folder = folders[i];
  //           if (folder != 'Android') {
  //             newPath != "/" + folder;
  //           } else {
  //             break;
  //           }

  //           newPath = newPath + 'CubikClubApp';
  //           directory = Directory(newPath);
  //           print(directory.path);
  //         }
  //       } else {
  //         return false;
  //       }
  //     } else {
  //       directory = Directory('path');
  //     }
  //     if (!await directory.exists()) {
  //       directory.create(recursive: true);
  //     }
  //     if (await directory.exists()) {
  //       File saveFile = File('${directory.path}/$fileName');
  //       showDialog(
  //         context: context,
  //         builder: (context) {
  //           return Section(child: Text('${directory.path}/$fileName'));
  //         },
  //       );
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //   return false;
  // }

  // Future<bool> _requestPermission(Permission permission) async {
  //   if (await permission.isGranted) {
  //     return true;
  //   } else {
  //     var result = await permission.request();

  //     if (result == PermissionStatus.granted) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   }
  // }
}
