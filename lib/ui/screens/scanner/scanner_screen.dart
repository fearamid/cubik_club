import 'dart:typed_data';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerScreen extends StatelessWidget {
  ScannerScreen({super.key});

  MobileScannerController cameraController = MobileScannerController(
    facing: CameraFacing.back,
    // torchEnabled: false,

    detectionSpeed: DetectionSpeed.noDuplicates,
    returnImage: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR код сканер'),
        actions: [
          IconButton(
            color: CCAppColors.secondary,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state as TorchState) {
                  case TorchState.off:
                    return const Icon(
                      Iconsax.flash_1_copy,
                      color: CCAppColors.secondary,
                    );
                  case TorchState.on:
                    return const Icon(
                      Iconsax.flash_1,
                      color: CCAppColors.accentYellow,
                    );
                }
              },
            ),
            iconSize: 35,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: CCAppColors.secondary,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state as CameraFacing) {
                  case CameraFacing.front:
                    return const Icon(Iconsax.camera_copy);
                  case CameraFacing.back:
                    return const Icon(Iconsax.camera_copy);
                }
              },
            ),
            iconSize: 35,
            onPressed: () => cameraController.switchCamera(),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: MobileScanner(
        fit: BoxFit.cover,
        controller: cameraController,
        onDetect: (capture) {
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
        },
      ),
    );
  }
}
