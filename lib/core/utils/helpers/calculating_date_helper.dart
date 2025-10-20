import 'package:persian_calendar_widget/core/data/enums/calendar_type.dart';
import 'package:persian_calendar_widget/core/data/models/calendar_configurations.dart';
import 'package:shamsi_date/shamsi_date.dart';

class CalculatingDateHelper {
  static List<int> getCalendarYears(CalendarConfigurations config) {
    final int maxYear = config.maxYear;
    final int minYear = config.minYear;

    return List.generate(maxYear - minYear + 1, (index) => minYear + index);
  }

  static DateTime adjustDateTimeBySingleComponent({
    required DateTime original,
    required CalendarType calendarType,
    int? selectedYear,
    int? selectedMonth,
    int? selectedDay,
  }) {
    if (calendarType.isGregorian) {
      final int year = selectedYear ?? original.year;
      final int month = selectedMonth ?? original.month;
      final int day = selectedDay ?? original.day;

      // Clamp day to valid range
      final int maxDay = DateTime(year, month + 1, 0).day;
      final int safeDay = day.clamp(1, maxDay);

      return DateTime(year, month, safeDay);
    }

    final Jalali jOriginal = Jalali.fromDateTime(original);

    final int year = selectedYear ?? jOriginal.year;
    final int month = selectedMonth ?? jOriginal.month;
    final int day = selectedDay ?? jOriginal.day;

    // Clamp day to valid range
    final int maxDay = Jalali(year, month).monthLength;
    final int safeDay = day.clamp(1, maxDay);

    final Jalali jDate = Jalali(year, month, safeDay);
    return jDate.toDateTime();
  }
}
