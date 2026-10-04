class RealtimeApiDto {
  const RealtimeApiDto({
    required this.cd,
    required this.nv,
    required this.pcv,
    required this.ov,
    required this.hv,
    required this.lv,
    required this.aq,
    required this.countOfListedStock,
  });
  final String cd;
  final int nv;
  final int pcv;
  final int ov;
  final int hv;
  final int lv;
  final int aq;
  final int countOfListedStock;

  factory RealtimeApiDto.fromJson(Map<String, dynamic> json) {
    return RealtimeApiDto(
      cd: json["cd"] as String? ?? "",
      nv: (json["nv"] as num).toInt(),
      pcv: (json["pcv"] as num).toInt(),
      ov: (json["ov"] as num).toInt(),
      hv: (json["hv"] as num).toInt(),
      lv: (json["lv"] as num).toInt(),
      aq: (json["aq"] as num).toInt(),
      countOfListedStock: (json["countOfListedStock"] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "cd": cd,
      "nv": nv,
      "pcv": pcv,
      "ov": ov,
      "hv": hv,
      "lv": lv,
      "aq": aq,
      "countOfListedStock": countOfListedStock,
    };
  }

  RealtimeApiDto copyWith({
    String? cd,
    int? nv,
    int? pcv,
    int? ov,
    int? hv,
    int? lv,
    int? aq,
    int? countOfListedStock,
  }) {
    return RealtimeApiDto(
      cd: cd ?? this.cd,
      nv: nv ?? this.nv,
      pcv: pcv ?? this.pcv,
      ov: ov ?? this.ov,
      hv: hv ?? this.hv,
      lv: lv ?? this.lv,
      aq: aq ?? this.aq,
      countOfListedStock: countOfListedStock ?? this.countOfListedStock,
    );
  }
}
