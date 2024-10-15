import 'package:flutter/material.dart';
import 'package:persian_calendar_widget/core/extension/scale_down_box.dart';
import 'package:persian_calendar_widget/core/extension/to_persian_digit.dart';
import 'package:persian_calendar_widget/core/utils/constants/app_constants.dart';
import 'package:shamsi_date/shamsi_date.dart';

class DayPageView extends StatelessWidget {
  final Jalali selectedDate;
  final int selectedMonths;
  final int selectedYear;
  final int selectedDay;
  final ButtonStyle? dateButtonStyle;
  final ButtonStyle? dateSelectedButtonStyle;
  final Color? primaryColor;
  final Color? onPrimaryColor;
  final bool isPersian;
  final Function(int currentDay) onPressed;
  final Widget child;
  final TextStyle? dateSelectedTextStyle;
  final TextStyle? dateTextStyle;

  const DayPageView({
    required this.selectedDate,
    required this.selectedMonths,
    required this.selectedYear,
    required this.selectedDay,
    required this.dateButtonStyle,
    required this.onPrimaryColor,
    required this.primaryColor,
    required this.dateSelectedButtonStyle,
    required this.isPersian,
    required this.onPressed,
    required this.child,
    required this.dateSelectedTextStyle,
    required this.dateTextStyle,
    Key? key,
  }) : super(key: key);

  (int, int) getSelectedDateLength() {
    int monthLength = selectedDate.monthLength;
    final Jalali thisMonthInfo = Jalali(selectedYear, selectedMonths);
    final String weekNameOfFirstDay =
        thisMonthInfo.formatter.wN.substring(0, 1);
    final int weekDayNumber = AppConstants.weekMap.entries
        .firstWhere(
          (element) => element.value == weekNameOfFirstDay,
        )
        .key;
    monthLength = monthLength + weekDayNumber - 1;
    return (monthLength, weekDayNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          top: 51,
          child: GridView.builder(
            padding: const EdgeInsets.only(
              right: 12,
              left: 12,
              top: 3,
              bottom: 5,
            ),
            shrinkWrap: true,
            // physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
            ),
            itemCount: getSelectedDateLength().$1,
            itemBuilder: (context, index) {
              final int currentDay = index + 2 - getSelectedDateLength().$2;

              if (currentDay < 1) {
                return const SizedBox.shrink();
              }

              return TextButton(
                style: dateButtonStyle == null
                    ? TextButton.styleFrom(
                        backgroundColor: selectedDay == currentDay
                            ? primaryColor ?? Theme.of(context).primaryColor
                            : Colors.transparent,
                        padding: EdgeInsets.zero,
                      )
                    : selectedDay == currentDay
                        ? dateSelectedButtonStyle ?? dateButtonStyle
                        : dateButtonStyle,
                child: Text(
                  isPersian ? '$currentDay'.toPersianDigit() : '$currentDay',
                  style: dateTextStyle == null
                      ? TextStyle(
                          color: selectedDay == currentDay
                              ? onPrimaryColor ?? Colors.white
                              : primaryColor,
                        )
                      : selectedDay == currentDay
                          ? dateSelectedTextStyle ?? dateTextStyle
                          : dateTextStyle,
                ).scaleDown,
                onPressed: () => onPressed(currentDay),
              );
            },
          ),
        ),
        child,
      ],
    );
  }
}
