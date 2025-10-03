// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

import 'package:persian_calendar_widget/core/enum/enum.dart';
import 'package:persian_calendar_widget/core/utils/constants/app_constants.dart';
import 'package:shamsi_date/shamsi_date.dart';

extension DateFormatter on DateTime {
  ({String jalali, String gregorian}) formatTo_dd_MMMM_yyyy() {
    final jalaliDate = toJalali();
    final gregorianDate = toGregorian();

    return (
      jalali:
          '${jalaliDate.day} ${AppConstants.jalaliMonths[jalaliDate.month]} ${jalaliDate.year}',
      gregorian:
          '${gregorianDate.day} ${AppConstants.gregorianMonths[gregorianDate.month]} ${gregorianDate.year}'
    );
  }

  ({String jalali, String gregorian}) formatTo_wN_dd_MMMM_yyyy() {
    final jalaliDate = toJalali();
    final gregorianDate = toGregorian();

    return (
      jalali:
          '${AppConstants.weekNames[weekday]} ${jalaliDate.day} ${AppConstants.jalaliMonths[jalaliDate.month]} ${jalaliDate.year}',
      gregorian:
          '${AppConstants.weekNames[weekday]} ${gregorianDate.day} ${AppConstants.gregorianMonths[gregorianDate.month]} ${gregorianDate.year}'
    );
  }

  ({String jalali, String gregorian}) formatTo_wC_dd_MMMM_yyyy() {
    final jalaliDate = toJalali();
    final gregorianDate = toGregorian();

    return (
      jalali:
          '${AppConstants.weekCodes[weekday]} ${jalaliDate.day} ${AppConstants.jalaliMonths[jalaliDate.month]} ${jalaliDate.year}',
      gregorian:
          '${AppConstants.weekCodes[weekday]} ${gregorianDate.day} ${AppConstants.gregorianMonths[gregorianDate.month]} ${gregorianDate.year}'
    );
  }

  String formatTo_dd(CalendarType calendarType) {
    if (calendarType == CalendarType.persian) {
      final JalaliFormatter jFormattedDate =
          Jalali.fromDateTime(this).formatter;
      return jFormattedDate.d;
    }

    final GregorianFormatter gFormattedDate =
        Gregorian.fromDateTime(this).formatter;
    return gFormattedDate.d;
  }

  String formatTo_yyyy(CalendarType calendarType) {
    if (calendarType == CalendarType.persian) {
      final JalaliFormatter jFormattedDate =
          Jalali.fromDateTime(this).formatter;
      return jFormattedDate.yyyy;
    }

    final GregorianFormatter gFormattedDate =
        Gregorian.fromDateTime(this).formatter;
    return gFormattedDate.yyyy;
  }

  String fromatTo_MMMM(CalendarType calendarType) {
    return calendarType == CalendarType.persian
        ? AppConstants.jalaliMonths[toJalali().month] ?? ''
        : AppConstants.gregorianMonths[month] ?? '';
  }
}
