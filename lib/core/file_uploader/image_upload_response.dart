class ImageUploadResponse {
  final bool success;
  final String message;
  final dynamic data;

  ImageUploadResponse({
    required this.success,
    required this.message,
    this.data,
  });
}
