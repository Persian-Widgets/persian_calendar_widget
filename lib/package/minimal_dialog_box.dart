import 'package:flutter/material.dart';
import 'package:persian_calendar_widget/package/enum.dart';
import 'package:persian_calendar_widget/package/minimal_persian_calendar.dart';
import 'package:shamsi_date/shamsi_date.dart';

class MinimalDialogBox extends StatefulWidget {
  // TODO(mahdiayr): custom decorated box for title
  // TODO(mahdiayr): custom style for all text
  // TODO(mahdiayr): custom style for bottom buttons
  // TODO(mahdiayr): custom style for selected date buttons
  final DateTime? initialDate;
  final int? maxYear;
  final int? minYear;
  final double borderRadius;
  final OnPickDate? onSubmit;
  final PickDateFormat pickDateFormat;

  const MinimalDialogBox({
    required this.initialDate,
    required this.onSubmit,
    required this.pickDateFormat,
    required this.borderRadius,
    required this.maxYear,
    required this.minYear,
    super.key,
  });

  @override
  State<MinimalDialogBox> createState() => _MinimalDialogBoxState();
}

class _MinimalDialogBoxState extends State<MinimalDialogBox> {
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
        children: [
          /// title box decoration
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,

              /// title border radius fix by main box border radius value
              borderRadius: BorderRadius.circular(widget.borderRadius * 0.6),
            ),

            /// title as date info
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /// day button
                TextButton(
                  onPressed: _daysButtonStatus()
                      ? () {
                          _pageController.animateToPage(PageViewIndex.day,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeInToLinear);
                          setState(() {
                            currentPageViewIndex = PageViewIndex.day;
                          });
                        }
                      : null,
                  style: TextButton.styleFrom(
                    backgroundColor: currentPageViewIndex == PageViewIndex.day
                        ? Theme.of(context).scaffoldBackgroundColor
                        : Colors.transparent,
                  ),
                  child: Text(
                    formattedDate.d,
                    style: TextStyle(
                      color: currentPageViewIndex == PageViewIndex.day
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                    ),
                  ),
                ),

                /// month button
                TextButton(
                  onPressed: _monthsButtonStatus()
                      ? () {
                          _pageController.animateToPage(PageViewIndex.month,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeInToLinear);
                          setState(() {
                            currentPageViewIndex = PageViewIndex.month;
                          });
                        }
                      : null,
                  style: TextButton.styleFrom(
                    backgroundColor: currentPageViewIndex == PageViewIndex.month
                        ? Theme.of(context).scaffoldBackgroundColor
                        : Colors.transparent,
                  ),
                  child: Text(
                    formattedDate.mN,
                    style: TextStyle(
                      color: currentPageViewIndex == PageViewIndex.month
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                    ),
                  ),
                ),

                /// year button
                TextButton(
                  onPressed: _yearsButtonStatus()
                      ? () {
                          _pageController.animateToPage(PageViewIndex.year,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeInToLinear);
                          setState(() {
                            currentPageViewIndex = PageViewIndex.year;
                          });
                        }
                      : null,
                  style: TextButton.styleFrom(
                    backgroundColor: currentPageViewIndex == PageViewIndex.year
                        ? Theme.of(context).scaffoldBackgroundColor
                        : Colors.transparent,
                  ),
                  child: Text(
                    formattedDate.yyyy,
                    style: TextStyle(
                      color: currentPageViewIndex == PageViewIndex.year
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).width * .78,
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                /// day screen
                GridView.builder(
                  padding: const EdgeInsets.only(
                      right: 12, left: 12, top: 10, bottom: 5),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 50),
                  itemCount: selectedDate.monthLength,
                  itemBuilder: (context, index) {
                    final int currentDay = index + 1;

                    return TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: selectedDay == currentDay
                            ? Theme.of(context).primaryColor
                            : Colors.transparent,
                      ),
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color:
                              selectedDay == currentDay ? Colors.white : null,
                        ),
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
                      right: 12, left: 12, top: 10, bottom: 5),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 100,
                    childAspectRatio: 1.7,
                  ),
                  itemCount: monthsMap.length,
                  itemBuilder: (context, index) {
                    final int currentMonth = index + 1;

                    return TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: selectedMonths == currentMonth
                            ? Theme.of(context).primaryColor
                            : Colors.transparent,
                        maximumSize: const Size.fromWidth(100),
                        minimumSize: const Size.fromWidth(100),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 0),

                        // fixedSize: const Size(100, 0),
                      ),
                      child: Text(
                        '${monthsMap[currentMonth]}',
                        style: TextStyle(
                          color: selectedMonths == currentMonth
                              ? Colors.white
                              : null,
                        ),
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

                        /// if selected month is 6 to 11 have to check the selected
                        /// day and change it
                        if (selectedDay == 31 && currentMonth > 6) {
                          _updateSelectedDate(selectedDate.withDay(30));
                        }

                        /// set new date with new index
                        _updateSelectedDate(
                            selectedDate.withMonth(currentMonth));
                        setState(() {});
                      },
                    );
                  },
                ),

                /// year screen
                GridView.builder(
                  padding: const EdgeInsets.only(
                      right: 12, left: 12, top: 10, bottom: 5),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 100,
                    childAspectRatio: 1.7,
                  ),
                  itemCount: yearsList.length,
                  itemBuilder: (context, index) {
                    final int currentYear = index;

                    return TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: selectedYear == currentYear + minYear
                            ? Theme.of(context).primaryColor
                            : Colors.transparent,
                        maximumSize: const Size.fromWidth(100),
                        minimumSize: const Size.fromWidth(100),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 0),

                        // fixedSize: const Size(100, 0),
                      ),
                      child: Text(
                        '${yearsList[index]}',
                        style: TextStyle(
                          color: selectedYear == currentYear + minYear
                              ? Colors.white
                              : null,
                        ),
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
                            selectedDate.withYear(currentYear + minYear));
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
                                    selectedDate, selectedDateInText);
                                Navigator.pop(context);
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            /// elevated button border radius fix by main box border radius value
                            borderRadius: BorderRadius.circular(
                                widget.borderRadius * 0.6),
                          ),
                        ),
                        child: const Text('انتخاب'))),
                const SizedBox(
                  width: 8,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        /// text button border radius fix by main box border radius value
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius * 0.6),
                      ),
                    ),
                    child: const Text('کنسل')),
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
