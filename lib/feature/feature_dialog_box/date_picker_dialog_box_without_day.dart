import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_calendar_widget/core/bloc/date_picker_bloc/date_picker_bloc.dart';
import 'package:persian_calendar_widget/core/data/enums/calendar_type.dart';
import 'package:persian_calendar_widget/core/data/enums/first_day_of_week.dart';
import 'package:persian_calendar_widget/core/data/i18n/i18n.dart';
import 'package:persian_calendar_widget/core/data/models/calendar_configurations.dart';
import 'package:persian_calendar_widget/core/extension/date_formatter.dart';
import 'package:persian_calendar_widget/core/extension/parse_calendar_to_all_types.dart';
import 'package:persian_calendar_widget/core/extension/space_xy.dart';
import 'package:persian_calendar_widget/core/widgets/cancel_button.dart';
import 'package:persian_calendar_widget/core/widgets/choose_button.dart';
import 'package:persian_calendar_widget/core/widgets/month_page_view.dart';
import 'package:persian_calendar_widget/core/widgets/today_context.dart';
import 'package:persian_calendar_widget/core/widgets/type_data_button.dart';
import 'package:persian_calendar_widget/core/widgets/year_page_view.dart';
import 'package:shamsi_date/shamsi_date.dart';

typedef OnPickDateWithoutDay = void Function(
  ({Jalali jalali, Gregorian gregorian}) selectedDate,
  ({String jalali, String gregorian}) formattedDate,
);

class DatePickerDialogBoxWithoutDay extends StatefulWidget {
  final DateTime? initialDate;
  final int? maxYear;
  final int? minYear;
  final double borderRadius;
  final OnPickDateWithoutDay? onSubmit;
  final Color? primaryColor;
  final Color? onPrimaryColor;
  final Color? background;
  final BoxDecoration? titleBoxStyle;
  final ButtonStyle? titleButtonStyle;
  final ButtonStyle? titleSelectedButtonStyle;
  final TextStyle? titleTextStyle;
  final TextStyle? titleSelectedTextStyle;
  final ButtonStyle? dateButtonStyle;
  final ButtonStyle? dateSelectedButtonStyle;
  final TextStyle? dateTextStyle;
  final TextStyle? dateSelectedTextStyle;
  final ButtonStyle? submitButtonStyle;
  final TextStyle? submitTextStyle;
  final ButtonStyle? cancelButtonStyle;
  final TextStyle? cancelTextStyle;
  final String? submitTitle;
  final String? cancelTitle;
  final CalendarType calendarType;
  final bool useGoToTodayButton;
  final String? goTitle;
  final ButtonStyle? goButtonStyle;
  final TextStyle? goTextStyle;
  final bool showTodayBanner;
  final TextStyle? todayDateBannerTextStyle;
  final FirstDayOfWeek? firstDayOfWeek;
  final I18n? i18n;
  final bool enablePersianDigits;

  const DatePickerDialogBoxWithoutDay({
    required this.initialDate,
    required this.onSubmit,
    required this.borderRadius,
    required this.maxYear,
    required this.minYear,
    required this.primaryColor,
    required this.onPrimaryColor,
    required this.background,
    required this.titleBoxStyle,
    required this.titleButtonStyle,
    required this.titleSelectedButtonStyle,
    required this.titleTextStyle,
    required this.titleSelectedTextStyle,
    required this.dateButtonStyle,
    required this.dateSelectedButtonStyle,
    required this.dateTextStyle,
    required this.dateSelectedTextStyle,
    required this.submitButtonStyle,
    required this.submitTextStyle,
    required this.cancelButtonStyle,
    required this.cancelTextStyle,
    required this.submitTitle,
    required this.cancelTitle,
    required this.calendarType,
    required this.useGoToTodayButton,
    required this.goButtonStyle,
    required this.goTextStyle,
    required this.goTitle,
    required this.showTodayBanner,
    required this.todayDateBannerTextStyle,
    required this.firstDayOfWeek,
    required this.i18n,
    required this.enablePersianDigits,
    super.key,
  });

  @override
  State<DatePickerDialogBoxWithoutDay> createState() =>
      _DatePickerDialogBoxWithoutDayState();
}

