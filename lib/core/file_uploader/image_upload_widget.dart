// widgets/image_upload_widget.dart
import 'dart:io';

import 'package:flutter/material.dart';

import 'image_picker_widget.dart';
import 'image_upload_response.dart';
import 'image_upload_service.dart';

class ImageUploadWidget extends StatefulWidget {
  final ImageUploadService uploadService;
  final String endpoint;
  final Map<String, dynamic> additionalData;
  final Map<String, String>? additionalHeaders;
  final Function(ImageUploadResponse)? onUploadComplete;
  final Function(double)? onUploadProgress;
  final Widget? customLoadingWidget;
  final Widget? customErrorWidget;
  final Widget? customSuccessWidget;

  const ImageUploadWidget({
    Key? key,
    required this.uploadService,
    required this.endpoint,
    required this.additionalData,
    this.additionalHeaders,
    this.onUploadComplete,
    this.onUploadProgress,
    this.customLoadingWidget,
    this.customErrorWidget,
    this.customSuccessWidget,
  }) : super(key: key);

  @override
  State<ImageUploadWidget> createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  File? _selectedImage;
  bool _isUploading = false;
  String? _error;
  double _uploadProgress = 0;

  Future<void> _uploadImage() async {
    if (_selectedImage == null) return;

    setState(() {
      _isUploading = true;
      _error = null;
    });

    final response = await widget.uploadService.uploadImage(
      imageFile: _selectedImage!,
      endpoint: widget.endpoint,
      additionalData: widget.additionalData,
      additionalHeaders: widget.additionalHeaders,
      onSendProgress: (sent, total) {
        final progress = sent / total;
        setState(() => _uploadProgress = progress);
        widget.onUploadProgress?.call(progress);
      },
    );

    setState(() {
      _isUploading = false;
      if (!response.success) {
        _error = response.message;
      }
    });

    widget.onUploadComplete?.call(response);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ImagePickerWidget(
          onImageSelected: (file) {
            setState(() => _selectedImage = file);
          },
        ),
        if (_selectedImage != null && !_isUploading) ...[
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _uploadImage,
            icon: const Icon(Icons.upload),
            label: const Text('Upload Image'),
          ),
        ],
        if (_isUploading)
          widget.customLoadingWidget ??
              Column(
                children: [
                  const CircularProgressIndicator(),
                  Text('${(_uploadProgress * 100).toStringAsFixed(1)}%'),
                ],
              ),
        if (_error != null)
          widget.customErrorWidget ??
              Text(
                _error!,
                style: const TextStyle(color: Colors.red),
              ),
      ],
    );
  }
}
