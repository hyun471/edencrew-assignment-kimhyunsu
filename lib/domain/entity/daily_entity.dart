class DailyEntity {
  DailyEntity({
    required this.date,
    required this.openPrice,
    required this.highPrice,
    required this.lowPrice,
    required this.closePrice,
    required this.volume,
  });

  final DateTime date;
  final int openPrice;
  final int highPrice;
  final int lowPrice;
  final int closePrice;
  final int volume;
}
