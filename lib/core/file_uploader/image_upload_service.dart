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
    updateToken();
    _dio.options.baseUrl = baseUrl;
  }

  Future<void> updateToken() async {
    String? token = await SecureStorageService().getString(accessToken);

    _dio.options.headers = {
      'Authorization': 'Bearer $token',
    };
  }

  Future<ImageUploadResponse> uploadImage({
    required File imageFile,
    required String endpoint,
    required Map<String, dynamic> additionalData,
    Map<String, String>? additionalHeaders,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      final formData = FormData.fromMap({
        'files': [
          await MultipartFile.fromFile(
            imageFile.path,
            filename: imageFile.path.split('/').last,
          )
        ],
        ...additionalData,
      });

      final response = await _dio.post(
        endpoint,
        data: formData,
        onSendProgress: onSendProgress,
      );

      return ImageUploadResponse(
        success: response.statusCode == 200,
        message: 'Upload successful',
        data: response.data,
      );
    } catch (e) {
      return ImageUploadResponse(
        success: false,
        message: e.toString(),
      );
    }
  }
}
