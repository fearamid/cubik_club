import 'package:cubik_club/domain/entities/event.dart';
import 'package:cubik_club/ui/common/components/single/section.dart';
import 'package:cubik_club/ui/common/components/event_thumbnail.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/calendar/calendar_screen_view_model.dart';
import 'package:cubik_club/ui/screens/app_tabs/tabs/calendar/widgets/event_calendar.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<CalendarScreenViewModel>();

    final focusedDay =
        context.watch<CalendarScreenViewModel>().state.focusedDay;

    return CustomScrollView(
      slivers: [
        FutureBuilder<List<Map<dynamic, dynamic>>>(
          future: viewModel.loadCalendarEvents(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.active:
                return SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      EventCalendar(
                        key: const ValueKey('loadingCalendar'),
                        onDaySelected: (selected, focused) {},
                        eventLoader: (day) => [],
                        focusedDay: focusedDay,
                        onPageChanged: (focused) {},
                      ),
                      const SizedBox(height: 15),
                      const CurrentDateInformation(),
                      const SizedBox(height: kBottomNavigationBarHeight + 60)
                    ],
                  ),
                );

              case ConnectionState.done:
                break;
              default:
            }

            if (!snapshot.hasData) {
              return SliverList(
                delegate: SliverChildListDelegate(
                  [
                    EventCalendar(
                      onPageChanged: viewModel.onPageChanged,
                      onDaySelected: viewModel.onDaySelected,
                      eventLoader: viewModel.eventLoader,
                      focusedDay: focusedDay,
                    ),
                    const SizedBox(height: 15),
                    const CurrentDateInformation(),
                    const SizedBox(height: kBottomNavigationBarHeight + 60)
                  ],
                ),
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

            return SliverList(
              delegate: SliverChildListDelegate(
                [
                  EventCalendar(
                    onPageChanged: viewModel.onPageChanged,
                    focusedDay: focusedDay,
                    onDaySelected: viewModel.onDaySelected,
                    eventLoader: viewModel.eventLoader,
                  ),
                  const SizedBox(height: 15),
                  const CurrentDateInformation(),
                  const SizedBox(height: kBottomNavigationBarHeight + 60)
                ],
              ),
            );
          },
        ),
      ],
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
      return EventThumbnail(event: events.first);
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

      for (int i = 0; i < events!.length; i++) {
        widgetsList.add(
          EventThumbnail(event: events![i]),
        );
      }

      return Stack(
        children: [
          ExpandablePageView(
            onPageChanged: model.onCurrentEventChange,
            children: widgetsList,
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
              decoration: BoxDecoration(
                color: CCAppColors.lightBackground,
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              child: Text(
                '$currentEventIndex / ${events!.length}',
                style: const TextStyle(
                  color: CCAppColors.lightTextPrimary,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}
