class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? message;
  final int? statusCode;

  /// Backend validation errors mapped to individual fields.
  ///
  /// Example:
  /// {
  ///   "username": "This username is already taken",
  ///   "email": "An account with this email already exists",
  ///   "phoneNumber": "Enter a valid phone number"
  /// }
  final Map<String, String> fieldErrors;

  /// Required fields that were missing from the request.
  ///
  /// Example:
  /// ["phoneNumber", "country"]
  final List<String> missingFields;

  /// Optional machine-readable backend error code.
  ///
  /// Example:
  /// USERNAME_ALREADY_EXISTS
  /// EMAIL_ALREADY_EXISTS
  /// INVALID_PHONE_NUMBER
  final String? errorCode;

  const ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.statusCode,
    this.fieldErrors = const <String, String>{},
    this.missingFields = const <String>[],
    this.errorCode,
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
    Map<String, String> fieldErrors = const <String, String>{},
    List<String> missingFields = const <String>[],
    String? errorCode,
  }) {
    return ApiResponse<T>(
      success: false,
      data: data,
      message: message,
      statusCode: statusCode,
      fieldErrors: fieldErrors,
      missingFields: missingFields,
      errorCode: errorCode,
    );
  }

  bool get hasFieldErrors => fieldErrors.isNotEmpty;

  bool get hasMissingFields => missingFields.isNotEmpty;

  String? getFieldError(String fieldName) {
    return fieldErrors[fieldName];
  }

  @override
  String toString() {
    return 'ApiResponse('
        'success: $success, '
        'statusCode: $statusCode, '
        'message: $message, '
        'errorCode: $errorCode, '
        'fieldErrors: $fieldErrors, '
        'missingFields: $missingFields, '
        'data: $data'
        ')';
  }
}