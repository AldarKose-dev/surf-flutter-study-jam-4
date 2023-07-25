import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioExceptionType.unknown:
        message = 'No Internet';
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request ' + error.toString();
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        if (error['message'] == "Not found") {
          return error["errors"]["error"];
        }
        return error['message'];
      case 405:
        return error['message'];
      case 410:
        return error['errors']["error"];
      case 422:
        return error['errors']["error"];
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      default:
        return error;
    }
  }

  @override
  String toString() => message;
}
