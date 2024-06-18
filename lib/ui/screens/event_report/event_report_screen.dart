import 'package:cubik_club/domain/entities/event_report.dart';
import 'package:cubik_club/domain/entities/game/game.dart';
import 'package:cubik_club/ui/common/components/export/components.dart';
import 'package:cubik_club/ui/screens/event/view_model/event_screen_view_model.dart';
import 'package:cubik_club/ui/screens/event/widgets/games_list.dart';
import 'package:cubik_club/ui/screens/event_report/event_report_screen_view_model.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:cubik_club/utils/formatters/formatter.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';

class EventReportScreen extends StatelessWidget {
  final EventReport report;

  const EventReportScreen({
    super.key,
    required this.report,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const CustomAppBar(
              actions: [
                _ToggleScreenViewButton(),
                SizedBox(width: 10),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                const [
                  _SwitchableCover(),
                  SizedBox(height: 20),
                  _SwitchableData(),
                  SizedBox(height: 20),
                  _EventGamesList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ToggleScreenViewButton extends StatelessWidget {
  const _ToggleScreenViewButton();

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      icon: Iconsax.arrow_swap_horizontal_copy,
      onPressed: context
          .read<EventReportScreenViewModel>()
          .onToggleScreenViewButtonPressed,
    );
  }
}

class _SwitchableCover extends StatelessWidget {
  const _SwitchableCover();

  @override
  Widget build(BuildContext context) {
    final report = context.read<EventReportScreenViewModel>().state.report;
    return ExpandablePageView(
      // physics: const NeverScrollableScrollPhysics(),
      controller: context.read<EventReportScreenViewModel>().coverController,
      children: [
        CachedImageCarousel(
          coverLink: report.coverLink,
          imagesLinks: report.imagesLinks,
        ),
        CachedImageCarousel(
          coverLink: report.event.coverLink,
          imagesLinks: report.event.imagesLinks,
        ),
      ],
    );
  }
}

class _EventGamesList extends StatelessWidget {
  const _EventGamesList();

  @override
  Widget build(BuildContext context) {
    final List<Game>? games =
        context.read<EventReportScreenViewModel>().state.report.event.games;
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
      report: true,
      games: games,
      onTap: (game) async {
        await context
            .read<EventScreenViewModel>()
            .onGameTilePressed(context, game);
      },
    );
  }
}

class _SwitchableData extends StatelessWidget {
  const _SwitchableData();

  @override
  Widget build(BuildContext context) {
    final report = context.read<EventReportScreenViewModel>().state.report;

    return Section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            report.event.title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              height: 1,
            ),
          ),
          const SizedBox(height: 2),
          const _DateTimeInformation(),
          const SizedBox(height: 5),
          ExpandablePageView(
            physics: const NeverScrollableScrollPhysics(),
            controller:
                context.read<EventReportScreenViewModel>().textController,
            children: [
              Text(
                report.text,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.35,
                ),
              ),
              Text(
                report.event.description,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DateTimeInformation extends StatelessWidget {
  const _DateTimeInformation();

  @override
  Widget build(BuildContext context) {
    final event = context.read<EventReportScreenViewModel>().state.report.event;
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
