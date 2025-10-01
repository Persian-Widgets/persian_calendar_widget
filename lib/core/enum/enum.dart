enum PickDateFormat {
  dd, // just day
  mm, // just month
  ddMM, // day and month
  ddMMyyyy, // day, month and year
}

enum CalendarType {
  persian,
  gregorian,
}

enum FirstDayOfWeek {
  monday(2, 1),
  sunday(1, 0),
  saturday(0, -1);

  final int addToCurrentDay;
  final int minesFromMonthLength;
  const FirstDayOfWeek(this.addToCurrentDay, this.minesFromMonthLength);
}
