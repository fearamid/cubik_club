import 'package:cached_network_image/cached_network_image.dart';
import 'package:cubik_club/domain/entities/event.dart';
import 'package:cubik_club/domain/entities/game/game.dart';
import 'package:cubik_club/domain/entities/game/publisher.dart';
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
    final coverLink =
        context.read<EventScreenViewModel>().state.event.coverLink;
    return Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: CachedNetworkImage(
              imageUrl: coverLink,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: CCAppColors.lightBackground,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Iconsax.arrow_left_2_copy,
                size: 35,
                color: CCAppColors.secondary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _EventGamesList extends StatelessWidget {
  const _EventGamesList();

  @override
  Widget build(BuildContext context) {
    final List<Game> games = [
      Game(
        id: 123,
        name: 'Монополия',
        description: 'Описание игры',
        tags: const GameTags(
          genres: ['стратегия', 'хоррор'],
          author: Publisher(id: 1, name: 'fsdf'),
          ageLimit: 18,
          playersRange: [2, 5],
          durationRange: 20,
        ),
        rules: '',
      ),
      Game(
        id: 123,
        name: 'Монополия',
        description: 'Описание игры',
        tags: const GameTags(
          genres: ['стратегия', 'хоррор'],
          author: Publisher(id: 1, name: 'fsdf'),
          ageLimit: 18,
          playersRange: [2, 5],
          durationRange: 20,
        ),
        rules: '',
      ),
    ];
    return GamesList(
      games: games,
      onTap: (Game game) {},
    );
  }
}

class _EventDescription extends StatelessWidget {
  const _EventDescription();

  @override
  Widget build(BuildContext context) {
    return const Section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Title(),
          SizedBox(height: 2),
          _DateTimeInformation(),
          SizedBox(height: 5),
          _Description(),
          SizedBox(height: 12),
          _BookingButton(),
        ],
      ),
    );
  }
}

class _BookingButton extends StatelessWidget {
  const _BookingButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: context.read<EventScreenViewModel>().onBookingButtonPressed,
      child: const Text('Забронировать'),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return Text(
      context.read<EventScreenViewModel>().state.event.title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        height: 1,
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description();

  @override
  Widget build(BuildContext context) {
    return Text(
      context.read<EventScreenViewModel>().state.event.description,
      style: const TextStyle(
        fontSize: 16,
        height: 1.35,
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
    );
  }
}
