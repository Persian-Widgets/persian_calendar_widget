import 'package:persian_calendar_widget/core/data/enums/first_day_of_week.dart';
import 'package:persian_calendar_widget/core/data/i18n/i18n.dart';

class InitCalendarHelper {
  static Map<int, String> initJalaliMonths(I18n i18n) {
    return {
      1: i18n.persianMonths.farvardin,
      2: i18n.persianMonths.ordibehesht,
      3: i18n.persianMonths.khordad,
      4: i18n.persianMonths.tir,
      5: i18n.persianMonths.mordad,
      6: i18n.persianMonths.shahrivar,
      7: i18n.persianMonths.mehr,
      8: i18n.persianMonths.aban,
      9: i18n.persianMonths.azar,
      10: i18n.persianMonths.dey,
      11: i18n.persianMonths.bahman,
      12: i18n.persianMonths.esfand,
    };
  }

  static Map<int, String> initGregorianMonths(I18n i18n) {
    return {
      1: i18n.gregorianMonths.january,
      2: i18n.gregorianMonths.february,
      3: i18n.gregorianMonths.march,
      4: i18n.gregorianMonths.april,
      5: i18n.gregorianMonths.may,
      6: i18n.gregorianMonths.june,
      7: i18n.gregorianMonths.july,
      8: i18n.gregorianMonths.august,
      9: i18n.gregorianMonths.september,
      10: i18n.gregorianMonths.october,
      11: i18n.gregorianMonths.november,
      12: i18n.gregorianMonths.december,
    };
  }

  static Map<int, String> initDefaultWeekCodes(I18n i18n) {
    return {
      1: i18n.weekCodes.monday,
      2: i18n.weekCodes.tuesday,
      3: i18n.weekCodes.wednesday,
      4: i18n.weekCodes.thursday,
      5: i18n.weekCodes.friday,
      6: i18n.weekCodes.saturday,
      7: i18n.weekCodes.sunday,
    };
  }

  static Map<int, String> initWeekNames(I18n i18n) {
    return {
      1: i18n.weekNames.monday,
      2: i18n.weekNames.tuesday,
      3: i18n.weekNames.wednesday,
      4: i18n.weekNames.thursday,
      5: i18n.weekNames.friday,
      6: i18n.weekNames.saturday,
      7: i18n.weekNames.sunday,
    };
  }

  static Map<int, String> initCustomWeekCodes(
    FirstDayOfWeek firstDayOfWeek,
    I18n i18n,
  ) {
    if (firstDayOfWeek == FirstDayOfWeek.saturday) {
      return {
        1: i18n.weekCodes.saturday,
        2: i18n.weekCodes.sunday,
        3: i18n.weekCodes.monday,
        4: i18n.weekCodes.tuesday,
        5: i18n.weekCodes.wednesday,
        6: i18n.weekCodes.thursday,
        7: i18n.weekCodes.friday,
      };
    }
    if (firstDayOfWeek == FirstDayOfWeek.sunday) {
      return {
        1: i18n.weekCodes.sunday,
        2: i18n.weekCodes.monday,
        3: i18n.weekCodes.tuesday,
        4: i18n.weekCodes.wednesday,
        5: i18n.weekCodes.thursday,
        6: i18n.weekCodes.friday,
        7: i18n.weekCodes.saturday,
      };
    }

    return {
      1: i18n.weekCodes.monday,
      2: i18n.weekCodes.tuesday,
      3: i18n.weekCodes.wednesday,
      4: i18n.weekCodes.thursday,
      5: i18n.weekCodes.friday,
      6: i18n.weekCodes.saturday,
      7: i18n.weekCodes.sunday,
    };
  }
}
