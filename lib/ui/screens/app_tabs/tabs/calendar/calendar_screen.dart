import 'package:cubik_club/domain/entities/event.dart';
import 'package:cubik_club/ui/common/components/single/section.dart';
import 'package:cubik_club/ui/common/components/event_thumbnail.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/calendar/calendar_screen_view_model.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/calendar/widgets/event_calendar.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<CalendarScreenViewModel>();

    return SingleChildScrollView(
      child: FutureBuilder<List<Map<dynamic, dynamic>>>(
        future: viewModel.loadCalendarEvents(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const Column(
                children: [
                  SizedBox(
                    height: 400,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              );

            case ConnectionState.done:
              break;
            default:
          }

          if (!snapshot.hasData) {
            return Column(
              children: [
                EventCalendar(
                  onDaySelected: viewModel.onDaySelected,
                  eventLoader: viewModel.eventLoader,
                ),
                const SizedBox(height: 15),
                const CurrentDateInformation(),
                const SizedBox(height: kBottomNavigationBarHeight + 60)
              ],
            );
          }

          if (snapshot.hasError) {
            return const SliverToBoxAdapter(
              child: Center(
                child: Text('Ошибка загрузки данных...'),
              ),
            );
          }

          viewModel.addEventsMap(snapshot.data!);

          return Column(
            children: [
              EventCalendar(
                onDaySelected: viewModel.onDaySelected,
                eventLoader: viewModel.eventLoader,
              ),
              const SizedBox(height: 15),
              const CurrentDateInformation(),
              const SizedBox(height: kBottomNavigationBarHeight + 60)
            ],
          );
        },
      ),
    );
  }
}

class CurrentDateInformation extends StatelessWidget {
  const CurrentDateInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final selectedDay =
        context.watch<CalendarScreenViewModel>().state.selectedDay;
    final currentEventIndex =
        context.watch<CalendarScreenViewModel>().state.currentEventIndex + 1;

    final model = context.read<CalendarScreenViewModel>();

    final List<Event>? events = model.getCurrentDateEventsList(selectedDay);

    if (events == null) {
      return const Section(
        child: Text(
          'В этот день мероприятия нет.',
          style: TextStyle(
            fontSize: 18,
            color: CCAppColors.lightTextPrimary,
          ),
        ),
      );
    } else if (events.length == 1) {
      return EventThumbnail(
        event: events.first,
        preview: true,
        onTap: (id) async {
          await model.onCurrentEventTap(context, id);
        },
      );
    } else if (events.isEmpty) {
      return const Section(
        child: Text(
          'В этот день мероприятия нет.',
          style: TextStyle(
            fontSize: 18,
            color: CCAppColors.lightTextPrimary,
          ),
        ),
      );
    } else {
      final List<Widget> widgetsList = [];

      for (int i = 0; i < events.length; i++) {
        widgetsList.add(
          EventThumbnail(
            event: events[i],
            preview: true,
            onTap: (id) async {
              await model.onCurrentEventTap(context, id);
            },
          ),
        );
      }

      const double iconSize = 23;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                currentEventIndex == events.length
                    ? const Icon(
                        Iconsax.arrow_left_2_copy,
                        size: iconSize,
                        color: CCAppColors.lightHighlightBackground,
                      )
                    : const SizedBox(width: iconSize),
                Text('$currentEventIndex / ${events.length}'),
                currentEventIndex != events.length
                    ? const Icon(
                        Iconsax.arrow_right_3_copy,
                        size: iconSize,
                        color: CCAppColors.lightHighlightBackground,
                      )
                    : const SizedBox(width: iconSize),
              ],
            ),
          ),
          ExpandablePageView(
            onPageChanged: model.onCurrentEventChanged,
            children: widgetsList,
          ),
        ],
      );
    }
  }
}
