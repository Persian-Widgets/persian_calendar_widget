import 'package:persian_calendar_widget/core/data/enums/calendar_type.dart';
import 'package:shamsi_date/shamsi_date.dart';

extension DateDetails on DateTime {
  int fetchYear(CalendarType calendarType) {
    if (calendarType == CalendarType.persian) {
      return Jalali.fromDateTime(this).year;
    }
    return year;
  }

  int fetchMonth(CalendarType calendarType) {
    if (calendarType == CalendarType.persian) {
      return Jalali.fromDateTime(this).month;
    }
    return month;
  }

  int fetchDay(CalendarType calendarType) {
    if (calendarType == CalendarType.persian) {
      return Jalali.fromDateTime(this).day;
    }
    return day;
  }
}
