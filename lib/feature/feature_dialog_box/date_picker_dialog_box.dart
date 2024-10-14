import 'package:flutter/material.dart';
import 'package:persian_calendar_widget/core/enum/enum.dart';
import 'package:persian_calendar_widget/core/extension/space_xy.dart';
import 'package:persian_calendar_widget/core/extension/to_persian_digit.dart';
import 'package:persian_calendar_widget/core/utils/constants/app_constants.dart';
import 'package:persian_calendar_widget/core/widgets/cancel_button.dart';
import 'package:persian_calendar_widget/core/widgets/choose_button.dart';
import 'package:persian_calendar_widget/core/widgets/day_page_view.dart';
import 'package:persian_calendar_widget/core/widgets/month_page_view.dart';
import 'package:persian_calendar_widget/core/widgets/today_context.dart';
import 'package:persian_calendar_widget/core/widgets/type_data_button.dart';
import 'package:persian_calendar_widget/core/widgets/week_days_list.dart';
import 'package:persian_calendar_widget/core/widgets/year_page_view.dart';
import 'package:shamsi_date/shamsi_date.dart';

typedef OnPickDate = void Function(Jalali jalaliDate, String dateInText);

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
  final TextStyle? todayTitleBannerTextStyle;
  final TextStyle? todayDateBannerTextStyle;

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
    required this.todayTitleBannerTextStyle,
    required this.weekDaysBoxStyle,
    required this.weekDaysPadding,
    required this.weekDaysTextStyle,
    super.key,
  });

  @override
  State<DatePickerDialogBox> createState() => _DatePickerDialogBoxState();
}

class _DatePickerDialogBoxState extends State<DatePickerDialogBox> {
  late PageController _pageController;
  late Jalali selectedDate;
  late String selectedDateInText;
  late JalaliFormatter formattedDate;

  late int maxYear;
  late int minYear;
  late List<int> yearsList;

  // late int selectedValue;
  late int currentPageViewIndex;

  late int selectedDay;
  late int selectedMonths;
  late int selectedYear;

  @override
  void initState() {
    super.initState();

    final Jalali initialDate =
        Jalali.fromDateTime(widget.initialDate ?? DateTime.now());

    _updateSelectedDate(initialDate);

    maxYear = widget.maxYear ?? initialDate.year + 11;
    minYear = widget.minYear ?? initialDate.year;
    yearsList =
        List.generate(maxYear - minYear + 1, (index) => minYear + index);

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
                  color: widget.primaryColor ?? Theme.of(context).primaryColor,

                  /// title border radius fix by main box border radius value
                  borderRadius:
                      widget.showTodayBanner || widget.useGoToTodayButton
                          ? BorderRadius.vertical(
                              top: Radius.circular(widget.borderRadius * .6),
                              bottom: const Radius.circular(5),
                            )
                          : BorderRadius.circular(widget.borderRadius * 0.6),
                ),

