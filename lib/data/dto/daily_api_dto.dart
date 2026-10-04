class DailyApiDto {
  const DailyApiDto({
    required this.localDate,
    required this.closePrice,
    required this.openPrice,
    required this.highPrice,
    required this.lowPrice,
    required this.accumulatedTradingVolume,
    required this.foreignRetentionRate,
  });
  final String localDate;
  final num closePrice;
  final num openPrice;
  final num highPrice;
  final num lowPrice;
  final num accumulatedTradingVolume;
  final num? foreignRetentionRate;

  factory DailyApiDto.fromJson(Map<String, dynamic> json) {
    return DailyApiDto(
      localDate: json["localDate"] as String,
      closePrice: json["closePrice"] as num,
      openPrice: json["openPrice"] as num,
      highPrice: json["highPrice"] as num,
      lowPrice: json["lowPrice"] as num,
      accumulatedTradingVolume: json["accumulatedTradingVolume"] as num,
      foreignRetentionRate: json["foreignRetentionRate"] as num?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "localDate": localDate,
      "closePrice": closePrice,
      "openPrice": openPrice,
      "highPrice": highPrice,
      "lowPrice": lowPrice,
      "accumulatedTradingVolume": accumulatedTradingVolume,
      "foreignRetentionRate": foreignRetentionRate,
    };
  }

  DailyApiDto copyWith({
    String? localDate,
    num? closePrice,
    num? openPrice,
    num? highPrice,
    num? lowPrice,
    num? accumulatedTradingVolume,
    num? foreignRetentionRate,
  }) {
    return DailyApiDto(
      localDate: localDate ?? this.localDate,
      closePrice: closePrice ?? this.closePrice,
      openPrice: openPrice ?? this.openPrice,
      highPrice: highPrice ?? this.highPrice,
      lowPrice: lowPrice ?? this.lowPrice,
      accumulatedTradingVolume:
          accumulatedTradingVolume ?? this.accumulatedTradingVolume,
      foreignRetentionRate: foreignRetentionRate ?? this.foreignRetentionRate,
    );
  }
}
