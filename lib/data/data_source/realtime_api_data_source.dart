import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:edencrew_assignment_starter/core/network/network.dart';
import 'package:edencrew_assignment_starter/data/dto/realtime_api_dto.dart';

class RealtimeApiDataSource {
  const RealtimeApiDataSource(this._dio);
  final Dio _dio;

  Future<List<RealtimeApiDto>> realtimeStocksList(
    List<String> stockCodeList,
  ) async {
    final url = ApiUrl.naverRealtimeUrl;
    final stockCodeListQuery = stockCodeList.join(',');
    final response = await _dio.get(
      url,
      queryParameters: {'query': 'SERVICE_ITEM:$stockCodeListQuery'},
      options: Options(responseType: ResponseType.bytes),
    );
    final text = utf8.decode(response.data!, allowMalformed: true);
    final body = jsonDecode(text) as Map<String, dynamic>;
    final areas = (body['result'] as Map<String, dynamic>)['areas'] as List;
    final datas = (areas.first as Map<String, dynamic>)['datas'] as List;
    final result = datas.map((e) => RealtimeApiDto.fromJson(e)).toList();

    return result;
  }
}
