import 'package:intl/intl.dart';

class DateUtil {
  /// Converts ISO 8601 date string to 'dd MMM yyyy' format.
  /// Example: '2025-02-17T00:00:00' -> '17 Feb 2025'
  static String formatToDisplayDate(String isoDateString) {
    try {
      final DateTime parsedDate = DateTime.parse(isoDateString);
      final DateFormat formatter = DateFormat('dd MMM yyyy');
      return formatter.format(parsedDate);
    } catch (e) {
      // Handle parsing error
      return isoDateString; // or return ''
    }
  }

  static formatDisplayDateToServer(DateTime picked) {
    try {
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      return formatter.format(picked);
    } catch (e) {
      return "Invalid date"; // or return ''
    }
  }
}