            /// title as date info
            child: Row(
              children: [
                12.0.spaceX,

                /// day button
                TypeDataButton(
                  onPressed: _daysButtonStatus()
                      ? () {
                          _pageController.animateToPage(
                            PageViewIndex.day,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInToLinear,
                          );
                          setState(() {
                            currentPageViewIndex = PageViewIndex.day;
                          });
                        }
                      : null,
                  buttonStyle: widget.titleButtonStyle,
                  selectedButtonStyle: widget.titleSelectedButtonStyle,
                  title: widget.calendarType == CalendarType.persian
                      ? formattedDate.d.toPersianDigit()
                      : formattedDate.d,
                  isSelected: currentPageViewIndex == PageViewIndex.day,
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
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInToLinear,
                          );
                          setState(() {
                            currentPageViewIndex = PageViewIndex.month;
                          });
                        }
                      : null,
                  buttonStyle: widget.titleButtonStyle,
                  selectedButtonStyle: widget.titleSelectedButtonStyle,
                  title: formattedDate.mN,
                  isSelected: currentPageViewIndex == PageViewIndex.month,
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
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInToLinear,
                          );
                          setState(() {
                            currentPageViewIndex = PageViewIndex.year;
                          });
                        }
                      : null,
                  buttonStyle: widget.titleButtonStyle,
                  selectedButtonStyle: widget.titleSelectedButtonStyle,
                  title: widget.calendarType == CalendarType.persian
                      ? formattedDate.yyyy.toPersianDigit()
                      : formattedDate.yyyy,
                  isSelected: currentPageViewIndex == PageViewIndex.year,
                  textStyle: widget.titleTextStyle,
                  selectedTextStyle: widget.titleSelectedTextStyle,
                  onPrimaryColor: widget.onPrimaryColor,
                  primaryColor: widget.primaryColor,
                ),
                12.0.spaceX,
              ],
            ),
          ),
          if (widget.showTodayBanner || widget.useGoToTodayButton) ...[
            3.spaceY,
            TodayContext(
              useGoToTodayButton: widget.useGoToTodayButton,
              showTodayBanner: widget.showTodayBanner,
              onPressed: (today) {
                _updateSelectedDate(today);
                setState(() {});
              },
              buttonStyle: widget.goButtonStyle,
              onPrimaryColor: widget.onPrimaryColor,
              primaryColor: widget.primaryColor,
              borderRadius: widget.borderRadius,
              isPersian: widget.calendarType == CalendarType.persian,
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
                  selectedDate: selectedDate,
                  selectedMonths: selectedMonths,
                  selectedYear: selectedYear,
                  selectedDay: selectedDay,
                  dateButtonStyle: widget.dateButtonStyle,
                  onPrimaryColor: widget.onPrimaryColor,
                  primaryColor: widget.primaryColor,
                  dateSelectedButtonStyle: widget.dateSelectedButtonStyle,
                  isPersian: widget.calendarType == CalendarType.persian,
                  dateSelectedTextStyle: widget.dateSelectedTextStyle,
                  dateTextStyle: widget.dateTextStyle,
                  onPressed: (currentDay) {
                    /// set new date with new index
                    _updateSelectedDate(
                      selectedDate.withDay(currentDay),
                    );
                    setState(() {});
                  },
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
                  selectedMonths: selectedMonths,
                  primaryColor: widget.primaryColor,
                  onPrimaryColor: widget.onPrimaryColor,
                  dateSelectedTextStyle: widget.dateSelectedTextStyle,
                  dateTextStyle: widget.dateTextStyle,
                  dateSelectedButtonStyle: widget.dateSelectedButtonStyle,
                  onPressed: (currentMonth) {
                    /// check the selected day if is 31 or 30 have to check
                    /// the month
                    /// if selected month is 12 have to check the leap year
                    /// then decide the last day of the month is 29 or 30
                    if ((selectedDay == 31 || selectedDay == 30) &&
                        currentMonth == 12) {
                      if (selectedDate.isLeapYear()) {
                        _updateSelectedDate(selectedDate.withDay(30));
                      } else {
                        _updateSelectedDate(selectedDate.withDay(29));
                      }
                    }

                    /// if selected month is 6 to 11 have to check the
                    /// selected day and change it
                    if (selectedDay == 31 && currentMonth > 6) {
                      _updateSelectedDate(selectedDate.withDay(30));
                    }

                    /// set new date with new index
                    _updateSelectedDate(
                      selectedDate.withMonth(currentMonth),
                    );
                    setState(() {});
                  },
                ),

                /// year screen
                YearPageView(
                  listLength: yearsList.length,
                  dateButtonStyle: widget.dateButtonStyle,
                  selectedYear: selectedYear,
                  minYear: minYear,
                  primaryColor: widget.primaryColor,
                  onPrimaryColor: widget.onPrimaryColor,
                  isPersian: widget.calendarType == CalendarType.persian,
                  yearsList: yearsList,
                  dateSelectedTextStyle: widget.dateSelectedTextStyle,
                  dateTextStyle: widget.dateTextStyle,
                  dateSelectedButtonStyle: widget.dateSelectedButtonStyle,
                  onPressed: (currentYear) {
                    /// check the selected day if is 31 or 30 have to check
                    /// the month
                    /// if selected month is 12 have to check the leap year
                    /// then decide the last day of the month is 29 or 30
                    if (selectedDay == 30 && selectedMonths == 12) {
                      final Jalali newDate = Jalali(currentYear + minYear);
                      if (newDate.isLeapYear()) {
                        _updateSelectedDate(selectedDate.withDay(30));
                      } else {
                        _updateSelectedDate(selectedDate.withDay(29));
                      }
                    }

                    /// set new date with new index
                    _updateSelectedDate(
                      selectedDate.withYear(currentYear + minYear),
                    );
                    setState(() {});
                  },
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
                            selectedDate,
                            selectedDateInText,
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

  void _updateSelectedDate(Jalali jalaliDate) {
    /// update selected date
    selectedDate = jalaliDate;

    /// update the format of the selected date
    formattedDate = selectedDate.formatter;

    /// update the day of the selected day
    selectedDay = selectedDate.day;
    selectedMonths = selectedDate.month;
    selectedYear = selectedDate.year;

    /// update selected date in text
    selectedDateInText =
        '$selectedDay ${AppConstants.monthsMap[selectedMonths]} $selectedYear';
  }
}

abstract class PageViewIndex {
  static const int day = 0;
  static const int month = 1;
  static const int year = 2;
}
