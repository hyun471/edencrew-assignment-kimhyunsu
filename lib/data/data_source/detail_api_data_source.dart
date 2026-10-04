import 'package:dio/dio.dart';
import 'package:edencrew_assignment_starter/core/network/network.dart';
import 'package:edencrew_assignment_starter/data/dto/detail_api_dto.dart';

class DetailApiDataSource {
  const DetailApiDataSource(this._dio);
  final Dio _dio;

  Future<DetailApiDto> stockDetail(String stockCode) async {
    final url = '${ApiUrl.naverDetailUrl}/$stockCode';
    final response = await _dio.get(url);

    return DetailApiDto.fromJson(response.data as Map<String, dynamic>);
  }
}
