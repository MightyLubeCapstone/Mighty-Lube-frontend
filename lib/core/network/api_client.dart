import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_environment.dart';
import 'api_exception.dart';
import 'api_response.dart';
import 'api_response_handler.dart';

import 'package:http_parser/http_parser.dart';

class ApiClient {
  ApiClient._();

  static const Duration _timeout = Duration(
    seconds: 30,
  );

  // =========================================================
  // DEFAULT HEADERS
  // =========================================================

  static Future<Map<String, String>> _buildHeaders({
    Map<String, String>? headers,
    bool requiresAuth = true,
  }) async {
    final Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    // =======================================================
    // AUTHORIZATION
    //
    // Protected APIs automatically receive the current
    // session token.
    // =======================================================

    if (requiresAuth) {
      final prefs = await SharedPreferences.getInstance();

      final sessionID = prefs.getString(
        'sessionID',
      );

      if (sessionID != null && sessionID.trim().isNotEmpty) {
        requestHeaders['Authorization'] = 'Bearer ${sessionID.trim()}';
      }
    }

    // =======================================================
    // CUSTOM HEADERS
    //
    // Custom headers override defaults if required.
    // =======================================================

    if (headers != null) {
      requestHeaders.addAll(
        headers,
      );
    }

    return requestHeaders;
  }

  // =========================================================
  // GET
  // =========================================================

  static Future<ApiResponse<T>> get<T>({
    required String url,
    Map<String, String>? headers,
    bool requiresAuth = true,
    T Function(dynamic data)? parser,
  }) async {
    final requestHeaders = await _buildHeaders(
      headers: headers,
      requiresAuth: requiresAuth,
    );

    return _execute<T>(
      method: 'GET',
      url: url,
      headers: requestHeaders,
      requiresAuth: requiresAuth,
      request: () => http.get(
        Uri.parse(
          url,
        ),
        headers: requestHeaders,
      ),
      parser: parser,
    );
  }

  // =========================================================
  // POST
  // =========================================================

  static Future<ApiResponse<T>> post<T>({
    required String url,
    dynamic body,
    Map<String, String>? headers,
    bool requiresAuth = true,
    T Function(dynamic data)? parser,
  }) async {
    final requestHeaders = await _buildHeaders(
      headers: headers,
      requiresAuth: requiresAuth,
    );

    return _execute<T>(
      method: 'POST',
      url: url,
      headers: requestHeaders,
      body: body,
      requiresAuth: requiresAuth,
      request: () => http.post(
        Uri.parse(
          url,
        ),
        headers: requestHeaders,
        body: body == null
            ? null
            : jsonEncode(
                body,
              ),
      ),
      parser: parser,
    );
  }

  // =========================================================
  // MULTIPART POST
  //
  // Used for file/image uploads.
  //
  // MultipartRequest automatically creates the correct
  // multipart/form-data Content-Type including its boundary.
  // Therefore application/json Content-Type must be removed.
  // =========================================================

  static Future<ApiResponse<T>> postMultipart<T>({
    required String url,
    required String filePath,
    required String fileField,
    Map<String, String>? fields,
    Map<String, String>? headers,
    bool requiresAuth = true,
    T Function(dynamic data)? parser,
  }) async
  {
    final stopwatch = Stopwatch()..start();

    try {
      // =====================================================
      // CREATE MULTIPART REQUEST
      // =====================================================

      final request = http.MultipartRequest(
        'POST',
        Uri.parse(
          url,
        ),
      );

      // =====================================================
      // HEADERS + AUTHORIZATION
      // =====================================================

      final requestHeaders = await _buildHeaders(
        headers: headers,
        requiresAuth: requiresAuth,
      );

      // MultipartRequest needs to generate:
      //
      // Content-Type:
      // multipart/form-data; boundary=...
      //
      // Therefore do not send application/json here.

      requestHeaders.remove(
        'Content-Type',
      );

      request.headers.addAll(
        requestHeaders,
      );

      // =====================================================
      // OPTIONAL FORM FIELDS
      // =====================================================

      if (fields != null) {
        request.fields.addAll(
          fields,
        );
      }

      // =====================================================
      // FILE
      // =====================================================

      final mimeType = _getImageMimeType(
        filePath,
      );

      final multipartFile = await http.MultipartFile.fromPath(
        fileField,
        filePath,
        contentType: MediaType.parse(
          mimeType,
        ),
      );

      request.files.add(
        multipartFile,
      );

      // =====================================================
      // TESTING MODE REQUEST LOG
      // =====================================================

      _logRequest(
        method: 'POST MULTIPART',
        url: url,
        headers: requestHeaders,
        body: {
          if (fields != null) 'fields': fields,
          'file': {
            'field': fileField,
            'name': multipartFile.filename,
            'size': multipartFile.length,
          },
        },
      );

      // =====================================================
      // SEND REQUEST
      // =====================================================

      final streamedResponse = await request.send().timeout(
            _timeout,
          );

      final response = await http.Response.fromStream(
        streamedResponse,
      );

      stopwatch.stop();

      // =====================================================
      // TESTING MODE RESPONSE LOG
      // =====================================================

      _logResponse(
        method: 'POST MULTIPART',
        url: url,
        statusCode: response.statusCode,
        responseBody: response.body,
        duration: stopwatch.elapsed,
      );

      // =====================================================
      // SUCCESS: 200 - 299
      // =====================================================

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ApiResponseHandler.handleSuccess<T>(
          statusCode: response.statusCode,
          responseBody: response.body,
          parser: parser,
        );
      }

      // =====================================================
      // SESSION INVALID / EXPIRED
      // =====================================================

      if (requiresAuth && response.statusCode == 401) {
        await _clearSession();
      }

      // =====================================================
      // SERVER / API ERROR
      // =====================================================

      return ApiResponseHandler.handleError<T>(
        statusCode: response.statusCode,
        responseBody: response.body,
      );
    }

