part of 'date_picker_bloc.dart';

class DatePickerState extends Equatable {
  final CalendarConfigurations calendarConfigurations;
  final DateTime selectedDate;
  final List<int> yearsList;
  const DatePickerState({
    required this.calendarConfigurations,
    required this.selectedDate,
    required this.yearsList,
  });

  @override
  List<Object> get props => [
        calendarConfigurations,
        selectedDate,
        yearsList,
      ];

  DatePickerState copyWith({
    CalendarConfigurations? calendarConfigurations,
    DateTime? selectedDate,
    List<int>? yearsList,
  }) {
    return DatePickerState(
      calendarConfigurations:
          calendarConfigurations ?? this.calendarConfigurations,
      selectedDate: selectedDate ?? this.selectedDate,
      yearsList: yearsList ?? this.yearsList,
    );
  }
}
