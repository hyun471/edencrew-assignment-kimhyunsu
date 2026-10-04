class DetailApiDto {
  const DetailApiDto({
    required this.chartNationType,
    required this.chartInfoType,
    required this.itemCode,
    required this.symbolCode,
    required this.stockName,
    required this.stockExchangeName,
    required this.stockExchangeNameKor,
    required this.nationType,
    required this.stockType,
    required this.stockEndType,
    required this.endUrl,
    required this.isDelisting,
  });
  final String chartNationType;
  final String chartInfoType;
  final String itemCode;
  final String symbolCode;
  final String stockName;
  final String stockExchangeName;
  final String stockExchangeNameKor;
  final String nationType;
  final String stockType;
  final String stockEndType;
  final String endUrl;
  final bool isDelisting;

  factory DetailApiDto.fromJson(Map<String, dynamic> json) {
    return DetailApiDto(
      chartNationType: json["chartNationType"] as String? ?? "",
      chartInfoType: json["chartInfoType"] as String? ?? "",
      itemCode: json["itemCode"] as String? ?? "",
      symbolCode: json["symbolCode"] as String? ?? "",
      stockName: json["stockName"] as String? ?? "",
      stockExchangeName: json["stockExchangeName"] as String? ?? "",
      stockExchangeNameKor: json["stockExchangeNameKor"] as String? ?? "",
      nationType: json["nationType"] as String? ?? "",
      stockType: json["stockType"] as String? ?? "",
      stockEndType: json["stockEndType"] as String? ?? "",
      endUrl: json["endUrl"] as String? ?? "",
      isDelisting: json["isDelisting"] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "chartNationType": chartNationType,
      "chartInfoType": chartInfoType,
      "itemCode": itemCode,
      "symbolCode": symbolCode,
      "stockName": stockName,
      "stockExchangeName": stockExchangeName,
      "stockExchangeNameKor": stockExchangeNameKor,
      "nationType": nationType,
      "stockType": stockType,
      "stockEndType": stockEndType,
      "endUrl": endUrl,
      "isDelisting": isDelisting,
    };
  }

  DetailApiDto copyWith({
    String? chartNationType,
    String? chartInfoType,
    String? itemCode,
    String? symbolCode,
    String? stockName,
    String? stockExchangeName,
    String? stockExchangeNameKor,
    String? nationType,
    String? stockType,
    String? stockEndType,
    String? endUrl,
    bool? isDelisting,
  }) {
    return DetailApiDto(
      chartNationType: chartNationType ?? this.chartNationType,
      chartInfoType: chartInfoType ?? this.chartInfoType,
      itemCode: itemCode ?? this.itemCode,
      symbolCode: symbolCode ?? this.symbolCode,
      stockName: stockName ?? this.stockName,
      stockExchangeName: stockExchangeName ?? this.stockExchangeName,
      stockExchangeNameKor: stockExchangeNameKor ?? this.stockExchangeNameKor,
      nationType: nationType ?? this.nationType,
      stockType: stockType ?? this.stockType,
      stockEndType: stockEndType ?? this.stockEndType,
      endUrl: endUrl ?? this.endUrl,
      isDelisting: isDelisting ?? this.isDelisting,
    );
  }
}
