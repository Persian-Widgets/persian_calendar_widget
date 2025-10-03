import 'package:shamsi_date/shamsi_date.dart';

extension ParseCalendarToAllTypes on DateTime {
  ({Jalali jalali, Gregorian gregorian}) get parseToAllCalendars {
    final jalaliDate = toJalali();
    final gregorianDate = toGregorian();
    return (jalali: jalaliDate, gregorian: gregorianDate);
  }
}
