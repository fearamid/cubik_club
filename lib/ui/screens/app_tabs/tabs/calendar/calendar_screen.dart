import 'package:cubik_club/ui/common/widgets/components/section.dart';
import 'package:cubik_club/utils/constants/colors.dart';
import 'package:cubik_club/utils/extensions/string_casing_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              const SizedBox(height: kToolbarHeight),
              const _Calendar(),
            ],
          ),
        ),
      ],
    );
  }
}

class _Calendar extends StatefulWidget {
  const _Calendar({super.key});

  @override
  State<_Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<_Calendar> {
  late DateTime _selectedDay;
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    _selectedDay = _focusedDay;
    super.initState();
  }

  String formatTitle(DateTime date, dynamic locale) {
    final month = DateFormat.MMMM(locale).format(date).toCapitalized();
    final year = DateFormat.y(locale).format(date);

    return '$month, $year';
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    _selectedDay = selectedDay;
    _focusedDay = _selectedDay;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final headerStyle = HeaderStyle(
      titleCentered: true,
      titleTextStyle: const TextStyle(
        color: CCAppColors.lightTextPrimary,
        fontSize: 25,
        fontWeight: FontWeight.w700,
      ),
      titleTextFormatter: formatTitle,
      formatButtonVisible: false,
      headerPadding: EdgeInsets.zero,
      leftChevronPadding: EdgeInsets.zero,
      rightChevronPadding: EdgeInsets.zero,
      formatButtonPadding: EdgeInsets.zero,
    );

    final calendarStyle = CalendarStyle(
      outsideDaysVisible: false,
      defaultTextStyle: const TextStyle(
        color: CCAppColors.lightTextPrimary,
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
      weekendTextStyle: const TextStyle(
        color: CCAppColors.lightTextPrimary,
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
      selectedTextStyle: const TextStyle(
        color: CCAppColors.lightBackground,
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
      todayTextStyle: const TextStyle(
        color: CCAppColors.primary,
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
      selectedDecoration: BoxDecoration(
        color: CCAppColors.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      todayDecoration: BoxDecoration(
        border: Border.all(
          color: CCAppColors.primary,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      tablePadding: EdgeInsets.zero,
    );

    const daysOfWeekStyle = DaysOfWeekStyle(
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

    return Section(
      paddingHorizontal: 15,
      paddingVertical: 20,
      child: TableCalendar(
        onDaySelected: onDaySelected,
        locale: 'ru',
        firstDay: DateTime.utc(2010, 10, 10),
        lastDay: DateTime.utc(2030, 10, 10),
        headerStyle: headerStyle,
        calendarStyle: calendarStyle,
        daysOfWeekStyle: daysOfWeekStyle,
        daysOfWeekHeight: 45,
        startingDayOfWeek: StartingDayOfWeek.monday,
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
        holidayPredicate: (day) {
          return day.weekday >= 6;
        },
      ),
    );
  }
}
