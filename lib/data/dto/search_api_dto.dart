class SearchApiDto {
  const SearchApiDto({required this.query, required this.items});
  final String query;
  final List<SearchApiItemDto> items;

  factory SearchApiDto.fromJson(Map<String, dynamic> json) {
    return SearchApiDto(
      query: json["query"] as String? ?? "",
      items: (json["items"] as List? ?? [])
          .map((e) => SearchApiItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {"query": query, "items": items.map((e) => e.toJson()).toList()};
  }

  SearchApiDto copyWith({String? query, List<SearchApiItemDto>? items}) {
    return SearchApiDto(query: query ?? this.query, items: items ?? this.items);
  }
}

class SearchApiItemDto {
  const SearchApiItemDto({
    required this.code,
    required this.name,
    required this.typeCode,
    required this.typeName,
    required this.url,
    required this.reutersCode,
    required this.nationCode,
    required this.nationName,
    required this.category,
    required this.hasDiscussion,
  });
  final String code;
  final String name;
  final String typeCode;
  final String typeName;
  final String url;
  final String reutersCode;
  final String nationCode;
  final String nationName;
  final String category;
  final bool hasDiscussion;

  factory SearchApiItemDto.fromJson(Map<String, dynamic> json) {
    return SearchApiItemDto(
      code: json["code"] as String? ?? "",
      name: json["name"] as String? ?? "",
      typeCode: json["typeCode"] as String? ?? "",
      typeName: json["typeName"] as String? ?? "",
      url: json["url"] as String? ?? "",
      reutersCode: json["reutersCode"] as String? ?? "",
      nationCode: json["nationCode"] as String? ?? "",
      nationName: json["nationName"] as String? ?? "",
      category: json["category"] as String? ?? "",
      hasDiscussion: json["hasDiscussion"] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "code": code,
      "name": name,
      "typeCode": typeCode,
      "typeName": typeName,
      "url": url,
      "reutersCode": reutersCode,
      "nationCode": nationCode,
      "nationName": nationName,
      "category": category,
      "hasDiscussion": hasDiscussion,
    };
  }

  SearchApiItemDto copyWith({
    String? code,
    String? name,
    String? typeCode,
    String? typeName,
    String? url,
    String? reutersCode,
    String? nationCode,
    String? nationName,
    String? category,
    bool? hasDiscussion,
  }) {
    return SearchApiItemDto(
      code: code ?? this.code,
      name: name ?? this.name,
      typeCode: typeCode ?? this.typeCode,
      typeName: typeName ?? this.typeName,
      url: url ?? this.url,
      reutersCode: reutersCode ?? this.reutersCode,
      nationCode: nationCode ?? this.nationCode,
      nationName: nationName ?? this.nationName,
      category: category ?? this.category,
      hasDiscussion: hasDiscussion ?? this.hasDiscussion,
    );
  }
}
