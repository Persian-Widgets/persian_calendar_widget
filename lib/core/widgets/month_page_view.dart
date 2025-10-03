import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_calendar_widget/core/bloc/date_picker_bloc/date_picker_bloc.dart';
import 'package:persian_calendar_widget/core/data/enums/calendar_type.dart';
import 'package:persian_calendar_widget/core/extension/date_details.dart';
import 'package:persian_calendar_widget/core/extension/scale_down_box.dart';

class MonthPageView extends StatefulWidget {
  final ButtonStyle? dateButtonStyle;
  final ButtonStyle? dateSelectedButtonStyle;
  final Color? primaryColor;
  final Color? onPrimaryColor;
  final TextStyle? dateSelectedTextStyle;
  final TextStyle? dateTextStyle;
  const MonthPageView({
    required this.dateButtonStyle,
    required this.dateSelectedButtonStyle,
    required this.primaryColor,
    required this.onPrimaryColor,
    required this.dateSelectedTextStyle,
    required this.dateTextStyle,
    Key? key,
  }) : super(key: key);

  @override
  State<MonthPageView> createState() => _MonthPageViewState();
}

class _MonthPageViewState extends State<MonthPageView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DatePickerBloc, DatePickerState>(
      builder: (context, state) {
        final CalendarType calendarType =
            state.calendarConfigurations.calendarType;
        final int selectedMonths = state.selectedDate.fetchMonth(calendarType);
        final jalaliMonths = state.jalaliMonths;
        final gregorianMonths = state.gregorianMonths;

        if (jalaliMonths.isEmpty && calendarType == CalendarType.persian) {
          return const CircularProgressIndicator();
        }

        if (gregorianMonths.isEmpty && calendarType == CalendarType.gregorian) {
          return const CircularProgressIndicator();
        }

        return GridView.builder(
          padding: const EdgeInsets.only(
            right: 12,
            left: 12,
            top: 10,
            bottom: 5,
          ),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 100,
            childAspectRatio: 1.7,
          ),
          itemCount: 12,
          itemBuilder: (context, index) {
            final int currentMonth = index + 1;

            return TextButton(
              style: widget.dateButtonStyle == null
                  ? TextButton.styleFrom(
                      backgroundColor: selectedMonths == currentMonth
                          ? widget.primaryColor ??
                              Theme.of(context).primaryColor
                          : Colors.transparent,
                      maximumSize: const Size.fromWidth(100),
                      minimumSize: const Size.fromWidth(100),
                      padding: EdgeInsets.zero,

                      // fixedSize: const Size(100, 0),
                    )
                  : selectedMonths == currentMonth
                      ? widget.dateSelectedButtonStyle ?? widget.dateButtonStyle
                      : widget.dateButtonStyle,
              child: Text(
                calendarType == CalendarType.persian
                    ? jalaliMonths[currentMonth]!
                    : gregorianMonths[currentMonth]!,
                style: widget.dateTextStyle == null
                    ? TextStyle(
                        color: selectedMonths == currentMonth
                            ? widget.onPrimaryColor ?? Colors.white
                            : widget.primaryColor,
                      )
                    : selectedMonths == currentMonth
                        ? widget.dateSelectedTextStyle ?? widget.dateTextStyle
                        : widget.dateTextStyle,
              ).scaleDown,
              onPressed: () =>
                  context.read<DatePickerBloc>().add(SelectMonth(currentMonth)),
            );
          },
        );
      },
    );
  }
}
