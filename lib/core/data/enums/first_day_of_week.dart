enum FirstDayOfWeek {
  monday(2, 1),
  sunday(1, 0),
  saturday(0, -1);

  bool get isSunday => this == FirstDayOfWeek.sunday;
  bool get isSaturday => this == FirstDayOfWeek.saturday;
  bool get isMonday => this == FirstDayOfWeek.monday;

  final int addToCurrentDay;
  final int minesFromMonthLength;
  const FirstDayOfWeek(this.addToCurrentDay, this.minesFromMonthLength);
}
