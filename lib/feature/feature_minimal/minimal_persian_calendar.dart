import 'package:flutter/material.dart';
import 'package:persian_calendar_widget/core/enum/enum.dart';
import 'package:persian_calendar_widget/feature/feature_dialog_box/date_picker_dialog_box.dart';

class MinimalPersianCalendar {
  static void pickDay({
    required BuildContext context,
    required OnPickDate? onSubmit,
    DateTime? initialDate,
    double? borderRadius,
    Color? primaryColor,
    Color? onPrimaryColor,
    Color? background,
    TextStyle? titleTextStyle,
    TextStyle? titleSelectedTextStyle,
    TextStyle? dateTextStyle,
    TextStyle? dateSelectedTextStyle,
    TextStyle? submitTextStyle,
    TextStyle? cancelTextStyle,
    String? submitTitle,
    String? cancelTitle,
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
          cancelButtonStyle: null,
          cancelTextStyle: cancelTextStyle,
          cancelTitle: cancelTitle,
          submitButtonStyle: null,
          submitTextStyle: submitTextStyle,
          submitTitle: submitTitle,
          dateButtonStyle: null,
          dateSelectedButtonStyle: null,
          dateSelectedTextStyle: dateSelectedTextStyle,
          dateTextStyle: dateTextStyle,
          titleBoxStyle: null,
          titleButtonStyle: null,
          titleSelectedButtonStyle: null,
          titleSelectedTextStyle: titleSelectedTextStyle,
          titleTextStyle: titleTextStyle,
          calendarType: CalendarType.persian,
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
    TextStyle? titleTextStyle,
    TextStyle? titleSelectedTextStyle,
    TextStyle? dateTextStyle,
    TextStyle? dateSelectedTextStyle,
    TextStyle? submitTextStyle,
    TextStyle? cancelTextStyle,
    String? submitTitle,
    String? cancelTitle,
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
          cancelButtonStyle: null,
          cancelTextStyle: cancelTextStyle,
          cancelTitle: cancelTitle,
          submitButtonStyle: null,
          submitTextStyle: submitTextStyle,
          submitTitle: submitTitle,
          dateButtonStyle: null,
          dateSelectedButtonStyle: null,
          dateSelectedTextStyle: dateSelectedTextStyle,
          dateTextStyle: dateTextStyle,
          titleBoxStyle: null,
          titleButtonStyle: null,
          titleSelectedButtonStyle: null,
          titleSelectedTextStyle: titleSelectedTextStyle,
          titleTextStyle: titleTextStyle,
          calendarType: CalendarType.persian,
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
    TextStyle? titleTextStyle,
    TextStyle? titleSelectedTextStyle,
    TextStyle? dateTextStyle,
    TextStyle? dateSelectedTextStyle,
    TextStyle? submitTextStyle,
    TextStyle? cancelTextStyle,
    String? submitTitle,
    String? cancelTitle,
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
          cancelButtonStyle: null,
          cancelTextStyle: cancelTextStyle,
          cancelTitle: cancelTitle,
          submitButtonStyle: null,
          submitTextStyle: submitTextStyle,
          submitTitle: submitTitle,
          dateButtonStyle: null,
          dateSelectedButtonStyle: null,
          dateSelectedTextStyle: dateSelectedTextStyle,
          dateTextStyle: dateTextStyle,
          titleBoxStyle: null,
          titleButtonStyle: null,
          titleSelectedButtonStyle: null,
          titleSelectedTextStyle: titleSelectedTextStyle,
          titleTextStyle: titleTextStyle,
          calendarType: CalendarType.persian,
        );
      },
    );
  }
}
