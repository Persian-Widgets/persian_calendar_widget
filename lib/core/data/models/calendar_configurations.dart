import 'package:persian_calendar_widget/core/data/enums/calendar_type.dart';
import 'package:persian_calendar_widget/core/data/enums/first_day_of_week.dart';
import 'package:shamsi_date/shamsi_date.dart';

class CalendarConfigurations {
  final CalendarType calendarType;
  final int maxYear;
  final int minYear;
  final DateTime initDate;
  final FirstDayOfWeek firstDayOfWeek;

  CalendarConfigurations({
    this.calendarType = CalendarType.persian,
    FirstDayOfWeek? firstDayOfWeek,
    int? maxYear,
    int? minYear,
    DateTime? initDate,
  })  : initDate = initDate ?? DateTime.now(),
        firstDayOfWeek = firstDayOfWeek ?? FirstDayOfWeek.saturday,
        minYear = minYear ??
            (calendarType.isPersian
                ? (initDate ?? DateTime.now()).toJalali().year
                : (initDate ?? DateTime.now()).year),
        maxYear = maxYear ??
            ((calendarType.isPersian
                    ? (initDate ?? DateTime.now()).toJalali().year
                    : (initDate ?? DateTime.now()).year) +
                11) {
    // if (minYear! > maxYear!) {
    //   throw Exception('minYear must be less than or equal to maxYear');
    // }
    // if (calendarType.isPersian) {
    //   final int initYear = initDate!.toJalali().year;
    //   if (initYear < minYear || initYear > maxYear) {
    //     throw Exception('initDate year must be between minYear and maxYear');
    //   }
    // }
    // if (calendarType.isGregorian) {
    //   final int initYear = initDate!.year;
    //   if (initYear < minYear || initYear > maxYear) {
    //     throw Exception('initDate year must be between minYear and maxYear');
    //   }
    // }
  }

  CalendarConfigurations copyWith({
    CalendarType? calendarType,
    int? maxYear,
    int? minYear,
    DateTime? initDate,
    FirstDayOfWeek? firstDayOfWeek,
  }) {
    return CalendarConfigurations(
      calendarType: calendarType ?? this.calendarType,
      maxYear: maxYear ?? this.maxYear,
      minYear: minYear ?? this.minYear,
      initDate: initDate ?? this.initDate,
      firstDayOfWeek: firstDayOfWeek ?? this.firstDayOfWeek,
    );
  }
}
