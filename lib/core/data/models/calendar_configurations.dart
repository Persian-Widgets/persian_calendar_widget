import 'package:persian_calendar_widget/core/enum/enum.dart';
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
            (calendarType == CalendarType.persian
                ? (initDate ?? DateTime.now()).toJalali().year
                : (initDate ?? DateTime.now()).year),
        maxYear = maxYear ??
            ((calendarType == CalendarType.persian
                    ? (initDate ?? DateTime.now()).toJalali().year
                    : (initDate ?? DateTime.now()).year) +
                11) {
    // if (minYear! > maxYear!) {
    //   throw Exception('minYear must be less than or equal to maxYear');
    // }
    // if (calendarType == CalendarType.persian) {
    //   final int initYear = initDate!.toJalali().year;
    //   if (initYear < minYear || initYear > maxYear) {
    //     throw Exception('initDate year must be between minYear and maxYear');
    //   }
    // }
    // if (calendarType == CalendarType.gregorian) {
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
