import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_calendar_widget/core/bloc/date_picker_bloc/date_picker_bloc.dart';
import 'package:persian_calendar_widget/core/data/models/calendar_configurations.dart';
import 'package:persian_calendar_widget/core/enum/enum.dart';
import 'package:persian_calendar_widget/core/extension/date_formatter.dart';
import 'package:persian_calendar_widget/core/extension/parse_calendar_to_all_types.dart';
import 'package:persian_calendar_widget/core/extension/space_xy.dart';
import 'package:persian_calendar_widget/core/widgets/cancel_button.dart';
import 'package:persian_calendar_widget/core/widgets/choose_button.dart';
import 'package:persian_calendar_widget/core/widgets/day_page_view.dart';
import 'package:persian_calendar_widget/core/widgets/month_page_view.dart';
import 'package:persian_calendar_widget/core/widgets/today_context.dart';
import 'package:persian_calendar_widget/core/widgets/type_data_button.dart';
import 'package:persian_calendar_widget/core/widgets/week_days_list.dart';
import 'package:persian_calendar_widget/core/widgets/year_page_view.dart';
import 'package:shamsi_date/shamsi_date.dart';

typedef OnPickDate = void Function(
  ({Jalali jalali, Gregorian gregorian}) selectedDate,
  ({String jalali, String gregorian}) formattedDate,
);

class DatePickerDialogBox extends StatefulWidget {
  final DateTime? initialDate;
  final int? maxYear;
  final int? minYear;
  final double borderRadius;
  final OnPickDate? onSubmit;
  final PickDateFormat pickDateFormat;
  final Color? primaryColor;
  final Color? onPrimaryColor;
  final Color? background;
  final BoxDecoration? titleBoxStyle;
  final ButtonStyle? titleButtonStyle;
  final ButtonStyle? titleSelectedButtonStyle;
  final TextStyle? titleTextStyle;
  final TextStyle? titleSelectedTextStyle;
  final BoxDecoration? weekDaysBoxStyle;
  final EdgeInsetsGeometry? weekDaysPadding;
  final TextStyle? weekDaysTextStyle;
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

  const DatePickerDialogBox({
    required this.initialDate,
    required this.onSubmit,
    required this.pickDateFormat,
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
    required this.weekDaysBoxStyle,
    required this.weekDaysPadding,
    required this.weekDaysTextStyle,
    required this.firstDayOfWeek,
    super.key,
  });

  @override
  State<DatePickerDialogBox> createState() => _DatePickerDialogBoxState();
}

class _DatePickerDialogBoxState extends State<DatePickerDialogBox> {
  late CalendarConfigurations calendarConfigurations;
  late PageController _pageController;
  late DateTime selectedDate;
  late int currentPageViewIndex;

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

    /// if we need to pick just month, must set default value of the page view
    /// screen `PageViewIndex.month` otherwise use `PageViewIndex.day`
    currentPageViewIndex = widget.pickDateFormat == PickDateFormat.mm
        ? PageViewIndex.month
        : PageViewIndex.day;
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
          ),
        ),
      child: Builder(
        builder: (context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: SimpleDialog(
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
                        color: widget.primaryColor ??
                            Theme.of(context).primaryColor,
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
                        children: [
                          12.0.spaceX,

                          /// day button
                          TypeDataButton(
                            onPressed: _daysButtonStatus()
                                ? () {
                                    _pageController.animateToPage(
                                      PageViewIndex.day,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      curve: Curves.easeInToLinear,
                                    );
                                    setState(() {
                                      currentPageViewIndex = PageViewIndex.day;
                                    });
                                  }
                                : null,
                            buttonStyle: widget.titleButtonStyle,
                            selectedButtonStyle:
                                widget.titleSelectedButtonStyle,
                            title: selectedDate.formatTo_dd(
                              widget.calendarType,
                            ),
                            isSelected:
                                currentPageViewIndex == PageViewIndex.day,
                            textStyle: widget.titleTextStyle,
                            selectedTextStyle: widget.titleSelectedTextStyle,
                            onPrimaryColor: widget.onPrimaryColor,
                            primaryColor: widget.primaryColor,
                          ),
                          5.0.spaceX,

                          /// month button
                          TypeDataButton(
                            onPressed: _monthsButtonStatus()
                                ? () {
                                    _pageController.animateToPage(
                                      PageViewIndex.month,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      curve: Curves.easeInToLinear,
                                    );
                                    setState(() {
                                      currentPageViewIndex =
                                          PageViewIndex.month;
                                    });
                                  }
                                : null,
                            buttonStyle: widget.titleButtonStyle,
                            selectedButtonStyle:
                                widget.titleSelectedButtonStyle,
                            title: selectedDate.fromatTo_MMMM(
                              widget.calendarType,
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
                            onPressed: _yearsButtonStatus()
                                ? () {
                                    _pageController.animateToPage(
                                      PageViewIndex.year,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      curve: Curves.easeInToLinear,
                                    );
                                    setState(() {
                                      currentPageViewIndex = PageViewIndex.year;
                                    });
                                  }
                                : null,
                            buttonStyle: widget.titleButtonStyle,
                            selectedButtonStyle:
                                widget.titleSelectedButtonStyle,
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
                  ),
                ],

                SizedBox(
                  width: 300,
                  height: 280,
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      /// day screen
                      DayPageView(
                        dateButtonStyle: widget.dateButtonStyle,
                        onPrimaryColor: widget.onPrimaryColor,
                        primaryColor: widget.primaryColor,
                        dateSelectedButtonStyle: widget.dateSelectedButtonStyle,
                        dateSelectedTextStyle: widget.dateSelectedTextStyle,
                        dateTextStyle: widget.dateTextStyle,
                        child: WeekDaysList(
                          primaryColor: widget.primaryColor,
                          boxDecoration: widget.weekDaysBoxStyle,
                          tilesPadding: widget.weekDaysPadding,
                          textStyle: widget.weekDaysTextStyle,
                        ),
                      ),

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
                                widget.onSubmit!(
                                  selectedDate.parseToAllCalendars,
                                  selectedDate.formatTo_dd_MMMM_yyyy(),
                                );
                                Navigator.pop(context);
                              }
                            : null,
                        buttonStyle: widget.submitButtonStyle,
                        borderRadius: widget.borderRadius,
                        title: widget.submitTitle,
                        textStyle: widget.submitTextStyle,
                        primaryColor: widget.primaryColor,
                        onPrimaryColor: widget.onPrimaryColor,
                      ),
                      8.0.spaceX,
                      CancelButton(
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
            ),
          );
        },
      ),
    );
  }

  bool _daysButtonStatus() {
    bool includeDays = true;

    if (widget.pickDateFormat == PickDateFormat.mm) includeDays = false;
    return includeDays;
  }

  bool _monthsButtonStatus() {
    bool includeMonths = true;

    if (widget.pickDateFormat == PickDateFormat.dd) includeMonths = false;
    return includeMonths;
  }

  bool _yearsButtonStatus() {
    bool includeYears = true;

    if (widget.pickDateFormat == PickDateFormat.dd) includeYears = false;
    if (widget.pickDateFormat == PickDateFormat.mm) includeYears = false;
    if (widget.pickDateFormat == PickDateFormat.ddMM) includeYears = false;
    return includeYears;
  }
}

abstract class PageViewIndex {
  static const int day = 0;
  static const int month = 1;
  static const int year = 2;
}
