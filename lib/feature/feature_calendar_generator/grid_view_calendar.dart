import 'package:flutter/material.dart';
import 'package:persian_calendar_widget/core/data/enums/calendar_type.dart';
import 'package:persian_calendar_widget/core/data/enums/first_day_of_week.dart';
import 'package:persian_calendar_widget/core/data/i18n/i18n.dart';
import 'package:persian_calendar_widget/core/utils/helpers/init_calendar_helper.dart';
import 'package:shamsi_date/shamsi_date.dart';

typedef DayTileBuilder = Widget Function(Jalali jDate, Gregorian gDate);
typedef WeekDayTileBuilder = Widget Function(String weekDay);
typedef InitDate = ({int year, int month});

class GridViewCalendar extends StatefulWidget {
  final CalendarType? calendarType;
  final InitDate? initDate;
  final FirstDayOfWeek? firstDayOfWeek;
  final DayTileBuilder builder;
  final WeekDayTileBuilder? weekDayTileBuilder;
  final I18n? i18n;
  final EdgeInsets? padding;
  final double? mainAxisExtent;
  final double? crossAxisSpacing;
  final double? mainAxisSpacing;
  const GridViewCalendar({
    required this.builder,
    this.weekDayTileBuilder,
    this.mainAxisExtent,
    this.crossAxisSpacing,
    this.mainAxisSpacing,
    this.calendarType,
    this.initDate,
    this.firstDayOfWeek,
    this.i18n,
    this.padding,
    Key? key,
  }) : super(key: key);

  @override
  State<GridViewCalendar> createState() => _GridViewCalendarState();
}

class _GridViewCalendarState extends State<GridViewCalendar> {
  late Map<int, String> weekDays;
  late FirstDayOfWeek firstDayOfWeek;
  late CalendarType calendarType;
  late I18n i18n;
  late List<DateTime> monthDates;

  int get monthLength {
    late int baseMonthLength;
    final initDate = widget.initDate ?? _configInitDate(calendarType);

    if (calendarType.isGregorian) {
      baseMonthLength = Gregorian(initDate.year, initDate.month).monthLength;
      monthDates = List.generate(
        baseMonthLength,
        (index) {
          return Gregorian(initDate.year, initDate.month, index + 1)
              .toDateTime();
        },
      );
    }
    if (calendarType.isPersian) {
      baseMonthLength = Jalali(initDate.year, initDate.month).monthLength;
      monthDates = List.generate(
        baseMonthLength,
        (index) {
          return Jalali(initDate.year, initDate.month, index + 1).toDateTime();
        },
      );
    }

    return baseMonthLength +
        monthDates.first.weekday -
        firstDayOfWeek.minesFromMonthLength;
  }

  int get weekDayNumberStartAt {
    int startWeekDayNumber = monthDates.first.weekday;
    if (startWeekDayNumber == 6 && firstDayOfWeek.isSaturday) {
      startWeekDayNumber = -1;
    }
    if (startWeekDayNumber == 7 &&
        (firstDayOfWeek.isSaturday || firstDayOfWeek.isSunday)) {
      startWeekDayNumber = 0;
    }
    return startWeekDayNumber;
  }

  FirstDayOfWeek _configFirstDayOfWeek(CalendarType calendarType) {
    if (calendarType.isGregorian) return FirstDayOfWeek.monday;
    return firstDayOfWeek = FirstDayOfWeek.saturday;
  }

  ({int year, int month}) _configInitDate(CalendarType calendarType) {
    final DateTime now = DateTime.now();
    if (calendarType.isGregorian) return (year: now.year, month: now.month);

    final jDate = now.toJalali();
    return (year: jDate.year, month: jDate.month);
  }

  @override
  void initState() {
    super.initState();

    i18n = widget.i18n ?? const I18n();
    calendarType = widget.calendarType ?? CalendarType.persian;
    firstDayOfWeek =
        widget.firstDayOfWeek ?? _configFirstDayOfWeek(calendarType);
    weekDays = InitCalendarHelper.initCustomWeekCodes(firstDayOfWeek, i18n);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.weekDayTileBuilder != null)
            GridView.count(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 7,
              children: weekDays.values.map(
                (e) {
                  return Center(child: widget.weekDayTileBuilder!(e));
                },
              ).toList(),
            ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisExtent: widget.mainAxisExtent,
              crossAxisSpacing: widget.crossAxisSpacing ?? 0,
              mainAxisSpacing: widget.mainAxisSpacing ?? 0,
            ),
            padding: EdgeInsets.zero,
            itemCount: monthLength,
            itemBuilder: (context, index) {
              final int currentDay =
                  index - weekDayNumberStartAt + firstDayOfWeek.addToCurrentDay;

              if (currentDay < 1 || currentDay > monthDates.length) {
                return const SizedBox.shrink();
              }

              final DateTime currentDate = monthDates[currentDay - 1];

              return Center(
                child: widget.builder(
                  currentDate.toJalali(),
                  currentDate.toGregorian(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
