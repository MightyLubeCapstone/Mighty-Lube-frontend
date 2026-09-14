class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? message;
  final int? statusCode;

  const ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.statusCode,
  });

  factory ApiResponse.success({
    T? data,
    String? message,
    int? statusCode,
  }) {
    return ApiResponse<T>(
      success: true,
      data: data,
      message: message,
      statusCode: statusCode,
    );
  }

  factory ApiResponse.failure({
    String? message,
    int? statusCode,
    T? data,
  }) {
    return ApiResponse<T>(
      success: false,
      data: data,
      message: message,
      statusCode: statusCode,
    );
  }

  @override
  String toString() {
    return 'ApiResponse('
        'success: $success, '
        'statusCode: $statusCode, '
        'message: $message, '
        'data: $data'
        ')';
  }
}