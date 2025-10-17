class CalendarHelper {
  static ({int month, int year}) previousMonth(
    ({int month, int year}) initDate,
  ) {
    int month = initDate.month;
    int year = initDate.year;

    month = month - 1;

    if (month < 1) {
      month = 12;
      year = year - 1;
    }

    return (month: month, year: year);
  }

  static ({int month, int year}) nextMonth(({int month, int year}) initDate) {
    int month = initDate.month;
    int year = initDate.year;

    month = month + 1;
    if (month > 12) {
      month = 1;
      year = year + 1;
    }

    return (month: month, year: year);
  }
}
