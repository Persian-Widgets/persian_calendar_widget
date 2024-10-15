import 'package:flutter/material.dart';
import 'package:persian_calendar_widget/core/extension/to_persian_digit.dart';

class YearPageView extends StatelessWidget {
  final int listLength;
  final ButtonStyle? dateButtonStyle;
  final ButtonStyle? dateSelectedButtonStyle;
  final int selectedYear;
  final int minYear;
  final Color? primaryColor;
  final Color? onPrimaryColor;
  final bool isPersian;
  final Function(int currentYear) onPressed;
  final List<int> yearsList;
  final TextStyle? dateSelectedTextStyle;
  final TextStyle? dateTextStyle;
  const YearPageView({
    required this.listLength,
    required this.dateButtonStyle,
    required this.dateSelectedButtonStyle,
    required this.selectedYear,
    required this.minYear,
    required this.primaryColor,
    required this.onPrimaryColor,
    required this.isPersian,
    required this.onPressed,
    required this.yearsList,
    required this.dateSelectedTextStyle,
    required this.dateTextStyle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      itemCount: listLength,
      itemBuilder: (context, index) {
        final int currentYear = index;

        return TextButton(
          style: dateButtonStyle == null
              ? TextButton.styleFrom(
                  backgroundColor: selectedYear == currentYear + minYear
                      ? primaryColor ?? Theme.of(context).primaryColor
                      : Colors.transparent,
                  maximumSize: const Size.fromWidth(100),
                  minimumSize: const Size.fromWidth(100),
                  padding: EdgeInsets.zero,

                  // fixedSize: const Size(100, 0),
                )
              : selectedYear == currentYear + minYear
                  ? dateSelectedButtonStyle ?? dateButtonStyle
                  : dateButtonStyle,
          child: Text(
            isPersian
                ? '${yearsList[index]}'.toPersianDigit()
                : '${yearsList[index]}',
            style: dateTextStyle == null
                ? TextStyle(
                    color: selectedYear == currentYear + minYear
                        ? onPrimaryColor ?? Colors.white
                        : primaryColor,
                  )
                : selectedYear == currentYear + minYear
                    ? dateSelectedTextStyle ?? dateTextStyle
                    : dateTextStyle,
          ),
          onPressed: () => onPressed(currentYear),
        );
      },
    );
  }
}
