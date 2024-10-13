// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:persian_calendar_widget/core/enum/enum.dart';
import 'package:persian_calendar_widget/core/extension/space_xy.dart';
import 'package:persian_calendar_widget/core/extension/to_persian_digit.dart';
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
  final Jalali today = DateTime.now().toJalali();

  late int maxYear;
  late int minYear;
  late List<int> yearsList;

  // late int selectedValue;
  late int currentPageViewIndex;

  late int selectedDay;
  late int selectedMonths;
  late int selectedYear;

  final Map<int, String> monthsMap = {
    1: 'فروردین',
    2: 'اردیبهشت',
    3: 'خرداد',
    4: 'تیر',
    5: 'مرداد',
    6: 'شهریور',
    7: 'مهر',
    8: 'آبان',
    9: 'آذر',
    10: 'دی',
    11: 'بهمن',
    12: 'اسفند',
  };

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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /// day button
                TextButton(
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
                  style: widget.titleButtonStyle == null
                      ? TextButton.styleFrom(
                          backgroundColor:
                              currentPageViewIndex == PageViewIndex.day
                                  ? widget.onPrimaryColor ??
                                      Theme.of(context).scaffoldBackgroundColor
                                  : Colors.transparent,
                        )
                      : currentPageViewIndex == PageViewIndex.day
                          ? widget.titleSelectedButtonStyle ??
                              widget.titleButtonStyle
                          : widget.titleButtonStyle,
                  child: Text(
                    widget.calendarType == CalendarType.persian
                        ? formattedDate.d.toPersianDigit()
                        : formattedDate.d,
                    style: widget.titleTextStyle == null
                        ? TextStyle(
                            color: currentPageViewIndex == PageViewIndex.day
                                ? widget.primaryColor ??
                                    Theme.of(context).primaryColor
                                : widget.onPrimaryColor ?? Colors.white,
                          )
                        : currentPageViewIndex == PageViewIndex.day
                            ? widget.titleSelectedTextStyle ??
                                widget.titleTextStyle
                            : widget.titleTextStyle,
                  ),
                ),

                /// month button
                TextButton(
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
                  style: widget.titleButtonStyle == null
                      ? TextButton.styleFrom(
                          backgroundColor:
                              currentPageViewIndex == PageViewIndex.month
                                  ? widget.onPrimaryColor ??
                                      Theme.of(context).scaffoldBackgroundColor
                                  : Colors.transparent,
                        )
                      : currentPageViewIndex == PageViewIndex.month
                          ? widget.titleSelectedButtonStyle ??
                              widget.titleButtonStyle
                          : widget.titleButtonStyle,
                  child: Text(
                    formattedDate.mN,
                    style: widget.titleTextStyle == null
                        ? TextStyle(
                            color: currentPageViewIndex == PageViewIndex.month
                                ? widget.primaryColor ??
                                    Theme.of(context).primaryColor
                                : widget.onPrimaryColor ?? Colors.white,
                          )
                        : currentPageViewIndex == PageViewIndex.month
                            ? widget.titleSelectedTextStyle ??
                                widget.titleTextStyle
                            : widget.titleTextStyle,
                  ),
                ),

                /// year button
                TextButton(
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
                  style: widget.titleButtonStyle == null
                      ? TextButton.styleFrom(
                          backgroundColor:
                              currentPageViewIndex == PageViewIndex.year
                                  ? widget.onPrimaryColor ??
                                      Theme.of(context).scaffoldBackgroundColor
                                  : Colors.transparent,
                        )
                      : currentPageViewIndex == PageViewIndex.year
                          ? widget.titleSelectedButtonStyle ??
                              widget.titleButtonStyle
                          : widget.titleButtonStyle,
                  child: Text(
                    widget.calendarType == CalendarType.persian
                        ? formattedDate.yyyy.toPersianDigit()
                        : formattedDate.yyyy,
                    style: widget.titleTextStyle == null
                        ? TextStyle(
                            color: currentPageViewIndex == PageViewIndex.year
                                ? widget.primaryColor ??
                                    Theme.of(context).primaryColor
                                : widget.onPrimaryColor ?? Colors.white,
                          )
                        : currentPageViewIndex == PageViewIndex.year
                            ? widget.titleSelectedTextStyle ??
                                widget.titleTextStyle
                            : widget.titleTextStyle,
                  ),
                ),
              ],
            ),
          ),
          if (widget.showTodayBanner || widget.useGoToTodayButton) 3.spaceY,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                if (widget.useGoToTodayButton) ...[
                  1.spaceX,
                  Expanded(
                    child: SizedBox(
                      height: 27,
                      child: ElevatedButton(
                        onPressed: () {
                          _updateSelectedDate(today);
                          setState(() {});
                        },
                        style: widget.goButtonStyle ??
                            ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              backgroundColor: widget.onPrimaryColor,
                              shape: RoundedRectangleBorder(
                                /// elevated button border radius fix by main
                                /// box border radius value
                                borderRadius: widget.showTodayBanner
                                    ? BorderRadius.only(
                                        topLeft: const Radius.circular(5),
                                        topRight: const Radius.circular(5),
                                        bottomLeft: const Radius.circular(5),
                                        bottomRight: Radius.circular(
                                          widget.borderRadius * 0.6,
                                        ),
                                      )
                                    : BorderRadius.vertical(
                                        bottom: Radius.circular(
                                          widget.borderRadius * .6,
                                        ),
                                        top: const Radius.circular(5),
                                      ),
                              ),
                            ),
                        child: Text(
                          widget.goTitle ??
                              (widget.showTodayBanner
                                  ? 'برو به'
                                  : 'برو به امروز'),
                          style: widget.goTextStyle ??
                              TextStyle(
                                color: widget.primaryColor,
                              ),
                        ),
                      ),
                    ),
                  ),
                  1.spaceX,
                ],
                if (widget.showTodayBanner && widget.useGoToTodayButton)
                  3.spaceX,
                if (widget.showTodayBanner)
                  Expanded(
                    flex: 2,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: widget.useGoToTodayButton
                            ? BorderRadius.only(
                                topLeft: const Radius.circular(5),
                                topRight: const Radius.circular(5),
                                bottomRight: const Radius.circular(5),
                                bottomLeft:
                                    Radius.circular(widget.borderRadius * 0.6),
                              )
                            : BorderRadius.vertical(
                                bottom:
                                    Radius.circular(widget.borderRadius * .6),
                                top: const Radius.circular(5),
                              ),
                        border: Border.all(
                          color: widget.primaryColor ??
                              Theme.of(context).primaryColor,
                          width: .5,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Text(
                          widget.calendarType == CalendarType.persian
                              ?
                              // ignore: lines_longer_than_80_chars
                              ' ${today.formatter.wN} ${today.day} ${today.formatter.mN} ${today.year}'
                                  .toPersianDigit()
                              // ignore: lines_longer_than_80_chars
                              : ' ${today.formatter.wN} ${today.day} ${today.formatter.mN} ${today.year}',
                          style: widget.todayDateBannerTextStyle ??
                              TextStyle(
                                color: widget.primaryColor ??
                                    Theme.of(context).primaryColor,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(
            width: 100,
            height: 280,
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                /// day screen
                GridView.builder(
                  padding: const EdgeInsets.only(
                    right: 12,
                    left: 12,
                    top: 10,
                    bottom: 5,
                  ),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 50,
                  ),
                  itemCount: selectedDate.monthLength,
                  itemBuilder: (context, index) {
                    final int currentDay = index + 1;

                    return TextButton(
                      style: widget.dateButtonStyle == null
                          ? TextButton.styleFrom(
                              backgroundColor: selectedDay == currentDay
                                  ? widget.primaryColor ??
                                      Theme.of(context).primaryColor
                                  : Colors.transparent,
                            )
                          : selectedDay == currentDay
                              ? widget.dateSelectedButtonStyle ??
                                  widget.dateButtonStyle
                              : widget.dateButtonStyle,
                      child: Text(
                        widget.calendarType == CalendarType.persian
                            ? '${index + 1}'.toPersianDigit()
                            : '${index + 1}',
                        style: widget.dateTextStyle == null
                            ? TextStyle(
                                color: selectedDay == currentDay
                                    ? widget.onPrimaryColor ?? Colors.white
                                    : widget.primaryColor,
                              )
                            : selectedDay == currentDay
                                ? widget.dateSelectedTextStyle ??
                                    widget.dateTextStyle
                                : widget.dateTextStyle,
                      ),
                      onPressed: () {
                        /// set new date with new index
                        _updateSelectedDate(selectedDate.withDay(currentDay));
                        setState(() {});
                      },
                    );
                  },
                ),

                /// month screen
                GridView.builder(
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
                  itemCount: monthsMap.length,
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
                              ? widget.dateSelectedButtonStyle ??
                                  widget.dateButtonStyle
                              : widget.dateButtonStyle,
                      child: Text(
                        '${monthsMap[currentMonth]}',
                        style: widget.dateTextStyle == null
                            ? TextStyle(
                                color: selectedMonths == currentMonth
                                    ? widget.onPrimaryColor ?? Colors.white
                                    : widget.primaryColor,
                              )
                            : selectedMonths == currentMonth
                                ? widget.dateSelectedTextStyle ??
                                    widget.dateTextStyle
                                : widget.dateTextStyle,
                      ),
                      onPressed: () {
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
                    );
                  },
                ),

                /// year screen
                GridView.builder(
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
                    final int currentYear = index;

                    return TextButton(
                      style: widget.dateButtonStyle == null
                          ? TextButton.styleFrom(
                              backgroundColor:
                                  selectedYear == currentYear + minYear
                                      ? widget.primaryColor ??
                                          Theme.of(context).primaryColor
                                      : Colors.transparent,
                              maximumSize: const Size.fromWidth(100),
                              minimumSize: const Size.fromWidth(100),
                              padding: EdgeInsets.zero,

                              // fixedSize: const Size(100, 0),
                            )
                          : selectedYear == currentYear + minYear
                              ? widget.dateSelectedButtonStyle ??
                                  widget.dateButtonStyle
                              : widget.dateButtonStyle,
                      child: Text(
                        widget.calendarType == CalendarType.persian
                            ? '${yearsList[index]}'.toPersianDigit()
                            : '${yearsList[index]}',
                        style: widget.dateTextStyle == null
                            ? TextStyle(
                                color: selectedYear == currentYear + minYear
                                    ? widget.onPrimaryColor ?? Colors.white
                                    : widget.primaryColor,
                              )
                            : selectedYear == currentYear + minYear
                                ? widget.dateSelectedTextStyle ??
                                    widget.dateTextStyle
                                : widget.dateTextStyle,
                      ),
                      onPressed: () {
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
                    );
                  },
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: widget.onSubmit != null
                        ? () {
                            widget.onSubmit!(
                              selectedDate,
                              selectedDateInText,
                            );
                            Navigator.pop(context);
                          }
                        : null,
                    style: widget.submitButtonStyle ??
                        ElevatedButton.styleFrom(
                          backgroundColor: widget.onPrimaryColor,
                          shape: RoundedRectangleBorder(
                            /// elevated button border radius fix by main box
                            /// border radius value
                            borderRadius: BorderRadius.circular(
                              widget.borderRadius * 0.6,
                            ),
                          ),
                        ),
                    child: Text(
                      widget.submitTitle ?? 'انتخاب',
                      style: widget.submitTextStyle ??
                          TextStyle(
                            color: widget.primaryColor,
                          ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: widget.cancelButtonStyle ??
                      ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          /// text button border radius fix by main box border
                          /// radius value
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius * 0.6,
                          ),
                        ),
                      ),
                  child: Text(
                    widget.cancelTitle ?? 'کنسل',
                    style: widget.cancelTextStyle ??
                        TextStyle(color: widget.primaryColor),
                  ),
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
        '$selectedDay ${monthsMap[selectedMonths]} $selectedYear';
  }
}

abstract class PageViewIndex {
  static const int day = 0;
  static const int month = 1;
  static const int year = 2;
}
