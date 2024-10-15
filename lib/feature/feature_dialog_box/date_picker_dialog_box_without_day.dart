import 'package:flutter/material.dart';
import 'package:persian_calendar_widget/core/enum/enum.dart';
import 'package:persian_calendar_widget/core/extension/space_xy.dart';
import 'package:persian_calendar_widget/core/utils/constants/app_constants.dart';
import 'package:persian_calendar_widget/core/widgets/cancel_button.dart';
import 'package:persian_calendar_widget/core/widgets/choose_button.dart';
import 'package:persian_calendar_widget/core/widgets/month_page_view.dart';
import 'package:persian_calendar_widget/core/widgets/today_context.dart';
import 'package:persian_calendar_widget/core/widgets/type_data_button.dart';
import 'package:persian_calendar_widget/core/widgets/year_page_view.dart';
import 'package:persian_calendar_widget/persian_calendar_widget.dart';
import 'package:shamsi_date/shamsi_date.dart';

typedef OnPickDateWithoutDay = void Function(
  Jalali jalaliDate,
  String dateInText,
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
    super.key,
  });

  @override
  State<DatePickerDialogBoxWithoutDay> createState() =>
      _DatePickerDialogBoxWithoutDayState();
}

class _DatePickerDialogBoxWithoutDayState
    extends State<DatePickerDialogBoxWithoutDay> {
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

  // late int selectedDay;
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
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).width * .78,
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
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

  void _updateSelectedDate(Jalali jalaliDate) {
    /// update selected date
    selectedDate = jalaliDate;

    /// update the format of the selected date
    formattedDate = selectedDate.formatter;

    /// update the day of the selected day
    selectedMonths = selectedDate.month;
    selectedYear = selectedDate.year;

    /// update selected date in text
    selectedDateInText =
        '${AppConstants.monthsMap[selectedMonths]} $selectedYear';
  }
}

abstract class PageViewIndex {
  static const int month = 0;
  static const int year = 1;
}
