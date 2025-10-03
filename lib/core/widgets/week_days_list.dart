import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_calendar_widget/core/bloc/date_picker_bloc/date_picker_bloc.dart';
import 'package:persian_calendar_widget/core/extension/scale_down_box.dart';
import 'package:persian_calendar_widget/core/extension/to_persian_digit.dart';

class WeekDaysList extends StatelessWidget {
  final BoxDecoration? boxDecoration;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? tilesPadding;
  final EdgeInsetsGeometry? listPadding;
  final Color? primaryColor;
  final bool enablePersianDigits;
  const WeekDaysList({
    required this.enablePersianDigits,
    Key? key,
    this.boxDecoration,
    this.primaryColor,
    this.textStyle,
    this.tilesPadding,
    this.listPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DatePickerBloc, DatePickerState>(
      builder: (context, state) {
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
          children: state.weekCodes.values.map(
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
                            color:
                                primaryColor ?? Theme.of(context).primaryColor,
                          ),
                    ).withPersianDigits(enable: enablePersianDigits).scaleDown,
                  ),
                ),
              );
            },
          ).toList(),
        );
      },
    );
  }
}
