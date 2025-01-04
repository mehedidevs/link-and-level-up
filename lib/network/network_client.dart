import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../config/routes/app_routes.dart';
import '../core/constants/keys.dart';
import '../core/file_uploader/image_upload_service.dart';
import '../db/secure_storage_service.dart';
import '../main.dart';
import 'api_service.dart';
import 'auth/token_response.dart';

// network_client.dart
class NetworkClient {
  late final Dio _dio;
  bool _isRefreshing = false;
  final _secureStorage = SecureStorageService();

  // Queue to store failed requests that need to be retried
  final _failedRequests = <_RetryRequest>[];

  NetworkClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'http://3.142.144.94:3000/',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _handleRequest,
        onResponse: _handleResponse,
        onError: _handleError,
      ),
    );
  }

  var service = ImageUploadService(
    baseUrl: 'http://3.142.144.94:3000',
  );

  void _handleRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip token for auth endpoints
    if (options.path.contains('/auth/token') ||
        options.path.contains('/auth/login')) {
      return handler.next(options);
    }

    final token = await _secureStorage.getString(accessToken);
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    print('Request [${options.method}] => PATH: ${options.path}');
    print('Headers: ${options.headers}');
    print('Data: ${options.data}');

    return handler.next(options);
  }

  void _handleResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    print(
        'Response [${response.statusCode}] => PATH: ${response.requestOptions.path}');
    print('Data: ${response.data}');

    return handler.next(response);
  }

  Future<void> _handleError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    print(
        'Error [${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    print('Error Message: ${err.message}');

    if (err.response?.statusCode == 401) {
      final options = err.requestOptions;

      // If we're not already refreshing token
      if (!_isRefreshing) {
        _isRefreshing = true;

        try {
          final newTokens = await _refreshToken();
          if (newTokens != null) {
            // Update token in storage
            await _secureStorage.saveString(accessToken, newTokens.accessToken);
            await _secureStorage.saveString(
                refreshToken, newTokens.refreshToken);

            // Retry all failed requests
            for (var request in _failedRequests) {
              try {
                final response =
                    await _retry(request.options, newTokens.accessToken);
                request.completer.complete(response);
              } catch (e) {
                request.completer.completeError(e);
              }
            }

            // Clear failed requests
            _failedRequests.clear();

            // Retry current request
            final response = await _retry(options, newTokens.accessToken);
            return handler.resolve(response);
          }
        } catch (e) {
          // Token refresh failed
          print('Token refresh failed: $e');
          _handleSessionExpired();
          return handler.reject(err);
        } finally {
          _isRefreshing = false;
        }
      } else {
        // Wait for token refresh
        try {
          final response = await _queueRequest(options);
          return handler.resolve(response);
        } catch (e) {
          return handler.reject(err);
        }
      }
    }

    return handler.next(err);
  }

  Future<Response<dynamic>> _retry(
    RequestOptions requestOptions,
    String newToken,
  ) async {
    final options = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        'Authorization': 'Bearer $newToken',
      },
    );

    return _dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  Future<Response> _queueRequest(RequestOptions options) async {
    final completer = Completer<Response>();
    _failedRequests.add(_RetryRequest(options, completer));
    return completer.future;
  }

  Future<TokenResponse?> _refreshToken() async {
    try {
      final refreshTokenValue = await _secureStorage.getString(refreshToken);
      if (refreshTokenValue == null) {
        throw Exception('No refresh token found');
      }

      final response = await _dio.post(
        '/auth/token',
        data: {'token': refreshTokenValue},
      );

      return TokenResponse.fromJson(response.data);
    } catch (e) {
      print('Error refreshing token: $e');
      return null;
    }
  }

  void _handleSessionExpired() async {
    // Clear stored tokens
    await _secureStorage.delete(accessToken);
    await _secureStorage.delete(refreshToken);

    // Navigate to login
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      AppRoutes.login,
      (route) => false,
    );

    // Show message
    if (navigatorKey.currentContext != null) {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        const SnackBar(
          content: Text('Session expired. Please login again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  ApiService get apiService => ApiService(_dio);
}

class _RetryRequest {
  final RequestOptions options;
  final Completer<Response> completer;

  _RetryRequest(this.options, this.completer);
}
