import 'package:cubik_club/ui/screens/scanner/qr_scanner_screen_view_model.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

// TODO: copy to clipboard button

class QrScannerScreen extends StatelessWidget {
  const QrScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<QrScannerScreenViewModel>();
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 70,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2_copy),
          iconSize: 35,
          color: CCAppColors.secondary,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'QR сканер',
          style: TextStyle(
            fontSize: 22,
            color: CCAppColors.lightTextPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: const [
          _TorchButton(),
          SizedBox(width: 20),
          _CameraFacingButton(),
          SizedBox(width: 20),
        ],
      ),
      body: MobileScanner(
        fit: BoxFit.cover,
        controller: viewModel.cameraController,
        onDetect: (capture) => {
          if (!viewModel.isScannedValid)
            {
              viewModel.onMobileScannerDetect(context, capture),
            }
        },
      ),
    );
  }
}

class _TorchButton extends StatelessWidget {
  const _TorchButton();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<QrScannerScreenViewModel>();

    return IconButton(
      color: CCAppColors.secondary,
      iconSize: 35,
      onPressed: () => viewModel.onTorchButtonPressed(),
      icon: viewModel.createTorchButtonIcon(
        onIcon: const Icon(
          Iconsax.flash_1_copy,
          color: CCAppColors.secondary,
        ),
        offIcon: const Icon(
          Iconsax.flash_1,
          color: CCAppColors.accentYellow,
        ),
      ),
    );
  }
}

class _CameraFacingButton extends StatelessWidget {
  const _CameraFacingButton();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<QrScannerScreenViewModel>();

    return IconButton(
      color: CCAppColors.secondary,
      iconSize: 35,
      onPressed: () => viewModel.onCameraFacingButtonPressed(),
      icon: const Icon(Iconsax.camera_copy),
    );
  }
}
