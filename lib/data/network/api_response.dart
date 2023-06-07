import 'dart:typed_data';

class ApiResponse {
  final dynamic body;
  final Uint8List bodyBytes;
  final dynamic headers;

  const ApiResponse({
    required this.body,
    required this.bodyBytes,
    required this.headers,
  });
}
