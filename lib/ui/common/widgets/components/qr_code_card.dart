import 'package:cubik_club/ui/common/widgets/components/section.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeCard extends StatelessWidget {
  const QrCodeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Section(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Код аккаунта",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                height: 1,
              ),
            ),
            const SizedBox(height: 15),
            QrImageView(
              data: 'This is a simple QR code',
              version: QrVersions.auto,
              size: 300,
              dataModuleStyle: const QrDataModuleStyle(
                dataModuleShape: QrDataModuleShape.square,
                color: CCAppColors.primary,
              ),
              eyeStyle: const QrEyeStyle(
                eyeShape: QrEyeShape.square,
                color: CCAppColors.primary,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "id: 23782934",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: CCAppColors.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
