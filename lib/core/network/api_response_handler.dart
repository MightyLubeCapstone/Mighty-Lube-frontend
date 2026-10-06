import 'dart:convert';

import 'api_exception.dart';
import 'api_response.dart';

class ApiResponseHandler {
  ApiResponseHandler._();

  // =========================================================
  // HANDLE SUCCESS RESPONSE
  // =========================================================

  static ApiResponse<T> handleSuccess<T>({
    required int statusCode,
    required dynamic responseBody,
    T Function(dynamic data)? parser,
  }) {
    final dynamic decodedBody = _decodeBody(responseBody);
    dynamic rawData = decodedBody;

    String? message;

    if (decodedBody is Map<String, dynamic>) {
      if (decodedBody.containsKey('message')) {
        message = decodedBody['message']?.toString();
      }

      // =====================================================
      // IMPORTANT
      //
      // If a service provides its own parser, give that parser
      // the COMPLETE backend response.
      //
      // Example:
      //
      // {
      //   "summary": {...},
      //   "query": {...},
      //   "data": [...]
      // }
      //
      // AdminApiService needs summary + data together.
      //
      // Only automatically unwrap "data" when no custom
      // parser has been supplied.
      // =====================================================

      if (parser == null && decodedBody.containsKey('data')) {
        rawData = decodedBody['data'];
      }
    }

    T? parsedData;

    if (parser != null) {
      parsedData = parser(decodedBody);
    } else {
      parsedData = rawData as T?;
    }

    return ApiResponse<T>.success(
      data: parsedData,
      message: message,
      statusCode: statusCode,
    );
  }

  // =========================================================
  // HANDLE ERROR RESPONSE
  //
  // Supports both legacy and current backend formats:
  //
  // message
  // error
  // details
  // errors
  // code
  // errorCode
  // fieldErrors
  // missingFields
  // data
  // =========================================================

  static ApiResponse<T> handleError<T>({
    required int statusCode,
    required dynamic responseBody,
  }) {
    final dynamic decodedBody = _decodeBody(responseBody);

    String message = _defaultMessage(statusCode);
    dynamic data;

    Map<String, String> fieldErrors = <String, String>{};
    List<String> missingFields = <String>[];
    String? errorCode;

    if (decodedBody is Map) {
      final Map<String, dynamic> body =
      Map<String, dynamic>.from(decodedBody);

      // =====================================================
      // MAIN ERROR MESSAGE
      // =====================================================

      final dynamic errorMessage =
          body['message'] ??
              body['error'] ??
              body['details'] ??
              body['errors'];

      final String? parsedMessage = _stringifyErrorMessage(
        errorMessage,
      );

      if (parsedMessage != null) {
        message = parsedMessage;
      }

      // =====================================================
      // MACHINE-READABLE ERROR CODE
      //
      // Supports both:
      // {
      //   "code": "USERNAME_ALREADY_EXISTS"
      // }
      //
      // and:
      // {
      //   "errorCode": "USERNAME_ALREADY_EXISTS"
      // }
      // =====================================================

      final dynamic rawErrorCode =
          body['code'] ??
              body['errorCode'];

      if (rawErrorCode != null &&
          rawErrorCode.toString().trim().isNotEmpty) {
        errorCode = rawErrorCode.toString().trim();
      }

      // =====================================================
      // FIELD ERRORS
      //
      // Expected:
      //
      // {
      //   "fieldErrors": {
      //     "username": "This username is already taken",
      //     "email": "Email already exists",
      //     "phoneNumber": "Enter a valid phone number"
      //   }
      // }
      // =====================================================

      fieldErrors = _parseFieldErrors(
        body['fieldErrors'],
      );

      // =====================================================
      // MISSING REQUIRED FIELDS
      //
      // Expected:
      //
      // {
      //   "missingFields": [
      //     "phoneNumber",
      //     "country"
      //   ]
      // }
      // =====================================================

      missingFields = _parseMissingFields(
        body['missingFields'],
      );

      // =====================================================
      // DATA
      // =====================================================

      if (body.containsKey('data')) {
        data = body['data'];
      }
    } else if (decodedBody is String &&
        decodedBody.trim().isNotEmpty) {
      message = decodedBody.trim();
    }

    return ApiResponse<T>.failure(
      message: message,
      statusCode: statusCode,
      data: data,
      fieldErrors: fieldErrors,
      missingFields: missingFields,
      errorCode: errorCode,
    );
  }

