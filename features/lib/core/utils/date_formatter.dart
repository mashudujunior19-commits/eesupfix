import 'package:intl/intl.dart';

class DateFormatter {
  static String formatTime(DateTime date) {
    String formattedDate = DateFormat('HH:mm', 'en_US').format(date);
    return formattedDate;
  }

  static String yetAnotherDateFormat(DateTime date) {
    String formattedDate = DateFormat('yyy-MM-dd', 'en_US').format(date);
    return formattedDate;
  }

  static String yetAnotherDateFormat2(DateTime date) {
    String formattedDate =
        DateFormat('yyy-MM-dd HH:mm a', 'en_US').format(date);
    return formattedDate;
  }

  static String formatDate(DateTime date) {
    return DateFormat('yyy-MM-dd', 'en_US').format(date);
  }

  static String formatDateAndTime(DateTime date) {
    return DateFormat.yMMMMEEEEd().add_jm().format(date);
  }

  static String formatDateToNameday(DateTime date) {
    return DateFormat.yMMMMEEEEd().format(date);
  }

  static String formatDateToNamedayWithTime(DateTime date) {
    //with 24 hour format
    //wit PM or AM
    return '${DateFormat.yMMMMEEEEd().format(date)} at ${formatTime(date)}';
  }

  static String formatDateToNamedayWithTime3(DateTime date) {
    //with 24 hour format
    //wit PM or AM
    return DateFormat.yMMMMd().format(date);
  }

  static String formatDateToNamedayWithTime2(DateTime date) {
    //with 24 hour format
    //wit PM or AM
    return DateFormat.yMMMEd().add_jm().format(date);
  }

//get a string like 18 Dec from a date
  String formatDateToDayMonth(DateTime date) {
    String formattedDate = DateFormat('dd MMM').format(date);
    return formattedDate;
  }
}
