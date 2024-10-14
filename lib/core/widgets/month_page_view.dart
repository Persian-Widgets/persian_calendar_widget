import 'package:flutter/material.dart';
import 'package:persian_calendar_widget/core/utils/constants/app_constants.dart';

class MonthPageView extends StatelessWidget {
  final ButtonStyle? dateButtonStyle;
  final ButtonStyle? dateSelectedButtonStyle;
  final int selectedMonths;
  final Color? primaryColor;
  final Color? onPrimaryColor;
  final Function(int currentMonth) onPressed;
  final TextStyle? dateSelectedTextStyle;
  final TextStyle? dateTextStyle;
  const MonthPageView({
    required this.dateButtonStyle,
    required this.dateSelectedButtonStyle,
    required this.selectedMonths,
    required this.primaryColor,
    required this.onPrimaryColor,
    required this.onPressed,
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
      itemCount: AppConstants.monthsMap.length,
      itemBuilder: (context, index) {
        final int currentMonth = index + 1;

        return TextButton(
          style: dateButtonStyle == null
              ? TextButton.styleFrom(
                  backgroundColor: selectedMonths == currentMonth
                      ? primaryColor ?? Theme.of(context).primaryColor
                      : Colors.transparent,
                  maximumSize: const Size.fromWidth(100),
                  minimumSize: const Size.fromWidth(100),
                  padding: EdgeInsets.zero,

                  // fixedSize: const Size(100, 0),
                )
              : selectedMonths == currentMonth
                  ? dateSelectedButtonStyle ?? dateButtonStyle
                  : dateButtonStyle,
          child: Text(
            '${AppConstants.monthsMap[currentMonth]}',
            style: dateTextStyle == null
                ? TextStyle(
                    color: selectedMonths == currentMonth
                        ? onPrimaryColor ?? Colors.white
                        : primaryColor,
                  )
                : selectedMonths == currentMonth
                    ? dateSelectedTextStyle ?? dateTextStyle
                    : dateTextStyle,
          ),
          onPressed: () => onPressed(currentMonth),
        );
      },
    );
  }
}
