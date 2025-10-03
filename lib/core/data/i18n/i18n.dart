import 'package:persian_calendar_widget/core/data/i18n/i18n_buttons.dart';
import 'package:persian_calendar_widget/core/data/i18n/i18n_gregorian_months.dart';
import 'package:persian_calendar_widget/core/data/i18n/i18n_persian_months.dart';
import 'package:persian_calendar_widget/core/data/i18n/i18n_week_codes.dart';
import 'package:persian_calendar_widget/core/data/i18n/i18n_week_names.dart';

export 'package:persian_calendar_widget/core/data/i18n/i18n_buttons.dart';
export 'package:persian_calendar_widget/core/data/i18n/i18n_gregorian_months.dart';
export 'package:persian_calendar_widget/core/data/i18n/i18n_persian_months.dart';
export 'package:persian_calendar_widget/core/data/i18n/i18n_week_codes.dart';
export 'package:persian_calendar_widget/core/data/i18n/i18n_week_names.dart';

class I18n {
  final I18nButtons buttons;
  final I18nPersianMonths persianMonths;
  final I18nGregorianMonths gregorianMonths;
  final I18nWeekNames weekNames;
  final I18nWeekCodes weekCodes;

  const I18n({
    this.persianMonths = const I18nPersianMonths(),
    this.gregorianMonths = const I18nGregorianMonths(),
    this.weekCodes = const I18nWeekCodes(),
    this.weekNames = const I18nWeekNames(),
    this.buttons = const I18nButtons(),
  });
}
