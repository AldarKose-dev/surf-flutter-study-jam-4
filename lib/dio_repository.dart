import 'package:dio/dio.dart';

class DioRepository {
  Future<Response> getFromApi({
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var dio = Dio();
      dio.options.baseUrl = "https://eightballapi.com/api";
      dio.options.headers['accept'] = 'application/json';
      final response = await dio.get(
        '/',
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
