import 'package:intl/intl.dart';

extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  DateTime toDateTime(String format) {
    return DateFormat(format).parse(this);
  }
}

extension DateTimeExtension on DateTime {
  String toFormattedString(String format) {
    return DateFormat(format).format(this);
  }
}
