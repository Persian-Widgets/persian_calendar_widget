// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_calendar_widget/core/bloc/date_picker_bloc/date_picker_bloc.dart';
import 'package:persian_calendar_widget/core/data/enums/calendar_type.dart';
import 'package:persian_calendar_widget/core/data/enums/first_day_of_week.dart';
import 'package:persian_calendar_widget/core/extension/date_details.dart';
import 'package:persian_calendar_widget/core/extension/scale_down_box.dart';
import 'package:shamsi_date/shamsi_date.dart';

class DayPageView extends StatefulWidget {
  final ButtonStyle? dateButtonStyle;
  final ButtonStyle? dateSelectedButtonStyle;
  final Color? primaryColor;
  final Color? onPrimaryColor;
  final Widget child;
  final TextStyle? dateSelectedTextStyle;
  final TextStyle? dateTextStyle;

  const DayPageView({
    required this.dateButtonStyle,
    required this.onPrimaryColor,
    required this.primaryColor,
    required this.dateSelectedButtonStyle,
    required this.child,
    required this.dateSelectedTextStyle,
    required this.dateTextStyle,
    Key? key,
  }) : super(key: key);

  @override
  State<DayPageView> createState() => _DayPageViewState();
}

class _DayPageViewState extends State<DayPageView> {
  /// check the month length
  /// check the first day of the month's weekday
  /// first day in our calculation is Monday = 1
  /// add the weekday - 1 to the total month length
  /// then we can have a full weeks in our month view

  late int monthLength;

  int get weekdayNumber {
    final CalendarType calendarType = context
        .read<DatePickerBloc>()
        .state
        .calendarConfigurations
        .calendarType;

    final DateTime selectedDate =
        context.watch<DatePickerBloc>().state.selectedDate;

    if (calendarType == CalendarType.persian) {
      final jDate = selectedDate.toJalali();
      final date = Jalali(jDate.year, jDate.month);
      return date.toDateTime().weekday;
    }

    return DateTime(selectedDate.year, selectedDate.month).weekday;
  }

  void _calculateMonthLength(
    CalendarType calendarType,
    DateTime selectedDate,
    FirstDayOfWeek firstDay,
  ) {
    final int baseMonthLength = calendarType == CalendarType.gregorian
        ? selectedDate.toGregorian().monthLength
        : selectedDate.toJalali().monthLength;

    monthLength =
        baseMonthLength + weekdayNumber - firstDay.minesFromMonthLength;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          top: 51,
          child: BlocBuilder<DatePickerBloc, DatePickerState>(
            builder: (context, state) {
              final CalendarType calendarType =
                  state.calendarConfigurations.calendarType;
              final FirstDayOfWeek firstDayOfWeek =
                  state.calendarConfigurations.firstDayOfWeek;
              final int selectedDay = state.selectedDate.fetchDay(calendarType);

              _calculateMonthLength(
                calendarType,
                state.selectedDate,
                firstDayOfWeek,
              );

              return GridView.builder(
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
                itemCount: monthLength,
                itemBuilder: (context, index) {
                  final int currentDay =
                      index - weekdayNumber + firstDayOfWeek.addToCurrentDay;

                  if (currentDay < 1) {
                    return const SizedBox.shrink();
                  }

                  return TextButton(
                    style: widget.dateButtonStyle == null
                        ? TextButton.styleFrom(
                            backgroundColor: selectedDay == currentDay
                                ? widget.primaryColor ??
                                    Theme.of(context).primaryColor
                                : Colors.transparent,
                            padding: EdgeInsets.zero,
                          )
                        : selectedDay == currentDay
                            ? widget.dateSelectedButtonStyle ??
                                widget.dateButtonStyle
                            : widget.dateButtonStyle,
                    child: Text(
                      '$currentDay',
                      style: widget.dateTextStyle == null
                          ? TextStyle(
                              color: selectedDay == currentDay
                                  ? widget.onPrimaryColor ?? Colors.white
                                  : widget.primaryColor,
                            )
                          : selectedDay == currentDay
                              ? widget.dateSelectedTextStyle ??
                                  widget.dateTextStyle
                              : widget.dateTextStyle,
                    ).scaleDown,
                    onPressed: () => context
                        .read<DatePickerBloc>()
                        .add(SelectDay(currentDay)),
                  );
                },
              );
            },
          ),
        ),
        widget.child,
      ],
    );
  }
}
