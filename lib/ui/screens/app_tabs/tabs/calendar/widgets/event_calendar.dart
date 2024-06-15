import 'package:cubik_club/ui/common/components/single/section.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:cubik_club/utils/extensions/string_casing_extension.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class EventCalendar extends StatefulWidget {
  final OnDaySelected onDaySelected;
  final DateTime focusedDay;
  final List Function(DateTime day) eventLoader;
  final void Function(DateTime focusedDay) onPageChanged;

  const EventCalendar({
    super.key,
    required this.onDaySelected,
    required this.eventLoader,
    required this.focusedDay,
    required this.onPageChanged,
  });

  @override
  State<EventCalendar> createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  final _styles = const _CalendarStyles();

  @override
  void initState() {
    super.initState();

    _focusedDay = widget.focusedDay;
    _selectedDay = _focusedDay;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
    widget.onDaySelected(selectedDay, focusedDay);
  }

  @override
  Widget build(BuildContext context) {
    return Section(
      paddingHorizontal: 10,
      paddingVertical: 17,
      child: TableCalendar(
        onPageChanged: widget.onPageChanged,
        focusedDay: _focusedDay,
        onDaySelected: _onDaySelected,
        selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
        locale: 'ru',
        firstDay: DateTime.utc(2022),
        lastDay: DateTime.utc(2030),
        calendarBuilders: CalendarBuilders(
          singleMarkerBuilder: (context, date, event) {
            return Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    date == _selectedDay ? Colors.white : CCAppColors.primary,
              ), //Change color
            );
          },
        ),
        headerStyle: _styles.headerStyle,
        calendarStyle: _styles.calendarStyle,
        daysOfWeekStyle: _styles.daysOfWeekStyle,
        daysOfWeekHeight: 45,
        rowHeight: 55,
        startingDayOfWeek: StartingDayOfWeek.monday,
        eventLoader: widget.eventLoader,
      ),
    );
  }
}

// class EventCalendar extends StatefulWidget {
//   final OnDaySelected onDaySelected;
//   // final DateTime selectedDay;
//   final DateTime focusedDay;

//   final List Function(DateTime day) eventLoader;

//   const EventCalendar({
//     super.key,
//     required this.onDaySelected,
//     required this.eventLoader,
//     // required this.selectedDay,
//     required this.focusedDay,
//   });

//   @override
//   State<EventCalendar> createState() => _EventCalendarState();
// }

// class _EventCalendarState extends State<EventCalendar> {
//   // DateTime _focusedDay = DateTime.now();
//   late DateTime _focusedDay;
//   late DateTime _selectedDay;

//   final _styles = const _CalendarStyles();

//   @override
//   void initState() {
//     super.initState();
//     _focusedDay = widget.focusedDay;
//     _selectedDay = _focusedDay;
//     print('INIT CALENDAR WIDGET');
//   }

//   void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
//     if (!isSameDay(_selectedDay, selectedDay)) {
//       print('SET STATE CALENDAR WIDGET');
//       setState(() {
//         _selectedDay = selectedDay;
//         _focusedDay = focusedDay;
//       });
//     }
//     widget.onDaySelected(selectedDay, focusedDay);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Section(
//       paddingHorizontal: 10,
//       paddingVertical: 17,
//       child: TableCalendar(
//         focusedDay: _focusedDay,
//         onDaySelected: _onDaySelected,
//         selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
//         locale: 'ru',
//         firstDay: DateTime.utc(2022),
//         lastDay: DateTime.utc(2030),
//         calendarBuilders: CalendarBuilders(
//           singleMarkerBuilder: (context, date, event) {
//             return Container(
//               width: 6,
//               height: 6,
//               margin: const EdgeInsets.symmetric(horizontal: 2),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color:
//                     date == _selectedDay ? Colors.white : CCAppColors.primary,
//               ), //Change color
//             );
//           },
//         ),
//         headerStyle: _styles.headerStyle,
//         calendarStyle: _styles.calendarStyle,
//         daysOfWeekStyle: _styles.daysOfWeekStyle,
//         daysOfWeekHeight: 45,
//         rowHeight: 55,
//         startingDayOfWeek: StartingDayOfWeek.monday,
//         eventLoader: widget.eventLoader,
//       ),
//     );
//   }
// }

class _CalendarStyles {
  final BoxDecoration itemDecoration = const BoxDecoration(
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );

  final TextStyle itemTextStyle = const TextStyle(
    color: CCAppColors.lightTextPrimary,
    fontWeight: FontWeight.w400,
    fontSize: 18,
  );

  const _CalendarStyles();

  String _formatTitle(DateTime date, dynamic locale) {
    final month = DateFormat.MMMM(locale).format(date).toCapitalized();
    final year = DateFormat.y(locale).format(date);

    return '$month, $year';
  }

  CalendarStyle get calendarStyle {
    return CalendarStyle(
      outsideDaysVisible: false,
      tablePadding: EdgeInsets.zero,
      cellMargin: const EdgeInsets.all(3),
      // default
      defaultTextStyle: itemTextStyle,
      defaultDecoration: itemDecoration,
      // selected
      selectedTextStyle:
          itemTextStyle.copyWith(color: CCAppColors.lightBackground),
      selectedDecoration: itemDecoration.copyWith(color: CCAppColors.primary),
      // today
      todayTextStyle: itemTextStyle.copyWith(color: CCAppColors.primary),
      todayDecoration: itemDecoration.copyWith(
        border: Border.all(color: CCAppColors.primary, width: 1),
      ),
      // weekend
      weekendTextStyle: itemTextStyle,
      weekendDecoration: itemDecoration,
      // event markers
      markersMaxCount: 3,
      markersOffset: const PositionedOffset(bottom: 10),
      markersAutoAligned: false,
    );
  }

  HeaderStyle get headerStyle {
    return HeaderStyle(
      titleCentered: true,
      titleTextStyle: const TextStyle(
        color: CCAppColors.lightTextPrimary,
        fontSize: 25,
        fontWeight: FontWeight.w700,
      ),
      titleTextFormatter: _formatTitle,
      formatButtonVisible: false,
      headerPadding: EdgeInsets.zero,
      leftChevronPadding: EdgeInsets.zero,
      rightChevronPadding: EdgeInsets.zero,
      formatButtonPadding: EdgeInsets.zero,
      leftChevronIcon: const Icon(
        Iconsax.arrow_left_2_copy,
        color: CCAppColors.secondary,
        size: 30,
      ),
      rightChevronIcon: const Icon(
        Iconsax.arrow_right_3_copy,
        color: CCAppColors.secondary,
        size: 30,
      ),
    );
  }

  DaysOfWeekStyle get daysOfWeekStyle {
    return const DaysOfWeekStyle(
      weekdayStyle: TextStyle(
        color: CCAppColors.lightTextSecodary,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      weekendStyle: TextStyle(
        color: CCAppColors.lightTextSecodary,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