    // =======================================================
    // TIMEOUT
    // =======================================================

    on TimeoutException catch (error) {
      stopwatch.stop();

      _logError(
        method: 'POST MULTIPART',
        url: url,
        duration: stopwatch.elapsed,
        error: error,
      );

      return ApiResponse<T>.failure(
        message: 'Request timed out. Please try again.',
        statusCode: 408,
      );
    }

    // =======================================================
    // OUR API EXCEPTION
    // =======================================================

    on ApiException catch (error) {
      stopwatch.stop();

      _logError(
        method: 'POST MULTIPART',
        url: url,
        duration: stopwatch.elapsed,
        error: error,
      );

      return ApiResponse<T>.failure(
        message: error.message,
        statusCode: error.statusCode,
        data: error.data,
      );
    }

    // =======================================================
    // INTERNET / FILE / UNKNOWN ERROR
    // =======================================================

    catch (error, stackTrace) {
      stopwatch.stop();

      _logError(
        method: 'POST MULTIPART',
        url: url,
        duration: stopwatch.elapsed,
        error: error,
        stackTrace: stackTrace,
      );

      return ApiResponse<T>.failure(
        message: 'Unable to upload the file.',
      );
    }
  }

  // =========================================================
  // IMAGE MIME TYPE
  // =========================================================

  static String _getImageMimeType(
      String filePath,
      ) {
    final normalizedPath = filePath.toLowerCase();

    if (normalizedPath.endsWith('.jpg') ||
        normalizedPath.endsWith('.jpeg')) {
      return 'image/jpeg';
    }

    if (normalizedPath.endsWith('.png')) {
      return 'image/png';
    }

    if (normalizedPath.endsWith('.webp')) {
      return 'image/webp';
    }

    return 'application/octet-stream';
  }


  // =========================================================
  // PUT
  // =========================================================

  static Future<ApiResponse<T>> put<T>({
    required String url,
    dynamic body,
    Map<String, String>? headers,
    bool requiresAuth = true,
    T Function(dynamic data)? parser,
  }) async {
    final requestHeaders = await _buildHeaders(
      headers: headers,
      requiresAuth: requiresAuth,
    );

    return _execute<T>(
      method: 'PUT',
      url: url,
      headers: requestHeaders,
      body: body,
      requiresAuth: requiresAuth,
      request: () => http.put(
        Uri.parse(
          url,
        ),
        headers: requestHeaders,
        body: body == null
            ? null
            : jsonEncode(
                body,
              ),
      ),
      parser: parser,
    );
  }

  // =========================================================
  // PATCH
  // =========================================================

  static Future<ApiResponse<T>> patch<T>({
    required String url,
    dynamic body,
    Map<String, String>? headers,
    bool requiresAuth = true,
    T Function(dynamic data)? parser,
  }) async {
    final requestHeaders = await _buildHeaders(
      headers: headers,
      requiresAuth: requiresAuth,
    );

    return _execute<T>(
      method: 'PATCH',
      url: url,
      headers: requestHeaders,
      body: body,
      requiresAuth: requiresAuth,
      request: () => http.patch(
        Uri.parse(
          url,
        ),
        headers: requestHeaders,
        body: body == null
            ? null
            : jsonEncode(
                body,
              ),
      ),
      parser: parser,
    );
  }

  // =========================================================
  // DELETE
  // =========================================================

  static Future<ApiResponse<T>> delete<T>({
    required String url,
    dynamic body,
    Map<String, String>? headers,
    bool requiresAuth = true,
    T Function(dynamic data)? parser,
  }) async {
    final requestHeaders = await _buildHeaders(
      headers: headers,
      requiresAuth: requiresAuth,
    );

    return _execute<T>(
      method: 'DELETE',
      url: url,
      headers: requestHeaders,
      body: body,
      requiresAuth: requiresAuth,
      request: () => http.delete(
        Uri.parse(
          url,
        ),
        headers: requestHeaders,
        body: body == null
            ? null
            : jsonEncode(
                body,
              ),
      ),
      parser: parser,
    );
  }

  // =========================================================
  // COMMON REQUEST EXECUTOR
  //
  // EVERY STANDARD JSON API REQUEST COMES THROUGH HERE.
  // =========================================================

  static Future<ApiResponse<T>> _execute<T>({
    required String method,
    required String url,
    required Map<String, String> headers,
    dynamic body,
    required Future<http.Response> Function() request,
    required bool requiresAuth,
    T Function(dynamic data)? parser,
  }) async {
    final stopwatch = Stopwatch()..start();

    // =======================================================
    // TESTING MODE REQUEST LOG
    // =======================================================

    _logRequest(
      method: method,
      url: url,
      headers: headers,
      body: body,
    );

    try {
      final response = await request().timeout(
        _timeout,
      );

      stopwatch.stop();

      // =====================================================
      // TESTING MODE RESPONSE LOG
      // =====================================================

      _logResponse(
        method: method,
        url: url,
        statusCode: response.statusCode,
        responseBody: response.body,
        duration: stopwatch.elapsed,
      );

      // =====================================================
      // SUCCESS: 200 - 299
      // =====================================================

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ApiResponseHandler.handleSuccess<T>(
          statusCode: response.statusCode,
          responseBody: response.body,
          parser: parser,
        );
      }

      // =====================================================
      // SESSION INVALID / EXPIRED
      //
      // Backend authenticate middleware returns 401 when:
      // - token is missing
      // - token is invalid
      // - session is expired
      //
      // Only clear local session for authenticated requests.
      // Public login failures must not trigger this cleanup.
      // =====================================================

      if (requiresAuth && response.statusCode == 401) {
        await _clearSession();
      }

      // =====================================================
      // SERVER / API ERROR
      // =====================================================

      return ApiResponseHandler.handleError<T>(
        statusCode: response.statusCode,
        responseBody: response.body,
      );
    }

    // =======================================================
    // TIMEOUT
    // =======================================================

    on TimeoutException catch (error) {
      stopwatch.stop();

      _logError(
        method: method,
        url: url,
        duration: stopwatch.elapsed,
        error: error,
      );

      return ApiResponse<T>.failure(
        message: 'Request timed out. Please try again.',
        statusCode: 408,
      );
    }

    // =======================================================
    // OUR API EXCEPTION
    // =======================================================

    on ApiException catch (error) {
      stopwatch.stop();

      _logError(
        method: method,
        url: url,
        duration: stopwatch.elapsed,
        error: error,
      );

      return ApiResponse<T>.failure(
        message: error.message,
        statusCode: error.statusCode,
        data: error.data,
      );
    }

    // =======================================================
    // INTERNET / UNKNOWN ERROR
    // =======================================================

    catch (error, stackTrace) {
      stopwatch.stop();

      _logError(
        method: method,
        url: url,
        duration: stopwatch.elapsed,
        error: error,
        stackTrace: stackTrace,
      );

      return ApiResponse<T>.failure(
        message: 'Unable to connect to the server.',
      );
    }
  }

  // =========================================================
  // API LOGGER
  //
  // Enabled only when:
  //
  // AppEnvironmentConfig.testingMode == true
  //
  // Sensitive information is masked before printing.
  // =========================================================

  static void _logRequest({
    required String method,
    required String url,
    required Map<String, String> headers,
    dynamic body,
  }) {
    if (!AppEnvironmentConfig.testingMode) {
      return;
    }

    final safeHeaders = _sanitizeHeaders(
      headers,
    );

    final safeBody = _sanitizeData(
      body,
    );

    final buffer = StringBuffer();

    buffer.writeln();
    buffer.writeln(
      '╔════════════ API REQUEST ════════════',
    );
    buffer.writeln(
      '║ METHOD : $method',
    );
    buffer.writeln(
      '║ URL    : $url',
    );
    buffer.writeln(
      '║ HEADERS:',
    );
    buffer.writeln(
      _prettyPrint(
        safeHeaders,
      ),
    );

    if (body != null) {
      buffer.writeln(
        '║ BODY:',
      );
      buffer.writeln(
        _prettyPrint(
          safeBody,
        ),
      );
    }

    buffer.writeln(
      '╚════════════════════════════════════',
    );

    debugPrint(
      buffer.toString(),
    );
  }

  static void _logResponse({
    required String method,
    required String url,
    required int statusCode,
    required String responseBody,
    required Duration duration,
  }) {
    if (!AppEnvironmentConfig.testingMode) {
      return;
    }

    final buffer = StringBuffer();

    buffer.writeln();
    buffer.writeln(
      '╔════════════ API RESPONSE ═══════════',
    );
    buffer.writeln(
      '║ METHOD : $method',
    );
    buffer.writeln(
      '║ URL    : $url',
    );
    buffer.writeln(
      '║ STATUS : $statusCode',
    );
    buffer.writeln(
      '║ TIME   : ${duration.inMilliseconds} ms',
    );
    buffer.writeln(
      '║ RESPONSE:',
    );
    buffer.writeln(
      _prettyResponse(
        responseBody,
      ),
    );
    buffer.writeln(
      '╚════════════════════════════════════',
    );

    debugPrint(
      buffer.toString(),
    );
  }

  static void _logError({
    required String method,
    required String url,
    required Duration duration,
    required Object error,
    StackTrace? stackTrace,
  }) {
    if (!AppEnvironmentConfig.testingMode) {
      return;
    }

    final buffer = StringBuffer();

    buffer.writeln();
    buffer.writeln(
      '╔════════════ API ERROR ══════════════',
    );
    buffer.writeln(
      '║ METHOD : $method',
    );
    buffer.writeln(
      '║ URL    : $url',
    );
    buffer.writeln(
      '║ TIME   : ${duration.inMilliseconds} ms',
    );
    buffer.writeln(
      '║ ERROR  : $error',
    );

    if (stackTrace != null) {
      buffer.writeln(
        '║ STACK TRACE:',
      );
      buffer.writeln(
        stackTrace.toString(),
      );
    }

    buffer.writeln(
      '╚════════════════════════════════════',
    );

    debugPrint(
      buffer.toString(),
    );
  }

  // =========================================================
  // LOG SANITIZATION
  // =========================================================

  static Map<String, dynamic> _sanitizeHeaders(
    Map<String, String> headers,
  ) {
    final result = <String, dynamic>{};

    for (final entry in headers.entries) {
      if (_isSensitiveKey(
        entry.key,
      )) {
        result[entry.key] = _maskValue(
          entry.key,
          entry.value,
        );
      } else {
        result[entry.key] = entry.value;
      }
    }

    return result;
  }

  static dynamic _sanitizeData(
    dynamic data,
  ) {
    if (data == null) {
      return null;
    }

    if (data is Map) {
      final result = <String, dynamic>{};

      data.forEach(
        (
          dynamic key,
          dynamic value,
        ) {
          final stringKey = key.toString();

          if (_isSensitiveKey(
            stringKey,
          )) {
            result[stringKey] = '****';
          } else {
            result[stringKey] = _sanitizeData(
              value,
            );
          }
        },
      );

      return result;
    }

    if (data is Iterable) {
      return data
          .map(
            _sanitizeData,
          )
          .toList();
    }

    return data;
  }

  static bool _isSensitiveKey(
    String key,
  ) {
    final normalized = key
        .toLowerCase()
        .replaceAll(
          '_',
          '',
        )
        .replaceAll(
          '-',
          '',
        );

    return normalized == 'authorization' ||
        normalized == 'password' ||
        normalized == 'confirmpassword' ||
        normalized == 'sessionid' ||
        normalized == 'token' ||
        normalized == 'accesstoken' ||
        normalized == 'refreshtoken' ||
        normalized == 'apikey' ||
        normalized == 'secret' ||
        normalized == 'clientsecret';
  }

  static String _maskValue(
    String key,
    String value,
  ) {
    if (key.toLowerCase() == 'authorization' &&
        value.toLowerCase().startsWith(
              'bearer ',
            )) {
      return 'Bearer ****';
    }

    return '****';
  }

  // =========================================================
  // PRETTY PRINT
  // =========================================================

  static String _prettyPrint(
    dynamic data,
  ) {
    if (data == null) {
      return 'null';
    }

    try {
      const encoder = JsonEncoder.withIndent(
        '  ',
      );

      return encoder.convert(
        data,
      );
    } catch (_) {
      return data.toString();
    }
  }

  static String _prettyResponse(
    String responseBody,
  ) {
    if (responseBody.trim().isEmpty) {
      return '<empty response>';
    }

    try {
      final decoded = jsonDecode(
        responseBody,
      );

      final safeDecoded = _sanitizeData(
        decoded,
      );

      return _prettyPrint(
        safeDecoded,
      );
    } catch (_) {
      return responseBody;
    }
  }

  // =========================================================
  // CLEAR LOCAL SESSION
  // =========================================================

  static Future<void> _clearSession() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(
      'sessionID',
    );
    await prefs.remove(
      'role',
    );
    await prefs.remove(
      'username',
    );
  }
}
