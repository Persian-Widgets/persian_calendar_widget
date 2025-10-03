import 'package:persian_calendar_widget/core/data/enums/first_day_of_week.dart';

class AppConstants {
  AppConstants._();

  static final Map<int, String> jalaliMonths = {
    1: 'فروردین',
    2: 'اردیبهشت',
    3: 'خرداد',
    4: 'تیر',
    5: 'مرداد',
    6: 'شهریور',
    7: 'مهر',
    8: 'آبان',
    9: 'آذر',
    10: 'دی',
    11: 'بهمن',
    12: 'اسفند',
  };
  static final Map<int, String> gregorianMonths = {
    1: 'ژانویه',
    2: 'فوریه',
    3: 'مارس',
    4: 'آوریل',
    5: 'مه',
    6: 'ژوئن',
    7: 'ژوئیه',
    8: 'اوت',
    9: 'سپتامبر',
    10: 'اکتبر',
    11: 'نوامبر',
    12: 'دسامبر',
  };

  static final Map<int, String> weekNames = {
    1: 'دوشنبه',
    2: 'سه‌شنبه',
    3: 'چهارشنبه',
    4: 'پنج‌شنبه',
    5: 'جمعه',
    6: 'شنبه',
    7: 'یکشنبه',
  };

  static final Map<int, String> weekCodes = {
    1: 'د',
    2: 'س',
    3: 'چ',
    4: 'پ',
    5: 'ج',
    6: 'ش',
    7: 'ی',
  };

  static Map<int, String> customWeekCodes(FirstDayOfWeek firstDayOfWeek) {
    if (firstDayOfWeek == FirstDayOfWeek.saturday) {
      return {
        1: 'ش',
        2: 'ی',
        3: 'د',
        4: 'س',
        5: 'چ',
        6: 'پ',
        7: 'ج',
      };
    }
    if (firstDayOfWeek == FirstDayOfWeek.sunday) {
      return {
        1: 'ی',
        2: 'د',
        3: 'س',
        4: 'چ',
        5: 'پ',
        6: 'ج',
        7: 'ش',
      };
    }

    return {
      1: 'د',
      2: 'س',
      3: 'چ',
      4: 'پ',
      5: 'ج',
      6: 'ش',
      7: 'ی',
    };
  }
}
