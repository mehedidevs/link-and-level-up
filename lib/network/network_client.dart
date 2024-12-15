import 'package:dio/dio.dart';

import 'api_service.dart';

class NetworkClient {
  late final Dio _dio;

  NetworkClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'http://3.142.144.94:3000/',
      ),
    );

    // Add interceptor for logging requests, responses, and errors
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('Request [${options.method}] => PATH: ${options.path}');
          print('Headers: ${options.headers}');
          print('Data: ${options.data}');
          return handler.next(options); // Continue with the request
        },
        onResponse: (response, handler) {
          print('Response [${response.statusCode}] => PATH: ${response.requestOptions.path}');
          print('Data: ${response.data}');
          return handler.next(response); // Continue with the response
        },
        onError: (DioException error, handler) {
          print('Error [${error.response?.statusCode}] => PATH: ${error.requestOptions.path}');
          print('Error Message: ${error.message}');
          return handler.next(error); // Continue with the error
        },
      ),
    );
  }

  Dio get dio => _dio;

  ApiService get apiService => ApiService(_dio);
}
