// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'date_picker_bloc.dart';

class DatePickerState extends Equatable {
  final CalendarConfigurations calendarConfigurations;
  final DateTime selectedDate;
  final List<int> yearsList;
  final Map<int, String> jalaliMonths;
  final Map<int, String> gregorianMonths;
  final Map<int, String> defaultWeekCodes;
  final Map<int, String> weekCodes;
  final Map<int, String> weekNames;
  const DatePickerState({
    required this.calendarConfigurations,
    required this.selectedDate,
    required this.yearsList,
    required this.jalaliMonths,
    required this.gregorianMonths,
    required this.defaultWeekCodes,
    required this.weekCodes,
    required this.weekNames,
  });

  @override
  List<Object> get props => [
        calendarConfigurations,
        selectedDate,
        yearsList,
        jalaliMonths,
        gregorianMonths,
        defaultWeekCodes,
        weekCodes,
        weekNames,
      ];

  DatePickerState copyWith({
    CalendarConfigurations? calendarConfigurations,
    DateTime? selectedDate,
    List<int>? yearsList,
    Map<int, String>? jalaliMonths,
    Map<int, String>? gregorianMonths,
    Map<int, String>? defaultWeekCodes,
    Map<int, String>? weekCodes,
    Map<int, String>? weekNames,
  }) {
    return DatePickerState(
      calendarConfigurations:
          calendarConfigurations ?? this.calendarConfigurations,
      selectedDate: selectedDate ?? this.selectedDate,
      yearsList: yearsList ?? this.yearsList,
      jalaliMonths: jalaliMonths ?? this.jalaliMonths,
      gregorianMonths: gregorianMonths ?? this.gregorianMonths,
      defaultWeekCodes: defaultWeekCodes ?? this.defaultWeekCodes,
      weekCodes: weekCodes ?? this.weekCodes,
      weekNames: weekNames ?? this.weekNames,
    );
  }
}
