import 'package:intl/intl.dart';

abstract class CCFormatter {
  // static String formatDate(DateTime? date) {
  //   date ??= DateTime.now();
  //   return DateFormat('dd-MMM-yyyy').format(date);
  // }

  static String formatEventTimeRange({
    required DateTime start,
    required DateTime end,
  }) {
    final timeFormatter = DateFormat('HH:MM');
    return '${timeFormatter.format(start)} — ${timeFormatter.format(end)}';
  }

  static String formatEventDate(DateTime date) {
    return DateFormat.MMMMd('ru').format(date);
  }

  static String formatPhoneNumber(String phoneNumber) {
    return phoneNumber;
  }
}
