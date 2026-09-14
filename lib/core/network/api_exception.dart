class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  const ApiException({
    required this.message,
    this.statusCode,
    this.data,
  });

  @override
  String toString() {
    return 'ApiException('
        'message: $message, '
        'statusCode: $statusCode, '
        'data: $data'
        ')';
  }
}