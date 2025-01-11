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
  final Function(List<ImageUploadResponse>)? onUploadComplete;
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
  List<File> _selectedImages = [];
  bool _isUploading = false;
  String? _error;
  double _uploadProgress = 0;
  List<ImageUploadResponse> _uploadResponses = [];

  Future<void> _uploadImages() async {
    if (_selectedImages.isEmpty) return;

    setState(() {
      _isUploading = true;
      _error = null;
      _uploadResponses = [];
    });

    try {
      for (int i = 0; i < _selectedImages.length; i++) {
        final response = await widget.uploadService.uploadImage(
          imageFile: _selectedImages[i],
          endpoint: widget.endpoint,
          additionalData: widget.additionalData,
          additionalHeaders: widget.additionalHeaders,
          onSendProgress: (sent, total) {
            final individualProgress = sent / total;
            final overallProgress = (i + individualProgress) / _selectedImages.length;
            setState(() => _uploadProgress = overallProgress);
            widget.onUploadProgress?.call(overallProgress);
          },
        );

        _uploadResponses.add(response);

        if (!response.success) {
          setState(() {
            _error = response.message;
          });
          break;
        }
      }
    } catch (e) {
      setState(() {
        _error = 'Error uploading images: $e';
      });
    } finally {
      setState(() {
        _isUploading = false;
      });

      widget.onUploadComplete?.call(_uploadResponses);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ImagePickerWidget(
          onImagesSelected: (files) {
            setState(() => _selectedImages = files);
          },
          initialImages: _selectedImages,
        ),
        if (_selectedImages.isNotEmpty && !_isUploading) ...[
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _uploadImages,
            icon: const Icon(Icons.upload),
            label: Text('Upload ${_selectedImages.length} Images'),
          ),
        ],
        if (_isUploading)
          widget.customLoadingWidget ??
              Column(
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 8),
                  Text(
                    'Uploading ${(_uploadProgress * 100).toStringAsFixed(1)}%',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'Image ${(_uploadProgress * _selectedImages.length).ceil()} of ${_selectedImages.length}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
        if (_error != null)
          widget.customErrorWidget ??
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  _error!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
      ],
    );
  }
}
