import 'package:intl/intl.dart';

class DateUtil {
  /// Converts a DateTime object to a time format (e.g., '10:30 PM').
  static String dateTimeToTimeFormat(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

  /// Converts a DateTime object to a specific date format (e.g., '10 March, 2024').
  static String dateTimeToDateFormat(DateTime dateTime,
      {String outputFormat = 'dd MMMM, yyyy'}) {
    return DateFormat(outputFormat).format(dateTime);
  }
}
