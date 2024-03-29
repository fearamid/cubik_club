import 'package:cubik_club/common/widgets/elements/section.dart';
import 'package:cubik_club/domain/entities/event.dart';
import 'package:cubik_club/ui/screens/post/post_screen.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class EventThumbnail extends StatelessWidget {
  final Event event;
  const EventThumbnail({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return PostScreen(event: event);
            },
          ),
        );
      },
      child: Section(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.name,
              style: const TextStyle(
                color: CCAppColors.lightTextPrimary,
                fontSize: 25,
                fontWeight: FontWeight.w700,
                height: 1.18,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              event.description,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: CCAppColors.lightTextPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                height: 1.18,
              ),
            ),
            const SizedBox(height: 3),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'стратегия',
                  style: TextStyle(
                    color: CCAppColors.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.18,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 5,
                  width: 5,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: CCAppColors.lightHighlightBackground,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  '12+',
                  style: TextStyle(
                    color: CCAppColors.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.18,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 5,
                  width: 5,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: CCAppColors.lightHighlightBackground,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'для всех',
                  style: TextStyle(
                    color: CCAppColors.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              height: 335,
              decoration: const BoxDecoration(
                color: CCAppColors.lightHighlightBackground,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
