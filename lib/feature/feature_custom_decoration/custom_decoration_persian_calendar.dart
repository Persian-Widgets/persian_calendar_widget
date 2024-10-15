import 'package:flutter/material.dart';
import 'package:persian_calendar_widget/core/enum/enum.dart';
import 'package:persian_calendar_widget/feature/feature_dialog_box/date_picker_dialog_box.dart';
import 'package:persian_calendar_widget/feature/feature_dialog_box/date_picker_dialog_box_without_day.dart';
import 'package:shamsi_date/shamsi_date.dart';

typedef OnPickDate = void Function(Jalali jalaliDate, String dateInText);

class CustomDecorationPersianCalendar {
  static void pickDay({
    required BuildContext context,
    required OnPickDate? onSubmit,
    DateTime? initialDate,
    double? borderRadius,
    Color? primaryColor,
    Color? onPrimaryColor,
    Color? background,
    BoxDecoration? titleBoxStyle,
    ButtonStyle? titleButtonStyle,
    ButtonStyle? titleSelectedButtonStyle,
    TextStyle? titleTextStyle,
    TextStyle? titleSelectedTextStyle,
    ButtonStyle? dateButtonStyle,
    ButtonStyle? dateSelectedButtonStyle,
    TextStyle? dateTextStyle,
    TextStyle? dateSelectedTextStyle,
    ButtonStyle? submitButtonStyle,
    TextStyle? submitTextStyle,
    ButtonStyle? cancelButtonStyle,
    TextStyle? cancelTextStyle,
    String? submitTitle,
    String? cancelTitle,
    bool? showTodayBanner,
    TextStyle? todayDateBannerTextStyle,
    bool? useGoToTodayButton,
    String? goTitle,
    TextStyle? goTextStyle,
    ButtonStyle? goButtonStyle,
    BoxDecoration? weekDaysBoxStyle,
    EdgeInsetsGeometry? weekDaysPadding,
    TextStyle? weekDaysTextStyle,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return DatePickerDialogBox(
          initialDate: initialDate,
          onSubmit: onSubmit,
          borderRadius: borderRadius ?? 20.0,
          pickDateFormat: PickDateFormat.dd,
          maxYear: null,
          minYear: null,
          background: background,
          onPrimaryColor: onPrimaryColor,
          primaryColor: primaryColor,
          cancelButtonStyle: cancelButtonStyle,
          cancelTextStyle: cancelTextStyle,
          cancelTitle: cancelTitle,
          submitButtonStyle: submitButtonStyle,
          submitTextStyle: submitTextStyle,
          submitTitle: submitTitle,
          dateButtonStyle: dateButtonStyle,
          dateSelectedButtonStyle: dateSelectedButtonStyle,
          dateSelectedTextStyle: dateSelectedTextStyle,
          dateTextStyle: dateTextStyle,
          titleBoxStyle: titleBoxStyle,
          titleButtonStyle: titleButtonStyle,
          titleSelectedButtonStyle: titleSelectedButtonStyle,
          titleSelectedTextStyle: titleSelectedTextStyle,
          titleTextStyle: titleTextStyle,
          calendarType: CalendarType.persian,
          showTodayBanner: showTodayBanner ?? false,
          todayDateBannerTextStyle: todayDateBannerTextStyle,
          useGoToTodayButton: useGoToTodayButton ?? false,
          goTitle: goTitle,
          goButtonStyle: goButtonStyle,
          goTextStyle: goTextStyle,
          weekDaysBoxStyle: weekDaysBoxStyle,
          weekDaysPadding: weekDaysPadding,
          weekDaysTextStyle: weekDaysTextStyle,
        );
      },
    );
  }

  static void pickMonthAndDay({
    required BuildContext context,
    required OnPickDate? onSubmit,
    DateTime? initialDate,
    double? borderRadius,
    Color? primaryColor,
    Color? onPrimaryColor,
    Color? background,
    BoxDecoration? titleBoxStyle,
    ButtonStyle? titleButtonStyle,
    ButtonStyle? titleSelectedButtonStyle,
    TextStyle? titleTextStyle,
    TextStyle? titleSelectedTextStyle,
    ButtonStyle? dateButtonStyle,
    ButtonStyle? dateSelectedButtonStyle,
    TextStyle? dateTextStyle,
    TextStyle? dateSelectedTextStyle,
    ButtonStyle? submitButtonStyle,
    TextStyle? submitTextStyle,
    ButtonStyle? cancelButtonStyle,
    TextStyle? cancelTextStyle,
    String? submitTitle,
    String? cancelTitle,
    bool? showTodayBanner,
    TextStyle? todayDateBannerTextStyle,
    bool? useGoToTodayButton,
    String? goTitle,
    TextStyle? goTextStyle,
    ButtonStyle? goButtonStyle,
    BoxDecoration? weekDaysBoxStyle,
    EdgeInsetsGeometry? weekDaysPadding,
    TextStyle? weekDaysTextStyle,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return DatePickerDialogBox(
          initialDate: initialDate,
          onSubmit: onSubmit,
          borderRadius: borderRadius ?? 20.0,
          pickDateFormat: PickDateFormat.ddMM,
          maxYear: null,
          minYear: null,
          background: background,
          onPrimaryColor: onPrimaryColor,
          primaryColor: primaryColor,
          cancelButtonStyle: cancelButtonStyle,
          cancelTextStyle: cancelTextStyle,
          cancelTitle: cancelTitle,
          submitButtonStyle: submitButtonStyle,
          submitTextStyle: submitTextStyle,
          submitTitle: submitTitle,
          dateButtonStyle: dateButtonStyle,
          dateSelectedButtonStyle: dateSelectedButtonStyle,
          dateSelectedTextStyle: dateSelectedTextStyle,
          dateTextStyle: dateTextStyle,
          titleBoxStyle: titleBoxStyle,
          titleButtonStyle: titleButtonStyle,
          titleSelectedButtonStyle: titleSelectedButtonStyle,
          titleSelectedTextStyle: titleSelectedTextStyle,
          titleTextStyle: titleTextStyle,
          calendarType: CalendarType.persian,
          showTodayBanner: showTodayBanner ?? false,
          todayDateBannerTextStyle: todayDateBannerTextStyle,
          useGoToTodayButton: useGoToTodayButton ?? false,
          goTitle: goTitle,
          goButtonStyle: goButtonStyle,
          goTextStyle: goTextStyle,
          weekDaysBoxStyle: weekDaysBoxStyle,
          weekDaysPadding: weekDaysPadding,
          weekDaysTextStyle: weekDaysTextStyle,
        );
      },
    );
  }

  static void pickFullDate({
    required BuildContext context,
    required OnPickDate? onSubmit,
    DateTime? initialDate,
    int? maxYear,
    int? minYear,
    double? borderRadius,
    Color? primaryColor,
    Color? onPrimaryColor,
    Color? background,
    BoxDecoration? titleBoxStyle,
    ButtonStyle? titleButtonStyle,
    ButtonStyle? titleSelectedButtonStyle,
    TextStyle? titleTextStyle,
    TextStyle? titleSelectedTextStyle,
    ButtonStyle? dateButtonStyle,
    ButtonStyle? dateSelectedButtonStyle,
    TextStyle? dateTextStyle,
    TextStyle? dateSelectedTextStyle,
    ButtonStyle? submitButtonStyle,
    TextStyle? submitTextStyle,
    ButtonStyle? cancelButtonStyle,
    TextStyle? cancelTextStyle,
    String? submitTitle,
    String? cancelTitle,
    bool? showTodayBanner,
    TextStyle? todayDateBannerTextStyle,
    bool? useGoToTodayButton,
    String? goTitle,
    TextStyle? goTextStyle,
    ButtonStyle? goButtonStyle,
    BoxDecoration? weekDaysBoxStyle,
    EdgeInsetsGeometry? weekDaysPadding,
    TextStyle? weekDaysTextStyle,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return DatePickerDialogBox(
          initialDate: initialDate,
          onSubmit: onSubmit,
          borderRadius: borderRadius ?? 20.0,
          pickDateFormat: PickDateFormat.ddMMyyyy,
          maxYear: maxYear,
          minYear: minYear,
          background: background,
          onPrimaryColor: onPrimaryColor,
          primaryColor: primaryColor,
          cancelButtonStyle: cancelButtonStyle,
          cancelTextStyle: cancelTextStyle,
          cancelTitle: cancelTitle,
          submitButtonStyle: submitButtonStyle,
          submitTextStyle: submitTextStyle,
          submitTitle: submitTitle,
          dateButtonStyle: dateButtonStyle,
          dateSelectedButtonStyle: dateSelectedButtonStyle,
          dateSelectedTextStyle: dateSelectedTextStyle,
          dateTextStyle: dateTextStyle,
          titleBoxStyle: titleBoxStyle,
          titleButtonStyle: titleButtonStyle,
          titleSelectedButtonStyle: titleSelectedButtonStyle,
          titleSelectedTextStyle: titleSelectedTextStyle,
          titleTextStyle: titleTextStyle,
          calendarType: CalendarType.persian,
          showTodayBanner: showTodayBanner ?? false,
          todayDateBannerTextStyle: todayDateBannerTextStyle,
          useGoToTodayButton: useGoToTodayButton ?? false,
          goTitle: goTitle,
          goButtonStyle: goButtonStyle,
          goTextStyle: goTextStyle,
          weekDaysBoxStyle: weekDaysBoxStyle,
          weekDaysPadding: weekDaysPadding,
          weekDaysTextStyle: weekDaysTextStyle,
        );
      },
    );
  }

  static void pickYearAndMonth({
    required BuildContext context,
    required OnPickDateWithoutDay? onSubmit,
    DateTime? initialDate,
    int? maxYear,
    int? minYear,
    double? borderRadius,
    Color? primaryColor,
    Color? onPrimaryColor,
    Color? background,
    BoxDecoration? titleBoxStyle,
    ButtonStyle? titleButtonStyle,
    ButtonStyle? titleSelectedButtonStyle,
    TextStyle? titleTextStyle,
    TextStyle? titleSelectedTextStyle,
    ButtonStyle? dateButtonStyle,
    ButtonStyle? dateSelectedButtonStyle,
    TextStyle? dateTextStyle,
    TextStyle? dateSelectedTextStyle,
    ButtonStyle? submitButtonStyle,
    TextStyle? submitTextStyle,
    ButtonStyle? cancelButtonStyle,
    TextStyle? cancelTextStyle,
    String? submitTitle,
    String? cancelTitle,
    bool? showTodayBanner,
    TextStyle? todayDateBannerTextStyle,
    bool? useGoToTodayButton,
    String? goTitle,
    TextStyle? goTextStyle,
    ButtonStyle? goButtonStyle,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return DatePickerDialogBoxWithoutDay(
          initialDate: initialDate,
          onSubmit: onSubmit,
          borderRadius: borderRadius ?? 20.0,
          maxYear: maxYear,
          minYear: minYear,
          background: background,
          onPrimaryColor: onPrimaryColor,
          primaryColor: primaryColor,
          cancelButtonStyle: cancelButtonStyle,
          cancelTextStyle: cancelTextStyle,
          cancelTitle: cancelTitle,
          submitButtonStyle: submitButtonStyle,
          submitTextStyle: submitTextStyle,
          submitTitle: submitTitle,
          dateButtonStyle: dateButtonStyle,
          dateSelectedButtonStyle: dateSelectedButtonStyle,
          dateSelectedTextStyle: dateSelectedTextStyle,
          dateTextStyle: dateTextStyle,
          titleBoxStyle: titleBoxStyle,
          titleButtonStyle: titleButtonStyle,
          titleSelectedButtonStyle: titleSelectedButtonStyle,
          titleSelectedTextStyle: titleSelectedTextStyle,
          titleTextStyle: titleTextStyle,
          calendarType: CalendarType.persian,
          showTodayBanner: showTodayBanner ?? false,
          todayDateBannerTextStyle: todayDateBannerTextStyle,
          useGoToTodayButton: useGoToTodayButton ?? false,
          goTitle: goTitle,
          goButtonStyle: goButtonStyle,
          goTextStyle: goTextStyle,
        );
      },
    );
  }
}
