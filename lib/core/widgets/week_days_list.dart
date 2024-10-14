import 'package:flutter/material.dart';
import 'package:persian_calendar_widget/core/utils/constants/app_constants.dart';

class WeekDaysList extends StatelessWidget {
  final BoxDecoration? boxDecoration;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? tilesPadding;
  final EdgeInsetsGeometry? listPadding;
  final Color? primaryColor;
  const WeekDaysList({
    Key? key,
    this.boxDecoration,
    this.primaryColor,
    this.textStyle,
    this.tilesPadding,
    this.listPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      padding: listPadding ??
          const EdgeInsets.only(
            right: 12,
            left: 12,
            top: 10,
            // bottom: 5,
          ),
      crossAxisCount: 7,
      physics: const NeverScrollableScrollPhysics(),
      children: AppConstants.weekMap.values.map(
        (e) {
          return Padding(
            padding: tilesPadding ?? const EdgeInsets.all(3),
            child: DecoratedBox(
              decoration: boxDecoration ??
                  BoxDecoration(
                    // color: Theme.of(context).colorScheme.primary,
                    border: Border.all(
                      color: primaryColor ?? Theme.of(context).primaryColor,
                    ),
                    shape: BoxShape.circle,
                  ),
              child: Center(
                child: Text(
                  e,
                  style: textStyle ??
                      TextStyle(
                        color: primaryColor ?? Theme.of(context).primaryColor,
                      ),
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
