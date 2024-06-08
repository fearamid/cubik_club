import 'package:cached_network_image/cached_network_image.dart';
import 'package:cubik_club/domain/entities/event.dart';
import 'package:cubik_club/domain/entities/game/game.dart';
import 'package:cubik_club/ui/common/components/export/components.dart';
import 'package:cubik_club/ui/screens/event/view_model/event_screen_view_model.dart';
import 'package:cubik_club/ui/screens/event/widgets/games_list.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:cubik_club/utils/formatters/formatter.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';

class EventScreen extends StatelessWidget {
  final Event event;

  const EventScreen({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // SliverAppBar(
            //   leading: IconButton(
            //     icon: const Icon(Iconsax.arrow_left_2_copy),
            //     iconSize: 35,
            //     color: CCAppColors.secondary,
            //     onPressed: () => Navigator.of(context).pop(),
            //   ),
            //   shape: const RoundedRectangleBorder(
            //     borderRadius: BorderRadius.only(
            //         bottomLeft: Radius.circular(20),
            //         bottomRight: Radius.circular(20)),
            //   ),
            //   snap: true,
            //   floating: true,
            //   backgroundColor: CCAppColors.lightBackground,
            // ),
            const CustomAppBar(),
            SliverList(
              delegate: SliverChildListDelegate(
                const [
                  _EventCover(),
                  SizedBox(height: 20),
                  _EventDescription(),
                  SizedBox(height: 20),
                  _EventGamesList()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EventCover extends StatelessWidget {
  const _EventCover();

  @override
  Widget build(BuildContext context) {
    final imagesLinks =
        context.read<EventScreenViewModel>().state.event.imagesLinks;
    List<String> images = [
      context.read<EventScreenViewModel>().state.event.coverLink
    ];
    if (imagesLinks != null) {
      for (int i = 0; i < imagesLinks.length; i++) {
        images.add(imagesLinks[i]);
      }
    }

    List<CachedNetworkImage> imagesWidgets = List.generate(
      images.length,
      (index) => CachedNetworkImage(
        imageUrl: images[index],
        fit: BoxFit.cover,
      ),
    );

    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: PageView(
          children: imagesWidgets,
        ),
      ),
    );
  }
}

class _EventGamesList extends StatelessWidget {
  const _EventGamesList();

  @override
  Widget build(BuildContext context) {
    final List<Game>? games =
        context.read<EventScreenViewModel>().state.event.games;
    if (games == null || games.isEmpty) {
      return const Section(
        child: Text(
          'У этого мероприятия нет настольных игр',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      );
    }
    return GamesList(
      games: games,
      onTap: (game) async {
        await context
            .read<EventScreenViewModel>()
            .onGameTilePressed(context, game);
      },
    );
  }
}

class _EventDescription extends StatelessWidget {
  const _EventDescription();

  @override
  Widget build(BuildContext context) {
    final event = context.read<EventScreenViewModel>().state.event;
    final booking = event.booking ?? true;
    return Section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              height: 1,
            ),
          ),
          const SizedBox(height: 2),
          const _DateTimeInformation(),
          const SizedBox(height: 5),
          Text(
            event.description,
            style: const TextStyle(
              fontSize: 16,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 12),
          if (booking) const _BookingButton(),
        ],
      ),
    );
  }
}

class _BookingButton extends StatelessWidget {
  const _BookingButton();

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: const ButtonStyle(
        side: MaterialStatePropertyAll(BorderSide(color: CCAppColors.primary)),
      ),
      onPressed: context.read<EventScreenViewModel>().onBookingButtonPressed,
      child: const Text(
        'Забронировать',
        style: TextStyle(color: CCAppColors.primary),
      ),
    );
  }
}

class _DateTimeInformation extends StatelessWidget {
  const _DateTimeInformation();

  @override
  Widget build(BuildContext context) {
    final event = context.read<EventScreenViewModel>().state.event;
    return Row(
      children: [
        Text(
          CCFormatter.formatEventDate(event.startDateTime),
          style: const TextStyle(
            color: CCAppColors.lightTextSecodary,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 4,
          height: 4,
          decoration: const BoxDecoration(
            color: CCAppColors.lightHighlightBackground,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
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
    );
  }
}
