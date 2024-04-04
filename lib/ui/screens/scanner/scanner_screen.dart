import 'package:cubik_club/ui/screens/scanner/scanner_screen_view_model.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ScannerScreenViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'QR сканер',
          style: TextStyle(
            fontSize: 20,
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
        onDetect: (capture) =>
            viewModel.onMobileScannerDetect(context, capture),
      ),
    );
  }
}

class _TorchButton extends StatelessWidget {
  const _TorchButton();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ScannerScreenViewModel>();

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
    final viewModel = context.read<ScannerScreenViewModel>();

    return IconButton(
      color: CCAppColors.secondary,
      iconSize: 35,
      onPressed: () => viewModel.onCameraFacingButtonPressed(),
      icon: const Icon(Iconsax.camera_copy),
    );
  }
}
