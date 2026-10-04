import 'package:dio/dio.dart';
import 'package:edencrew_assignment_starter/core/network/network.dart';
import 'package:edencrew_assignment_starter/core/utils/format_datetime.dart';
import 'package:edencrew_assignment_starter/data/dto/daily_api_dto.dart';

class DailyApiDataSource {
  const DailyApiDataSource(this._dio);
  final Dio _dio;

  Future<List<DailyApiDto>> stockDaily(
    String stockCode,
    DateTime startDateTime,
    DateTime endDateTime,
  ) async {
    final startDate = FormatDatetime.formatDate(startDateTime);
    final endDate = FormatDatetime.formatDate(endDateTime);
    final url = '${ApiUrl.naverDailyUrl}/$stockCode/day';
    final response = await _dio.get(
      url,
      queryParameters: {'startDateTime': startDate, 'endDateTime': endDate},
    );
    final body = response.data as List;
    final result = body
        .map((e) => DailyApiDto.fromJson(e as Map<String, dynamic>))
        .toList();

    return result;
  }
}
