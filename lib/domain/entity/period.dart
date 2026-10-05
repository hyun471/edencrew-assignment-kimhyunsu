enum Period {
  oneMonth('1개월', 1),
  threeMonths('3개월', 3),
  sixMonths('6개월', 6),
  oneYear('1년', 12);

  const Period(this.label, this.months);
  final String label;
  final int months;

  DateTime startFrom(DateTime today) =>
      DateTime(today.year, today.month - months, today.day);
}