  // =========================================================
  // PARSE FIELD ERRORS
  // =========================================================

  static Map<String, String> _parseFieldErrors(
      dynamic value,
      ) {
    if (value is! Map) {
      return <String, String>{};
    }

    final result = <String, String>{};

    value.forEach(
          (
          dynamic key,
          dynamic errorValue,
          ) {
        final String fieldName = key.toString().trim();

        if (fieldName.isEmpty || errorValue == null) {
          return;
        }

        final String? errorMessage = _stringifyErrorMessage(
          errorValue,
        );

        if (errorMessage != null &&
            errorMessage.trim().isNotEmpty) {
          result[fieldName] = errorMessage.trim();
        }
      },
    );

    return result;
  }

  // =========================================================
  // PARSE MISSING FIELDS
  // =========================================================

  static List<String> _parseMissingFields(
      dynamic value,
      ) {
    if (value is! List) {
      return <String>[];
    }

    return value
        .where(
          (item) => item != null,
    )
        .map(
          (item) => item.toString().trim(),
    )
        .where(
          (item) => item.isNotEmpty,
    )
        .toSet()
        .toList();
  }

  // =========================================================
  // THROW EXCEPTION
  // =========================================================

  static ApiException createException({
    required int statusCode,
    required dynamic responseBody,
  }) {
    final response = handleError<dynamic>(
      statusCode: statusCode,
      responseBody: responseBody,
    );

    return ApiException(
      message: response.message ?? 'Something went wrong',
      statusCode: response.statusCode,
      data: response.data,
    );
  }

  // =========================================================
  // COMMON RESPONSE BODY DECODER
  // =========================================================

  static dynamic _decodeBody(
      dynamic body,
      ) {
    if (body == null) {
      return null;
    }

    if (body is Map || body is List) {
      return body;
    }

    if (body is String) {
      if (body.trim().isEmpty) {
        return null;
      }

      try {
        return jsonDecode(
          body,
        );
      } catch (_) {
        return body;
      }
    }

    return body;
  }

  // =========================================================
  // STRINGIFY ERROR MESSAGE
  //
  // Keeps compatibility with old UserAPI._extractErrorMessage()
  // =========================================================

  static String? _stringifyErrorMessage(
      dynamic message,
      ) {
    if (message is String &&
        message.trim().isNotEmpty) {
      return message.trim();
    }

    if (message is List &&
        message.isNotEmpty) {
      return message
          .map(
            (item) => item.toString(),
      )
          .join('\n');
    }

    if (message is Map &&
        message.isNotEmpty) {
      return message.entries
          .map(
            (entry) => '${entry.key}: ${entry.value}',
      )
          .join('\n');
    }

    if (message != null) {
      return message.toString();
    }

    return null;
  }

  // =========================================================
  // COMMON STATUS MESSAGE
  // =========================================================

  static String _defaultMessage(
      int statusCode,
      ) {
    switch (statusCode) {
      case 400:
        return 'Bad request';

      case 401:
        return 'Unauthorized';

      case 403:
        return 'Access denied';

      case 404:
        return 'Resource not found';

      case 408:
        return 'Request timeout';

      case 409:
        return 'Conflict';

      case 422:
        return 'Invalid request data';

      case 500:
        return 'Internal server error';

      case 502:
        return 'Bad gateway';

      case 503:
        return 'Service unavailable';

      default:
        return 'Something went wrong';
    }
  }
}