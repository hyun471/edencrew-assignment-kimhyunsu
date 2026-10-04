import 'package:dio/dio.dart';
import 'package:edencrew_assignment_starter/core/network/network.dart';
import 'package:edencrew_assignment_starter/data/dto/search_api_dto.dart';

class SearchApiDataSource {
  const SearchApiDataSource(this._dio);
  final Dio _dio;

  Future<SearchApiDto> searchStocks(String inputText) async {
    final url = ApiUrl.naverSearchUrl;
    final response = await _dio.get(
      url,
      queryParameters: {
        'q': inputText,
        'target': 'stock,ipo,index,marketindicator',
      },
    );

    return SearchApiDto.fromJson(response.data as Map<String, dynamic>);
  }
}
