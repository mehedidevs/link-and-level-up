// widgets/image_picker_widget.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatelessWidget {
  final void Function(File) onImageSelected;
  final double? previewHeight;
  final double? previewWidth;
  final BoxFit previewFit;
  final bool showPreview;
  final Widget? customPreviewWidget;
  final Widget? cameraButtonChild;
  final Widget? galleryButtonChild;

  const ImagePickerWidget({
    Key? key,
    required this.onImageSelected,
    this.previewHeight = 200,
    this.previewWidth = 200,
    this.previewFit = BoxFit.cover,
    this.showPreview = true,
    this.customPreviewWidget,
    this.cameraButtonChild,
    this.galleryButtonChild,
  }) : super(key: key);

  Future<void> _pickImage(ImageSource source, BuildContext context) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        onImageSelected(File(pickedFile.path));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              onPressed: () => _pickImage(ImageSource.camera, context),
              icon: const Icon(Icons.camera_alt),
              label: cameraButtonChild ?? const Text('Camera'),
            ),
            ElevatedButton.icon(
              onPressed: () => _pickImage(ImageSource.gallery, context),
              icon: const Icon(Icons.photo_library),
              label: galleryButtonChild ?? const Text('Gallery'),
            ),
          ],
        ),
      ],
    );
  }
}