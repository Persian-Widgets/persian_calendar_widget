import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:persian_calendar_widget/core/data/models/calendar_configurations.dart';
import 'package:persian_calendar_widget/core/utils/helpers/calculating_date_helper.dart';

part 'date_picker_event.dart';
part 'date_picker_state.dart';

class DatePickerBloc extends Bloc<DatePickerEvent, DatePickerState> {
  DatePickerBloc()
      : super(
          DatePickerState(
            calendarConfigurations: CalendarConfigurations(),
            selectedDate: DateTime.now(),
            yearsList: const [],
          ),
        ) {
    on<InitDatePicker>(_initDatePicker);
    on<SelectYear>(_selectYear);
    on<SelectMonth>(_selectMonth);
    on<SelectDay>(_selectDay);
    on<SelectToday>(_selectToday);
  }

  void _initDatePicker(InitDatePicker event, Emitter<DatePickerState> emit) {
    final yearsList =
        CalculatingDateHelper.getCalendarYears(event.calendarConfigurations);

    emit(
      state.copyWith(
        calendarConfigurations: event.calendarConfigurations,
        selectedDate: event.selectedDate,
        yearsList: yearsList,
      ),
    );
  }

  void _selectYear(SelectYear event, Emitter<DatePickerState> emit) {
    final DateTime selectedDate = state.selectedDate;
    final DateTime updatedDate =
        CalculatingDateHelper.adjustDateTimeBySingleComponent(
      original: selectedDate,
      selectedYear: event.year,
      calendarType: state.calendarConfigurations.calendarType,
    );

    emit(
      state.copyWith(
        selectedDate: updatedDate,
      ),
    );
  }

  void _selectMonth(SelectMonth event, Emitter<DatePickerState> emit) {
    final DateTime selectedDate = state.selectedDate;
    final DateTime updatedDate =
        CalculatingDateHelper.adjustDateTimeBySingleComponent(
      original: selectedDate,
      selectedMonth: event.month,
      calendarType: state.calendarConfigurations.calendarType,
    );

    emit(
      state.copyWith(
        selectedDate: updatedDate,
      ),
    );
  }

  void _selectDay(SelectDay event, Emitter<DatePickerState> emit) {
    final DateTime selectedDate = state.selectedDate;
    final DateTime updatedDate =
        CalculatingDateHelper.adjustDateTimeBySingleComponent(
      original: selectedDate,
      selectedDay: event.day,
      calendarType: state.calendarConfigurations.calendarType,
    );

    emit(
      state.copyWith(
        selectedDate: updatedDate,
      ),
    );
  }

  void _selectToday(SelectToday event, Emitter<DatePickerState> emit) {
    emit(
      state.copyWith(
        selectedDate: DateTime.now(),
      ),
    );
  }
}
