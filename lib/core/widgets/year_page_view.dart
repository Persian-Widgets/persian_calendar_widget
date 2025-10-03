import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_calendar_widget/core/bloc/date_picker_bloc/date_picker_bloc.dart';
import 'package:persian_calendar_widget/core/enum/enum.dart';
import 'package:persian_calendar_widget/core/extension/date_details.dart';

class YearPageView extends StatelessWidget {
  final ButtonStyle? dateButtonStyle;
  final ButtonStyle? dateSelectedButtonStyle;
  final Color? primaryColor;
  final Color? onPrimaryColor;
  final TextStyle? dateSelectedTextStyle;
  final TextStyle? dateTextStyle;
  const YearPageView({
    required this.dateButtonStyle,
    required this.dateSelectedButtonStyle,
    required this.primaryColor,
    required this.onPrimaryColor,
    required this.dateSelectedTextStyle,
    required this.dateTextStyle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DatePickerBloc, DatePickerState>(
      builder: (context, state) {
        final CalendarType calendarType =
            state.calendarConfigurations.calendarType;
        final int selectedYear = state.selectedDate.fetchYear(calendarType);
        final List<int> yearsList = state.yearsList;

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
          itemCount: yearsList.length,
          itemBuilder: (context, index) {
            final int currentYear = yearsList[index];

            return TextButton(
              style: dateButtonStyle == null
                  ? TextButton.styleFrom(
                      backgroundColor: selectedYear == currentYear
                          ? primaryColor ?? Theme.of(context).primaryColor
                          : Colors.transparent,
                      maximumSize: const Size.fromWidth(100),
                      minimumSize: const Size.fromWidth(100),
                      padding: EdgeInsets.zero,

                      // fixedSize: const Size(100, 0),
                    )
                  : selectedYear == currentYear
                      ? dateSelectedButtonStyle ?? dateButtonStyle
                      : dateButtonStyle,
              child: Text(
                '$currentYear',
                style: dateTextStyle == null
                    ? TextStyle(
                        color: selectedYear == currentYear
                            ? onPrimaryColor ?? Colors.white
                            : primaryColor,
                      )
                    : selectedYear == currentYear
                        ? dateSelectedTextStyle ?? dateTextStyle
                        : dateTextStyle,
              ),
              onPressed: () =>
                  context.read<DatePickerBloc>().add(SelectYear(currentYear)),
            );
          },
        );
      },
    );
  }
}
