import 'package:cubik_club/domain/entities/qr_code_data.dart';
import 'package:cubik_club/ui/common/components/single/section.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeScreen extends StatelessWidget {
  final IQrCodeAble entity;
  const QrCodeScreen(
    this.entity, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Iconsax.arrow_left_2_copy, size: 35),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: QrCodeCard(QrCodeData.fromEntity(entity)),
          ),
        ),
      ),
    );
  }
}

class QrCodeCard extends StatelessWidget {
  final QrCodeData qrCodeData;
  const QrCodeCard(
    this.qrCodeData, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      constrainedAxis: Axis.horizontal,
      child: Section(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              qrCodeData.title,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                height: 1,
              ),
            ),
            const SizedBox(height: 15),
            QrImageView(
              data: qrCodeData.data,
              version: QrVersions.auto,
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
            Text(
              qrCodeData.data,
              style: const TextStyle(
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
