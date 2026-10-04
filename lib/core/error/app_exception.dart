import 'package:dio/dio.dart';
import 'package:edencrew_assignment_starter/core/error/error_code.dart';

class AppException implements Exception {
  const AppException(this.errorCode);
  final ErrorCode errorCode;
}

AppException toAppException(Object e) {
  if (e is AppException) return e;

  if (e is DioException) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const AppException(ErrorCode.timeout);
      case DioExceptionType.connectionError:
        return const AppException(ErrorCode.network);
      case DioExceptionType.badResponse:
        return const AppException(ErrorCode.server);
      default:
        return const AppException(ErrorCode.unknown);
    }
  }

  if (e is TypeError || e is FormatException) {
    return const AppException(ErrorCode.parse);
  }

  return const AppException(ErrorCode.unknown);
}
