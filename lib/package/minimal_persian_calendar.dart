import 'package:flutter/material.dart';
import 'package:persian_calendar_widget/package/enum.dart';
import 'package:persian_calendar_widget/package/minimal_dialog_box.dart';
import 'package:shamsi_date/shamsi_date.dart';

typedef OnPickDate = void Function(Jalali jalaliDate, String dateInText);

class MinimalPersianCalendar {
  static void pickDay({
    required BuildContext context,
    required OnPickDate? onSubmit,
    DateTime? initialDate,
    double? borderRadius,
    Color? primaryColor,
    Color? onPrimaryColor,
    Color? background,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return MinimalDialogBox(
          initialDate: initialDate,
          onSubmit: onSubmit,
          borderRadius: borderRadius ?? 20.0,
          pickDateFormat: PickDateFormat.dd,
          maxYear: null,
          minYear: null,
          background: background,
          onPrimaryColor: onPrimaryColor,
          primaryColor: primaryColor,
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
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return MinimalDialogBox(
          initialDate: initialDate,
          onSubmit: onSubmit,
          borderRadius: borderRadius ?? 20.0,
          pickDateFormat: PickDateFormat.ddMM,
          maxYear: null,
          minYear: null,
          background: background,
          onPrimaryColor: onPrimaryColor,
          primaryColor: primaryColor,
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
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return MinimalDialogBox(
          initialDate: initialDate,
          onSubmit: onSubmit,
          borderRadius: borderRadius ?? 20.0,
          pickDateFormat: PickDateFormat.ddMMyyyy,
          maxYear: maxYear,
          minYear: minYear,
          background: background,
          onPrimaryColor: onPrimaryColor,
          primaryColor: primaryColor,
        );
      },
    );
  }
}
