import 'package:flutter/material.dart';
import 'package:link_level_up/core/constants/keys.dart';

import '../../db/secure_storage_service.dart';
import 'image_upload_service.dart';

class ImageUploadProvider extends ChangeNotifier {
  final ImageUploadService _uploadService;
  String? _token;

  ImageUploadProvider(this._uploadService);

/*  Future<void> initialize() async {
    _token = await SecureStorageService().getString(accessToken);
    if (_token != null) {
      await _uploadService.updateToken(_token!);
    }
    notifyListeners();
  }*/



  String? get token => _token;
}
