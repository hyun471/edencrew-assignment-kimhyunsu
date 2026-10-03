import 'package:dio/dio.dart';

Dio createDio() {
  final dio = Dio();
  dio.options.baseUrl = 'https://api.example.com'; // TODO : 임시 URL 나중에 교체하기
  dio.options.connectTimeout = const Duration(seconds: 5);
  dio.options.receiveTimeout = const Duration(seconds: 10);
  return dio;
}
