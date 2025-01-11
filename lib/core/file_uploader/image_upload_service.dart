import 'dart:io';
import 'package:dio/dio.dart';
import 'package:link_level_up/core/constants/keys.dart';
import '../../db/secure_storage_service.dart';
import 'image_upload_response.dart';

class ImageUploadService {
  final Dio _dio;
  final String baseUrl;

  ImageUploadService({
    required this.baseUrl,
  }) : _dio = Dio() {
    _initializeDio();
  }

  void _initializeDio() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.validateStatus = (status) => true; // Handle all status codes
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.options.sendTimeout = const Duration(seconds: 30);
    updateToken();
  }

  Future<void> updateToken() async {
    try {
      String? token = await SecureStorageService().getString(accessToken);
      if (token != null) {
        _dio.options.headers = {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        };
      }
    } catch (e) {
      print('Error updating token: $e');
    }
  }

  Future<ImageUploadResponse> uploadImage({
    required File imageFile,
    required String endpoint,
    required Map<String, dynamic> additionalData,
    Map<String, String>? additionalHeaders,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      await updateToken(); // Ensure token is up to date

      final formData = FormData.fromMap({
        'files': [
          await MultipartFile.fromFile(
            imageFile.path,
            filename: imageFile.path.split('/').last,
          )
        ],
        ...additionalData,
      });

      // Add any additional headers
      if (additionalHeaders != null) {
        _dio.options.headers.addAll(additionalHeaders);
      }

      final response = await _dio.post(
        endpoint,
        data: formData,
        onSendProgress: onSendProgress,
      );

      // Log response for debugging
      print('Upload Response Status: ${response.statusCode}');
      print('Upload Response Data: ${response.data}');

      // Handle different status codes
      if (response.statusCode == 500) {
        return ImageUploadResponse(
          success: false,
          message: 'Server error: ${_extractErrorMessage(response)}',
          data: response.data,
        );
      } else if (response.statusCode == 413) {
        return ImageUploadResponse(
          success: false,
          message: 'File too large. Please select a smaller image.',
          data: response.data,
        );
      } else if (response.statusCode == 401) {
        return ImageUploadResponse(
          success: false,
          message: 'Unauthorized. Please login again.',
          data: response.data,
        );
      } else if (response.statusCode != 200 && response.statusCode != 201) {
        return ImageUploadResponse(
          success: false,
          message: 'Upload failed: ${_extractErrorMessage(response)}',
          data: response.data,
        );
      }

      return ImageUploadResponse(
        success: true,
        message: 'Upload successful',
        data: response.data,
      );

    } on DioException catch (e) {
      print('DioException during upload:');
      print('Error type: ${e.type}');
      print('Error message: ${e.message}');
      print('Error response: ${e.response?.data}');

      return ImageUploadResponse(
        success: false,
        message: _handleDioError(e),
        data: e.response?.data,
      );

    } catch (e, stackTrace) {
      print('General error during upload:');
      print(e);
      print('Stack trace:');
      print(stackTrace);

      return ImageUploadResponse(
        success: false,
        message: 'Upload failed: ${e.toString()}',
        data: null,
      );
    } finally {
      // Clean up any additional headers
      if (additionalHeaders != null) {
        additionalHeaders.keys.forEach((key) {
          _dio.options.headers.remove(key);
        });
      }
    }
  }

  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timed out. Please check your internet connection.';
      case DioExceptionType.sendTimeout:
        return 'Upload timed out. Please try again.';
      case DioExceptionType.receiveTimeout:
        return 'Server response timed out. Please try again.';
      case DioExceptionType.badResponse:
        return 'Server error: ${_extractErrorMessage(e.response)}';
      case DioExceptionType.connectionError:
        return 'Connection error. Please check your internet connection.';
      default:
        return e.message ?? 'An unexpected error occurred';
    }
  }

  String _extractErrorMessage(Response? response) {
    if (response?.data is Map) {
      return response?.data['message'] ??
          response?.data['error'] ??
          'Unknown error';
    }
    return 'Unknown error';
  }

  Future<ImageUploadResponse> uploadMultipleImages({
    required List<File> imageFiles,
    required String endpoint,
    required Map<String, dynamic> additionalData,
    Map<String, String>? additionalHeaders,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      await updateToken();

      List<MultipartFile> files = await Future.wait(
        imageFiles.map((file) async {
          return await MultipartFile.fromFile(
            file.path,
            filename: file.path.split('/').last,
          );
        }),
      );

      final formData = FormData.fromMap({
        'files': files,
        ...additionalData,
      });

      if (additionalHeaders != null) {
        _dio.options.headers.addAll(additionalHeaders);
      }

      final response = await _dio.post(
        endpoint,
        data: formData,
        onSendProgress: onSendProgress,
      );

      return ImageUploadResponse(
        success: response.statusCode == 200 || response.statusCode == 201,
        message: response.statusCode == 200 || response.statusCode == 201
            ? 'Upload successful'
            : _extractErrorMessage(response),
        data: response.data,
      );

    } catch (e) {
      if (e is DioException) {
        return ImageUploadResponse(
          success: false,
          message: _handleDioError(e),
          data: e.response?.data,
        );
      }
      return ImageUploadResponse(
        success: false,
        message: e.toString(),
        data: null,
      );
    }
  }
}