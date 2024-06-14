import 'package:cubik_club/ui/screens/pdf_viewer/view_model/pdf_viewer_screen_view_model.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';

class PDFViewerScreen extends StatelessWidget {
  const PDFViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<PDFViewerScreenViewModel>().state;
    final viewModel = context.read<PDFViewerScreenViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Правила игры',
          style: TextStyle(fontSize: 20),
        ),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2_copy),
          iconSize: 35,
          color: CCAppColors.secondary,
          onPressed: () => Navigator.of(context).pop(),
        ),
        // actions: actions,
        backgroundColor: CCAppColors.lightBackground,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            PDF(
              enableSwipe: true,
              onViewCreated: viewModel.onViewCreated,
              onRender: viewModel.onRender,
              onPageChanged: viewModel.onPdfPageChanged,
            ).cachedFromUrl(
              state.pdfLink,
              placeholder: (double progress) =>
                  Center(child: Text('$progress %')),
              errorWidget: (dynamic error) =>
                  Center(child: Text(error.toString())),
              maxNrOfCacheObjects: 3,
              maxAgeCacheObject: const Duration(hours: 3),
            ),
            const _PageCounter(),
          ],
        ),
      ),
    );
  }
}

class _PageCounter extends StatelessWidget {
  const _PageCounter();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PDFViewerScreenViewModel>().state;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: CCAppColors.lightBackground,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          '${state.currentPage} / ${state.totalPages}',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
