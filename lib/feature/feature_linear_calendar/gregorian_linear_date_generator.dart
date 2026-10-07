import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persian_calendar_widget/core/data/i18n/i18n.dart';
import 'package:persian_calendar_widget/core/data/typedef/selected_date.dart';
import 'package:persian_calendar_widget/core/extension/date_formatter.dart';
import 'package:persian_calendar_widget/core/extension/parse_calendar_to_all_types.dart';
import 'package:persian_calendar_widget/core/utils/helpers/init_calendar_helper.dart';
import 'package:shamsi_date/shamsi_date.dart';

class GregorianLinearDateGenerator extends StatefulWidget {
  final DateTime? initialDate;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? minYear;
  final int? maxYear;
  final bool visibleTodayButton;
  final bool visibleTimePicker;
  final BoxConstraints? constraints;
  final SelectedDate onSelected;
  final TextStyle? textStyle;
  final double diameterRatio;
  final double magnification;
  final double offAxisFraction;
  final double squeeze;
  final I18n? i18n;

  const GregorianLinearDateGenerator({
    required this.onSelected,
    super.key,
    this.initialDate,
    this.startDate,
    this.endDate,
    this.minYear,
    this.maxYear,
    this.i18n,
    this.visibleTodayButton = false,
    this.visibleTimePicker = false,
    this.constraints,
    this.textStyle,
    this.diameterRatio = 1.0,
    this.magnification = 1.3,
    this.offAxisFraction = 0.0,
    this.squeeze = 1.3,
  });

  @override
  State<GregorianLinearDateGenerator> createState() =>
      _GregorianLinearDateGeneratorState();
}

