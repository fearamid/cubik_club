import 'package:cached_network_image/cached_network_image.dart';
import 'package:cubik_club/domain/entities/event.dart';
import 'package:cubik_club/ui/common/components/single/section.dart';
import 'package:cubik_club/ui/navigation/main_navigation.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:cubik_club/utils/formatters/formatter.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class EventThumbnail extends StatelessWidget {
  final Event event;
  const EventThumbnail({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Section(
      onTap: () => MainNavigation.toEventcreen(context, event: event),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            event.title,
            style: const TextStyle(
              color: CCAppColors.lightTextPrimary,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              height: 1,
            ),
          ),
          const SizedBox(height: 2),
          // DateTime Range
          Row(
            children: [
              Text(
                CCFormatter.formatEventDate(event.startDateTime),
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
                  start: event.startDateTime,
                  end: event.endDateTime,
                ),
                style: const TextStyle(
                  color: CCAppColors.lightTextSecodary,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          // Description
          Text(
            event.description,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: CCAppColors.lightTextPrimary,
              fontSize: 16,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 12),
          // Image
          AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: event.coverLink,
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
          ),
        ],
      ),
    );
  }
}
