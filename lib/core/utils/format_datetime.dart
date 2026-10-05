class FormatDatetime {
  static String formatDate(DateTime date) {
    String two(int n) => n.toString().padLeft(2, "0");
    return '${date.year}${two(date.month)}${two(date.day)}${two(date.hour)}${two(date.minute)}';
  }

  // 일별 시세 표의 날짜: 10.02
  static String monthDay(DateTime date) {
    String two(int n) => n.toString().padLeft(2, "0");
    return '${two(date.month)}.${two(date.day)}';
  }
}
