import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerScreenViewModel extends ChangeNotifier {
  final _cameraController = MobileScannerController(
    facing: CameraFacing.back,
    torchEnabled: false,
    detectionSpeed: DetectionSpeed.noDuplicates,
    returnImage: true,
  );
  MobileScannerController get cameraController => _cameraController;

  void onMobileScannerDetect(BuildContext context, BarcodeCapture capture) {
    final List<Barcode> barcodes = capture.barcodes;
    final Uint8List? image = capture.image;
    for (final barcode in barcodes) {
      debugPrint('Barcode found! ${barcode.rawValue}');
    }
    if (image != null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              barcodes.first.rawValue ?? '',
            ),
            content: Image(
              image: MemoryImage(image),
            ),
          );
        },
      );
      // Future.delayed(const Duration(seconds: 5), () {
      //   Navigator.pop(context);
      // });
    }
  }

  void onTorchButtonPressed() {
    _cameraController.toggleTorch();
  }

  void onCameraFacingButtonPressed() {
    _cameraController.switchCamera();
  }

  Widget createTorchButtonIcon({required Icon onIcon, required Icon offIcon}) {
    return ValueListenableBuilder(
      valueListenable: cameraController.torchState,
      builder: (context, state, child) {
        switch (state) {
          case TorchState.off:
            return onIcon;
          case TorchState.on:
            return offIcon;
        }
      },
    );
  }
}
