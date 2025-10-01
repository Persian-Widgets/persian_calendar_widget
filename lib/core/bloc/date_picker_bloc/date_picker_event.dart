part of 'date_picker_bloc.dart';

sealed class DatePickerEvent extends Equatable {
  const DatePickerEvent();

  @override
  List<Object> get props => [];
}

class InitDatePicker extends DatePickerEvent {
  final CalendarConfigurations calendarConfigurations;
  final DateTime selectedDate;

  const InitDatePicker({
    required this.calendarConfigurations,
    required this.selectedDate,
  });
}

class SelectYear extends DatePickerEvent {
  final int year;

  const SelectYear(this.year);
}

class SelectMonth extends DatePickerEvent {
  final int month;

  const SelectMonth(this.month);
}

class SelectDay extends DatePickerEvent {
  final int day;

  const SelectDay(this.day);
}

class SelectToday extends DatePickerEvent {
  const SelectToday();
}
