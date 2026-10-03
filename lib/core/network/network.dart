import 'package:dio/dio.dart';

Dio creatDio() {
  final dio = Dio();
  dio.options.baseUrl = 'https://api.example.com';
  dio.options.connectTimeout = const Duration(seconds: 5);
  dio.options.receiveTimeout = const Duration(seconds: 10);
  return dio;
}
