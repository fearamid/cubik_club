import 'package:cached_network_image/cached_network_image.dart';
import 'package:cubik_club/domain/entities/event_report.dart';
import 'package:cubik_club/ui/common/components/single/section.dart';
import 'package:cubik_club/ui/navigation/main_navigation.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:cubik_club/utils/formatters/formatter.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class EventReportThumbnail extends StatelessWidget {
  final EventReport report;
  final bool preview;
  final Function(int id)? onTap;

  const EventReportThumbnail({
    super.key,
    required this.report,
    this.preview = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isValidUrl = Uri.tryParse(report.coverLink)?.isAbsolute ?? false;
    return Section(
      onTap: () {
        if (onTap != null) {
          onTap!(report.id);
        } else {
          MainNavigation.toEventReportScreen(context, report: report);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Title(report),
          const SizedBox(height: 2),
          _DateTimeRange(report),
          if (!preview) const SizedBox(height: 5),
          if (!preview) _Text(report),
          if (isValidUrl) const SizedBox(height: 12),
          // Image
          isValidUrl
              ? _Cover(report)
              : const Padding(
                  padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                  child: Center(
                    child: Icon(
                      Iconsax.gallery_copy,
                      size: 45,
                      color: CCAppColors.lightHighlightBackground,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class _Cover extends StatelessWidget {
  final EventReport report;
  const _Cover(this.report);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: CachedNetworkImage(
          imageUrl: report.coverLink,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(
              strokeAlign: BorderSide.strokeAlignInside,
              color: CCAppColors.secondary,
              strokeWidth: 1,
            ),
          ),
          errorWidget: (context, url, error) => const Icon(
            Iconsax.gallery_copy,
            size: 45,
            color: CCAppColors.lightHighlightBackground,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _Text extends StatelessWidget {
  final EventReport report;
  const _Text(this.report);

  @override
  Widget build(BuildContext context) {
    return Text(
      report.text,
      maxLines: 5,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: CCAppColors.lightTextPrimary,
        fontSize: 16,
        height: 1.35,
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final EventReport report;
  const _Title(this.report);

  @override
  Widget build(BuildContext context) {
    return Text(
      report.event.title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        height: 1,
      ),
    );
  }
}

class _DateTimeRange extends StatelessWidget {
  final EventReport report;
  const _DateTimeRange(this.report);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          CCFormatter.formatEventDate(report.event.startDateTime),
          style: const TextStyle(
            color: CCAppColors.lightTextSecodary,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          width: 4,
          height: 4,
          decoration: const BoxDecoration(
            color: CCAppColors.lightHighlightBackground,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          CCFormatter.formatEventTimeRange(
            start: report.event.startDateTime,
            end: report.event.endDateTime,
          ),
          style: const TextStyle(
            color: CCAppColors.lightTextSecodary,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