class _GregorianLinearDateGeneratorState
    extends State<GregorianLinearDateGenerator> {
  late I18n i18n;
  late int _selectedYear;
  late int _selectedMonth;
  late int _selectedDay;
  late int _selectedHour;
  late int _selectedMinute;
  late Map<int, String> jalaliMonths;
  late Map<int, String> gregorianMonths;

  late List<int> _years;
  List<int> _months = const [];
  List<int> _days = const [];
  final List<int> _hours = List.generate(24, (i) => i);
  final List<int> _minutes = List.generate(60, (i) => i);

  Gregorian? _startLimit;
  Gregorian? _endLimit;

  FixedExtentScrollController? _yearController;
  FixedExtentScrollController? _monthController;
  FixedExtentScrollController? _dayController;
  FixedExtentScrollController? _hourController;
  FixedExtentScrollController? _minuteController;

  static const Duration _animationDuration = Duration(milliseconds: 300);
  static const Curve _animationCurve = Curves.ease;

  @override
  void initState() {
    super.initState();
    i18n = widget.i18n ?? const I18n();
    jalaliMonths = InitCalendarHelper.initJalaliMonths(i18n);
    gregorianMonths = InitCalendarHelper.initGregorianMonths(i18n);
    _configureLimits();
    _initializeSelectionAndControllers();
  }

  @override
  void didUpdateWidget(covariant GregorianLinearDateGenerator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.startDate != widget.startDate ||
        oldWidget.endDate != widget.endDate ||
        oldWidget.initialDate != widget.initialDate ||
        oldWidget.minYear != widget.minYear ||
        oldWidget.maxYear != widget.maxYear) {
      _configureLimits();
      _realignSelectionWithLimits();
    }
  }

  @override
  void dispose() {
    _yearController?.dispose();
    _monthController?.dispose();
    _dayController?.dispose();
    _hourController?.dispose();
    _minuteController?.dispose();
    super.dispose();
  }

  void _configureLimits() {
    var computedEnd = widget.endDate;

    // Core Invariant Rule Execution:
    // If initialDate or startDate is strictly after endDate, invalidate endDate
    if (computedEnd != null) {
      if (widget.startDate != null &&
          widget.startDate!.compareTo(computedEnd) > 0) {
        computedEnd = null;
      } else if (widget.initialDate != null &&
          widget.initialDate!.compareTo(computedEnd) > 0) {
        computedEnd = null;
      }
    }

    final minYearDate = widget.minYear == null
        ? null
        : Gregorian(widget.minYear!);

    final maxYearDate = widget.maxYear == null
        ? null
        : Gregorian(
            widget.maxYear!,
            12,
            Gregorian(widget.maxYear!, 12).monthLength,
          );

    _startLimit = widget.startDate?.toGregorian();
    if (minYearDate != null &&
        (_startLimit == null || _startLimit!.compareTo(minYearDate) < 0)) {
      _startLimit = minYearDate;
    }

    _endLimit = computedEnd?.toGregorian();
    if (maxYearDate != null &&
        (_endLimit == null || _endLimit!.compareTo(maxYearDate) > 0)) {
      _endLimit = maxYearDate;
    }

    if (_startLimit != null &&
        _endLimit != null &&
        _startLimit!.compareTo(_endLimit!) > 0) {
      _endLimit = null;
    }
  }

  void _initializeSelectionAndControllers() {
    final clampedInitial = _clampDate(
      widget.initialDate?.toGregorian() ?? Gregorian.now(),
    );

    _selectedYear = clampedInitial.year;
    _selectedMonth = clampedInitial.month;
    _selectedDay = clampedInitial.day;

    final baseTime = widget.initialDate ?? DateTime.now();
    _selectedHour = baseTime.hour;
    _selectedMinute = baseTime.minute;

    final minYear = _startLimit?.year ?? (_selectedYear - 50);
    final maxYear = _endLimit?.year ?? (_selectedYear + 50);

    _years = _buildYears(minYear, maxYear);

    _updateMonthsForSelectedYear(clampMonth: true);
    _updateDaysForSelectedMonth(clampDay: true);

    _yearController = FixedExtentScrollController(
      initialItem: _safeIndex(_years.indexOf(_selectedYear), _years.length),
    );
    _monthController = FixedExtentScrollController(
      initialItem: _safeIndex(_months.indexOf(_selectedMonth), _months.length),
    );
    _dayController = FixedExtentScrollController(
      initialItem: _safeIndex(_days.indexOf(_selectedDay), _days.length),
    );
    _hourController = FixedExtentScrollController(
      initialItem: _safeIndex(_hours.indexOf(_selectedHour), _hours.length),
    );
    _minuteController = FixedExtentScrollController(
      initialItem: _safeIndex(
        _minutes.indexOf(_selectedMinute),
        _minutes.length,
      ),
    );

    _selectedGregorian();
  }

  void _realignSelectionWithLimits() {
    final currentJalali = Gregorian(
      _selectedYear,
      _selectedMonth,
      _selectedDay,
    );
    final clamped = _clampDate(currentJalali);

    _selectedYear = clamped.year;
    _selectedMonth = clamped.month;
    _selectedDay = clamped.day;

    final minYear = _startLimit?.year ?? (_selectedYear - 50);
    final maxYear = _endLimit?.year ?? (_selectedYear + 50);
    _years = _buildYears(minYear, maxYear);

    _updateMonthsForSelectedYear(clampMonth: true);
    _updateDaysForSelectedMonth(clampDay: true);

    _jumpControllerToSelected(
      _yearController,
      _years.indexOf(_selectedYear),
      _years.length,
      false,
    );
    _jumpControllerToSelected(
      _monthController,
      _months.indexOf(_selectedMonth),
      _months.length,
      false,
    );
    _jumpControllerToSelected(
      _dayController,
      _days.indexOf(_selectedDay),
      _days.length,
      true,
    );
  }

  List<String> _getLocalizedMonthNames() {
    return [
      i18n.gregorianMonths.january,
      i18n.gregorianMonths.february,
      i18n.gregorianMonths.march,
      i18n.gregorianMonths.april,
      i18n.gregorianMonths.may,
      i18n.gregorianMonths.june,
      i18n.gregorianMonths.july,
      i18n.gregorianMonths.august,
      i18n.gregorianMonths.september,
      i18n.gregorianMonths.october,
      i18n.gregorianMonths.november,
      i18n.gregorianMonths.december,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final defaultConstraints = BoxConstraints.loose(
      Size(mediaQuery.size.width, mediaQuery.size.height * 0.17),
    );

    final columnCount = widget.visibleTimePicker ? 5 : 3;
    final pickerWidthFactor = 0.86 / columnCount;
    final monthNames = _getLocalizedMonthNames();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ConstrainedBox(
          constraints: widget.constraints ?? defaultConstraints,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildDayPicker(context, pickerWidthFactor),
              _buildMonthPicker(context, pickerWidthFactor, monthNames),
              _buildYearPicker(context, pickerWidthFactor),
              if (widget.visibleTimePicker) ...[
                _buildVerticalDivider(context),
                _buildMinutePicker(context, pickerWidthFactor * 0.92),
                _buildTimeSeparator(context),
                _buildHourPicker(context, pickerWidthFactor * 0.92),
              ],
            ],
          ),
        ),
        if (widget.visibleTodayButton && _isTodayAvailable)
          _buildTodayButton(context),
      ],
    );
  }

  Widget _buildTimeSeparator(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleMedium
        ?.merge(widget.textStyle)
        .copyWith(
          fontSize: (widget.textStyle?.fontSize ?? 16.5) * widget.magnification,
          fontWeight: FontWeight.bold,
        );

    return SizedBox(
      width: 12,
      child: Center(
        child: Text(':', style: textStyle, textAlign: TextAlign.center),
      ),
    );
  }

  Widget _buildYearPicker(BuildContext context, double widthFactor) {
    return _cupertinoPicker<int>(
      context: context,
      items: _years,
      controller: _yearController!,
      widthFactor: widthFactor,
      labelBuilder: (value) => value.toString(),
      onSelectedItemChanged: (index) {
        final newYear = _years[index];
        if (newYear == _selectedYear) return;
        setState(() {
          _selectedYear = newYear;
          _updateMonthsForSelectedYear(clampMonth: true);
          _updateDaysForSelectedMonth(clampDay: true);
        });
        _jumpControllerToSelected(
          _monthController,
          _months.indexOf(_selectedMonth),
          _months.length,
          false,
        );
        _jumpControllerToSelected(
          _dayController,
          _days.indexOf(_selectedDay),
          _days.length,
          true,
        );
      },
      semanticsBuilder: (value) => 'Year $value',
    );
  }

  Widget _buildMonthPicker(
    BuildContext context,
    double widthFactor,
    List<String> monthNames,
  ) {
    return _cupertinoPicker<int>(
      context: context,
      items: _months,
      controller: _monthController!,
      widthFactor: widthFactor,
      labelBuilder: (month) => monthNames[month - 1],
      onSelectedItemChanged: (index) {
        final newMonth = _months[index];
        if (newMonth == _selectedMonth) return;
        setState(() {
          _selectedMonth = newMonth;
          _updateDaysForSelectedMonth(clampDay: true);
        });
        _jumpControllerToSelected(
          _dayController,
          _days.indexOf(_selectedDay),
          _days.length,
          true,
        );
      },
      semanticsBuilder: (month) => 'Month ${monthNames[month - 1]}',
    );
  }

  Widget _buildDayPicker(BuildContext context, double widthFactor) {
    return _cupertinoPicker<int>(
      context: context,
      items: _days,
      controller: _dayController!,
      widthFactor: widthFactor,
      labelBuilder: (value) => value.toString(),
      onSelectedItemChanged: (index) {
        final newDay = _days[index];
        if (newDay == _selectedDay) return;
        setState(() => _selectedDay = newDay);
        _selectedGregorian();
      },
      semanticsBuilder: (value) => 'Day $value',
    );
  }

  Widget _buildHourPicker(BuildContext context, double widthFactor) {
    return _cupertinoPicker<int>(
      context: context,
      items: _hours,
      controller: _hourController!,
      widthFactor: widthFactor,
      labelBuilder: (value) => value.toString().padLeft(2, '0'),
      onSelectedItemChanged: (index) {
        final newHour = _hours[index];
        if (newHour == _selectedHour) return;
        setState(() => _selectedHour = newHour);
        _selectedGregorian();
      },
      semanticsBuilder: (value) => 'Hour $value',
    );
  }

  Widget _buildMinutePicker(BuildContext context, double widthFactor) {
    return _cupertinoPicker<int>(
      context: context,
      items: _minutes,
      controller: _minuteController!,
      widthFactor: widthFactor,
      labelBuilder: (value) => value.toString().padLeft(2, '0'),
      onSelectedItemChanged: (index) {
        final newMinute = _minutes[index];
        if (newMinute == _selectedMinute) return;
        setState(() => _selectedMinute = newMinute);
        _selectedGregorian();
      },
      semanticsBuilder: (value) => 'Minute $value',
    );
  }

  Widget _buildVerticalDivider(BuildContext context) {
    final theme = Theme.of(context);
    final color =
        widget.textStyle?.color?.withValues(alpha: 0.2) ??
        theme.dividerColor.withValues(alpha: 0.2);
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      color: color,
    );
  }

  Widget _buildTodayButton(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    final textStyle = (widget.textStyle ?? theme.textTheme.titleMedium)
        ?.copyWith(fontSize: 14, fontWeight: FontWeight.w600);

    return Column(
      crossAxisAlignment: .start,
      mainAxisSize: .min,
      children: [
        SizedBox(height: mediaQuery.size.height * 0.01),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: mediaQuery.size.width * 0.1,
          ),
          child: Row(
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(mediaQuery.size.width * 0.02),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _onTodayPressed,
                child: Text(i18n.buttons.today, style: textStyle),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _cupertinoPicker<T>({
    required BuildContext context,
    required List<T> items,
    required FixedExtentScrollController controller,
    required double widthFactor,
    required String Function(T value) labelBuilder,
    required ValueChanged<int> onSelectedItemChanged,
    String Function(T value)? semanticsBuilder,
  }) {
    assert(items.isNotEmpty, 'Picker item list cannot be empty.');

    final theme = Theme.of(context);
    final textStyle = theme.textTheme.titleMedium
        ?.merge(widget.textStyle)
        .copyWith(fontSize: widget.textStyle?.fontSize ?? 16.5);

    final mediaQuery = MediaQuery.of(context);
    final borderColor =
        widget.textStyle?.color?.withValues(alpha: 0.35) ??
        theme.dividerColor.withValues(alpha: 0.35);

    return ConstrainedBox(
      constraints: BoxConstraints.loose(
        Size(mediaQuery.size.width * widthFactor, double.infinity),
      ),
      child: Semantics(
        container: true,
        child: CupertinoPicker(
          scrollController: controller,
          itemExtent: mediaQuery.size.width * 0.085,
          diameterRatio: widget.diameterRatio,
          magnification: widget.magnification,
          offAxisFraction: widget.offAxisFraction,
          squeeze: widget.squeeze,
          selectionOverlay: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: borderColor, width: 0.5),
                bottom: BorderSide(color: borderColor, width: 0.5),
              ),
            ),
          ),
          onSelectedItemChanged: onSelectedItemChanged,
          children: items.map((item) {
            final label = labelBuilder(item);
            return Center(
              child: Semantics(
                label: semanticsBuilder?.call(item) ?? label,
                child: Text(label, style: textStyle),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  List<int> _buildYears(int minYear, int maxYear) {
    if (maxYear < minYear) return [minYear];
    return List<int>.generate(maxYear - minYear + 1, (i) => minYear + i);
  }

  void _updateMonthsForSelectedYear({bool clampMonth = false}) {
    var startMonth = 1;
    var endMonth = 12;

    if (_startLimit != null && _selectedYear == _startLimit!.year) {
      startMonth = _startLimit!.month;
    }
    if (_endLimit != null && _selectedYear == _endLimit!.year) {
      endMonth = _endLimit!.month;
    }

    if (endMonth < startMonth) endMonth = startMonth;

    _months = List<int>.generate(
      endMonth - startMonth + 1,
      (index) => startMonth + index,
    );

    if (clampMonth && !_months.contains(_selectedMonth)) {
      _selectedMonth = _selectedMonth < _months.first
          ? _months.first
          : _months.last;
    }
  }

  void _updateDaysForSelectedMonth({bool clampDay = false}) {
    var startDay = 1;
    var endDay = Gregorian(_selectedYear, _selectedMonth).monthLength;

    if (_startLimit != null &&
        _selectedYear == _startLimit!.year &&
        _selectedMonth == _startLimit!.month) {
      startDay = _startLimit!.day;
    }
    if (_endLimit != null &&
        _selectedYear == _endLimit!.year &&
        _selectedMonth == _endLimit!.month) {
      endDay = _endLimit!.day;
    }

    if (endDay < startDay) endDay = startDay;

    _days = List<int>.generate(
      endDay - startDay + 1,
      (index) => startDay + index,
    );

    if (clampDay && !_days.contains(_selectedDay)) {
      _selectedDay = _selectedDay < _days.first ? _days.first : _days.last;
    }
  }

  void _selectedGregorian() {
    final date = Gregorian(
      _selectedYear,
      _selectedMonth,
      _selectedDay,
      widget.visibleTimePicker ? _selectedHour : 0,
      widget.visibleTimePicker ? _selectedMinute : 0,
    ).toDateTime();

    widget.onSelected(
      date.parseToAllCalendars,
      date.formatTo_dd_MMMM_yyyy(jalaliMonths, gregorianMonths),
    );
  }

  Gregorian _clampDate(Gregorian date) {
    if (_startLimit != null && date.compareTo(_startLimit!) < 0) {
      return _startLimit!;
    }
    if (_endLimit != null && date.compareTo(_endLimit!) > 0) {
      return _endLimit!;
    }
    return date;
  }

  bool get _isTodayAvailable {
    final today = Gregorian.now();
    if (_startLimit != null && today.compareTo(_startLimit!) < 0) return false;
    if (_endLimit != null && today.compareTo(_endLimit!) > 0) return false;
    return true;
  }

  int _safeIndex(int index, int length) {
    if (length <= 0) return 0;
    if (index < 0) return 0;
    if (index >= length) return length - 1;
    return index;
  }

  void _jumpControllerToSelected(
    FixedExtentScrollController? controller,
    int index,
    int length,
    bool needToSendDate,
  ) {
    if (controller != null && controller.hasClients) {
      controller.jumpToItem(_safeIndex(index, length));
    }
    if (needToSendDate) _selectedGregorian();
  }

  void _animateControllerToSelected(
    FixedExtentScrollController? controller,
    int index,
    int length,
  ) {
    if (controller != null && controller.hasClients) {
      controller.animateToItem(
        _safeIndex(index, length),
        duration: _animationDuration,
        curve: _animationCurve,
      );
    }
  }

  void _onTodayPressed() {
    if (!_isTodayAvailable) return;

    final todayJalali = Jalali.now();
    final todayDateTime = DateTime.now();

    setState(() {
      _selectedYear = todayJalali.year;
      _selectedMonth = todayJalali.month;
      _selectedDay = todayJalali.day;
      _selectedHour = todayDateTime.hour;
      _selectedMinute = todayDateTime.minute;

      _updateMonthsForSelectedYear(clampMonth: true);
      _updateDaysForSelectedMonth(clampDay: true);
    });

    _animateControllerToSelected(
      _yearController,
      _years.indexOf(_selectedYear),
      _years.length,
    );
    _animateControllerToSelected(
      _monthController,
      _months.indexOf(_selectedMonth),
      _months.length,
    );
    _animateControllerToSelected(
      _dayController,
      _days.indexOf(_selectedDay),
      _days.length,
    );

    if (widget.visibleTimePicker) {
      _animateControllerToSelected(
        _hourController,
        _hours.indexOf(_selectedHour),
        _hours.length,
      );
      _animateControllerToSelected(
        _minuteController,
        _minutes.indexOf(_selectedMinute),
        _minutes.length,
      );
    }
  }
}