class _DatePickerDialogBoxWithoutDayState
    extends State<DatePickerDialogBoxWithoutDay> {
  late CalendarConfigurations calendarConfigurations;
  late PageController _pageController;
  late DateTime selectedDate;
  late int currentPageViewIndex;
  late I18n i18n;

  @override
  void initState() {
    super.initState();

    calendarConfigurations = CalendarConfigurations(
      calendarType: widget.calendarType,
      maxYear: widget.maxYear,
      minYear: widget.minYear,
      initDate: widget.initialDate,
      firstDayOfWeek: widget.firstDayOfWeek,
    );
    selectedDate = widget.initialDate ?? DateTime.now();
    i18n = widget.i18n ?? const I18n();

    currentPageViewIndex = PageViewIndex.month;
    _pageController = PageController(initialPage: currentPageViewIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DatePickerBloc()
        ..add(
          InitDatePicker(
            calendarConfigurations: calendarConfigurations,
            selectedDate: selectedDate,
            i18n: i18n,
          ),
        ),
      child: Builder(
        builder: (context) {
          return SimpleDialog(
            shape: RoundedRectangleBorder(
              /// border radius of the main box
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            backgroundColor: widget.background,
            children: [
              /// title box decoration
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                margin: const EdgeInsets.symmetric(horizontal: 12),
                decoration: widget.titleBoxStyle ??
                    BoxDecoration(
                      color:
                          widget.primaryColor ?? Theme.of(context).primaryColor,
                      borderRadius: widget.showTodayBanner ||
                              widget.useGoToTodayButton
                          ? BorderRadius.vertical(
                              top: Radius.circular(widget.borderRadius * .6),
                              bottom: const Radius.circular(5),
                            )
                          : BorderRadius.circular(widget.borderRadius * 0.6),
                    ),

                /// title as date info
                child: BlocBuilder<DatePickerBloc, DatePickerState>(
                  builder: (context, state) {
                    selectedDate = state.selectedDate;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        12.0.spaceX,

                        /// month button
                        TypeDataButton(
                          onPressed: () {
                            _pageController.animateToPage(
                              PageViewIndex.month,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeInToLinear,
                            );
                            setState(() {
                              currentPageViewIndex = PageViewIndex.month;
                            });
                          },
                          enablePersianDigits: widget.enablePersianDigits,
                          buttonStyle: widget.titleButtonStyle,
                          selectedButtonStyle: widget.titleSelectedButtonStyle,
                          title: selectedDate.fromatTo_MMMM(
                            widget.calendarType,
                            state.jalaliMonths,
                            state.gregorianMonths,
                          ),
                          isSelected:
                              currentPageViewIndex == PageViewIndex.month,
                          textStyle: widget.titleTextStyle,
                          selectedTextStyle: widget.titleSelectedTextStyle,
                          onPrimaryColor: widget.onPrimaryColor,
                          primaryColor: widget.primaryColor,
                        ),
                        5.0.spaceX,

                        /// year button
                        TypeDataButton(
                          onPressed: () {
                            _pageController.animateToPage(
                              PageViewIndex.year,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeInToLinear,
                            );
                            setState(() {
                              currentPageViewIndex = PageViewIndex.year;
                            });
                          },
                          enablePersianDigits: widget.enablePersianDigits,
                          buttonStyle: widget.titleButtonStyle,
                          selectedButtonStyle: widget.titleSelectedButtonStyle,
                          title: selectedDate.formatTo_yyyy(
                            widget.calendarType,
                          ),
                          isSelected:
                              currentPageViewIndex == PageViewIndex.year,
                          textStyle: widget.titleTextStyle,
                          selectedTextStyle: widget.titleSelectedTextStyle,
                          onPrimaryColor: widget.onPrimaryColor,
                          primaryColor: widget.primaryColor,
                        ),
                        12.0.spaceX,
                      ],
                    );
                  },
                ),
              ),
              if (widget.showTodayBanner || widget.useGoToTodayButton) ...[
                3.spaceY,
                TodayContext(
                  useGoToTodayButton: widget.useGoToTodayButton,
                  showTodayBanner: widget.showTodayBanner,
                  buttonStyle: widget.goButtonStyle,
                  onPrimaryColor: widget.onPrimaryColor,
                  primaryColor: widget.primaryColor,
                  borderRadius: widget.borderRadius,
                  title: widget.goTitle,
                  goTextStyle: widget.goTextStyle,
                  todayDateBannerTextStyle: widget.todayDateBannerTextStyle,
                  i18n: i18n,
                  enablePersianDigits: widget.enablePersianDigits,
                ),
              ],

              SizedBox(
                width: 300,
                height: 280,
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    /// month screen
                    MonthPageView(
                      dateButtonStyle: widget.dateButtonStyle,
                      primaryColor: widget.primaryColor,
                      onPrimaryColor: widget.onPrimaryColor,
                      dateSelectedTextStyle: widget.dateSelectedTextStyle,
                      dateTextStyle: widget.dateTextStyle,
                      dateSelectedButtonStyle: widget.dateSelectedButtonStyle,
                    ),

                    /// year screen
                    YearPageView(
                      dateButtonStyle: widget.dateButtonStyle,
                      primaryColor: widget.primaryColor,
                      onPrimaryColor: widget.onPrimaryColor,
                      dateSelectedTextStyle: widget.dateSelectedTextStyle,
                      dateTextStyle: widget.dateTextStyle,
                      dateSelectedButtonStyle: widget.dateSelectedButtonStyle,
                      enablePersianDigits: widget.enablePersianDigits,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    ChooseButton(
                      onPressed: widget.onSubmit != null
                          ? () {
                              final state =
                                  context.read<DatePickerBloc>().state;

                              widget.onSubmit!(
                                selectedDate.parseToAllCalendars,
                                selectedDate.formatTo_dd_MMMM_yyyy(
                                  state.jalaliMonths,
                                  state.gregorianMonths,
                                ),
                              );
                              Navigator.pop(context);
                            }
                          : null,
                      i18n: i18n,
                      buttonStyle: widget.submitButtonStyle,
                      borderRadius: widget.borderRadius,
                      title: widget.submitTitle,
                      textStyle: widget.submitTextStyle,
                      primaryColor: widget.primaryColor,
                      onPrimaryColor: widget.onPrimaryColor,
                    ),
                    8.0.spaceX,
                    CancelButton(
                      i18n: i18n,
                      buttonStyle: widget.cancelButtonStyle,
                      borderRadius: widget.borderRadius,
                      title: widget.cancelTitle,
                      textStyle: widget.cancelTextStyle,
                      primaryColor: widget.primaryColor,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

abstract class PageViewIndex {
  static const int month = 0;
  static const int year = 1;
}
