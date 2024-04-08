import 'package:cubik_club/domain/entities/event.dart';
import 'package:cubik_club/ui/common/widgets/components/section.dart';
import 'package:cubik_club/ui/common/widgets/event_thumbnail.dart';
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
    final selectedDay =
        context.watch<CalendarScreenViewModel>().state.selectedDay;

    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              const SizedBox(height: kToolbarHeight),
              EventCalendar(
                onDaySelected: viewModel.onDaySelected,
                eventLoader: viewModel.eventsBuilder,
              ),
              const SizedBox(height: 15),
              CurrentDateInformation(
                events: viewModel.createCurrentDateEvent(selectedDay),
              ),
              const SizedBox(height: kBottomNavigationBarHeight + 60)
            ],
          ),
        ),
      ],
    );
  }
}

class CurrentDateInformation extends StatelessWidget {
  final List<Event>? events;

  const CurrentDateInformation({
    super.key,
    this.events,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel =
        context.watch<CalendarScreenViewModel>().state.selectedDay;

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
    } else if (events!.length == 1) {
      return EventThumbnail(event: events!.first);
    } else {
      final List<Widget> widgetsList = [];

      for (int i = 0; i < events!.length; i++) {
        widgetsList.add(
          EventThumbnail(event: events![i]),
        );
      }

      return ExpandablePageView(
        children: widgetsList,
      );
    }
  }
}
