import 'package:shamsi_date/shamsi_date.dart';

typedef SelectedDate = void Function(
  ({Jalali jalali, Gregorian gregorian}) selectedDate,
  ({String jalali, String gregorian}) formattedDate,
);
