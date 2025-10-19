// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

import 'package:persian_calendar_widget/core/data/enums/calendar_type.dart';
import 'package:shamsi_date/shamsi_date.dart';

extension DateFormatter on DateTime {
  ({String jalali, String gregorian}) formatTo_dd_MMMM_yyyy(
    Map<int, String> jalaliMonths,
    Map<int, String> gregorianMonths,
  ) {
    final jalaliDate = toJalali();
    final gregorianDate = toGregorian();

    return (
      jalali:
          '${jalaliDate.day} ${jalaliMonths[jalaliDate.month]} ${jalaliDate.year}',
      gregorian:
          '${gregorianDate.day} ${gregorianMonths[gregorianDate.month]} ${gregorianDate.year}'
    );
  }

  ({String jalali, String gregorian}) formatTo_wN_dd_MMMM_yyyy(
    Map<int, String> jalaliMonths,
    Map<int, String> gregorianMonths,
    Map<int, String> weekNames,
  ) {
    final jalaliDate = toJalali();
    final gregorianDate = toGregorian();

    return (
      jalali:
          '${weekNames[weekday]} ${jalaliDate.day} ${jalaliMonths[jalaliDate.month]} ${jalaliDate.year}',
      gregorian:
          '${weekNames[weekday]} ${gregorianDate.day} ${gregorianMonths[gregorianDate.month]} ${gregorianDate.year}'
    );
  }

  ({String jalali, String gregorian}) formatTo_wC_dd_MMMM_yyyy(
    Map<int, String> jalaliMonths,
    Map<int, String> gregorianMonths,
    Map<int, String> defaultWeekCodes,
  ) {
    final jalaliDate = toJalali();
    final gregorianDate = toGregorian();

    return (
      jalali:
          '${defaultWeekCodes[weekday]} ${jalaliDate.day} ${jalaliMonths[jalaliDate.month]} ${jalaliDate.year}',
      gregorian:
          '${defaultWeekCodes[weekday]} ${gregorianDate.day} ${gregorianMonths[gregorianDate.month]} ${gregorianDate.year}'
    );
  }

  String formatTo_dd(CalendarType calendarType) {
    if (calendarType.isPersian) {
      final JalaliFormatter jFormattedDate =
          Jalali.fromDateTime(this).formatter;
      return jFormattedDate.d;
    }

    final GregorianFormatter gFormattedDate =
        Gregorian.fromDateTime(this).formatter;
    return gFormattedDate.d;
  }

  String formatTo_yyyy(CalendarType calendarType) {
    if (calendarType.isPersian) {
      final JalaliFormatter jFormattedDate =
          Jalali.fromDateTime(this).formatter;
      return jFormattedDate.yyyy;
    }

    final GregorianFormatter gFormattedDate =
        Gregorian.fromDateTime(this).formatter;
    return gFormattedDate.yyyy;
  }

  String fromatTo_MMMM(
    CalendarType calendarType,
    Map<int, String> jalaliMonths,
    Map<int, String> gregorianMonths,
  ) {
    return calendarType.isPersian
        ? jalaliMonths[toJalali().month] ?? ''
        : gregorianMonths[month] ?? '';
  }
}
