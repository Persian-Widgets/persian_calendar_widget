enum CalendarType {
  persian,
  gregorian;

  bool get isPersian => this == CalendarType.persian;
  bool get isGregorian => this == CalendarType.gregorian;
}
