import 'package:dio/dio.dart';

Dio createDio() {
  final dio = Dio();
  dio.options.connectTimeout = const Duration(seconds: 5);
  dio.options.receiveTimeout = const Duration(seconds: 10);
  return dio;
}

class ApiUrl {
  const ApiUrl(this.dio);
  final Dio dio;

  static const String naverSearchUrl = "https://ac.stock.naver.com/ac";
  static const String naverRealtimeUrl =
      "https://polling.finance.naver.com/api/realtime";
  static const String naverDetailUrl =
      "https://stock.naver.com/api/securityFe/api/fchart/domestic/stock";
  static const String naverDailyUrl =
      "https://api.stock.naver.com/chart/domestic/item";
}
