import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_calendar_widget/core/bloc/date_picker_bloc/date_picker_bloc.dart';
import 'package:persian_calendar_widget/core/data/enums/calendar_type.dart';
import 'package:persian_calendar_widget/core/extension/date_formatter.dart';
import 'package:persian_calendar_widget/core/extension/scale_down_box.dart';
import 'package:persian_calendar_widget/core/extension/space_xy.dart';

class TodayContext extends StatelessWidget {
  final bool useGoToTodayButton;
  final bool showTodayBanner;
  final ButtonStyle? buttonStyle;
  final Color? onPrimaryColor;
  final Color? primaryColor;
  final double borderRadius;
  final String? title;
  final TextStyle? goTextStyle;
  final TextStyle? todayDateBannerTextStyle;
  const TodayContext({
    required this.useGoToTodayButton,
    required this.showTodayBanner,
    required this.buttonStyle,
    required this.onPrimaryColor,
    required this.primaryColor,
    required this.borderRadius,
    required this.title,
    required this.goTextStyle,
    required this.todayDateBannerTextStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final CalendarType calendarType = context
        .read<DatePickerBloc>()
        .state
        .calendarConfigurations
        .calendarType;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          if (useGoToTodayButton) ...[
            1.spaceX,
            Flexible(
              fit: FlexFit.tight,
              child: SizedBox(
                height: 27,
                child: ElevatedButton(
                  onPressed: () =>
                      context.read<DatePickerBloc>().add(const SelectToday()),
                  style: buttonStyle ??
                      ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        backgroundColor: onPrimaryColor,
                        shape: RoundedRectangleBorder(
                          /// elevated button border radius fix by main
                          /// box border radius value
                          borderRadius: showTodayBanner
                              ? BorderRadius.only(
                                  topLeft: const Radius.circular(5),
                                  topRight: const Radius.circular(5),
                                  bottomLeft: const Radius.circular(5),
                                  bottomRight: Radius.circular(
                                    borderRadius * 0.6,
                                  ),
                                )
                              : BorderRadius.vertical(
                                  bottom: Radius.circular(
                                    borderRadius * .6,
                                  ),
                                  top: const Radius.circular(5),
                                ),
                        ),
                      ),
                  child: Text(
                    title ?? (showTodayBanner ? 'برو به' : 'برو به امروز'),
                    style: goTextStyle ??
                        TextStyle(
                          color: primaryColor,
                        ),
                  ).scaleDown,
                ),
              ),
            ),
            1.spaceX,
          ],
          if (showTodayBanner && useGoToTodayButton) 3.spaceX,
          if (showTodayBanner)
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: useGoToTodayButton
                      ? BorderRadius.only(
                          topLeft: const Radius.circular(5),
                          topRight: const Radius.circular(5),
                          bottomRight: const Radius.circular(5),
                          bottomLeft: Radius.circular(
                            borderRadius * 0.6,
                          ),
                        )
                      : BorderRadius.vertical(
                          bottom: Radius.circular(
                            borderRadius * .6,
                          ),
                          top: const Radius.circular(5),
                        ),
                  border: Border.all(
                    color: primaryColor ?? Theme.of(context).primaryColor,
                    width: .5,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Text(
                    calendarType == CalendarType.persian
                        ? DateTime.now().formatTo_wN_dd_MMMM_yyyy().jalali
                        : DateTime.now().formatTo_wN_dd_MMMM_yyyy().gregorian,
                    style: todayDateBannerTextStyle ??
                        TextStyle(
                          color: primaryColor ?? Theme.of(context).primaryColor,
                        ),
                    textAlign: TextAlign.center,
                  ).scaleDown,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
