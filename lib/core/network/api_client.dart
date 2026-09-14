import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'api_exception.dart';
import 'api_response.dart';
import 'api_response_handler.dart';

class ApiClient {
  ApiClient._();

  static const Duration _timeout = Duration(seconds: 30);

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

      final sessionID = prefs.getString('sessionID');

      if (sessionID != null && sessionID.trim().isNotEmpty) {
        requestHeaders['Authorization'] =
        'Bearer ${sessionID.trim()}';
      }
    }

    // =======================================================
    // CUSTOM HEADERS
    //
    // Custom headers override defaults if required.
    // =======================================================

    if (headers != null) {
      requestHeaders.addAll(headers);
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
    return _execute<T>(
      requiresAuth: requiresAuth,
      request: () async {
        final requestHeaders = await _buildHeaders(
          headers: headers,
          requiresAuth: requiresAuth,
        );

        return http.get(
          Uri.parse(url),
          headers: requestHeaders,
        );
      },
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
    return _execute<T>(
      requiresAuth: requiresAuth,
      request: () async {
        final requestHeaders = await _buildHeaders(
          headers: headers,
          requiresAuth: requiresAuth,
        );

        return http.post(
          Uri.parse(url),
          headers: requestHeaders,
          body: body == null
              ? null
              : jsonEncode(body),
        );
      },
      parser: parser,
    );
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
    return _execute<T>(
      requiresAuth: requiresAuth,
      request: () async {
        final requestHeaders = await _buildHeaders(
          headers: headers,
          requiresAuth: requiresAuth,
        );

        return http.put(
          Uri.parse(url),
          headers: requestHeaders,
          body: body == null
              ? null
              : jsonEncode(body),
        );
      },
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
    return _execute<T>(
      requiresAuth: requiresAuth,
      request: () async {
        final requestHeaders = await _buildHeaders(
          headers: headers,
          requiresAuth: requiresAuth,
        );

        return http.patch(
          Uri.parse(url),
          headers: requestHeaders,
          body: body == null
              ? null
              : jsonEncode(body),
        );
      },
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
    return _execute<T>(
      requiresAuth: requiresAuth,
      request: () async {
        final requestHeaders = await _buildHeaders(
          headers: headers,
          requiresAuth: requiresAuth,
        );

        return http.delete(
          Uri.parse(url),
          headers: requestHeaders,
          body: body == null
              ? null
              : jsonEncode(body),
        );
      },
      parser: parser,
    );
  }

  // =========================================================
  // COMMON REQUEST EXECUTOR
  //
  // EVERY API REQUEST COMES THROUGH HERE.
  // =========================================================

  static Future<ApiResponse<T>> _execute<T>({
    required Future<http.Response> Function() request,
    required bool requiresAuth,
    T Function(dynamic data)? parser,
  }) async {
    try {
      final response = await request().timeout(
        _timeout,
      );

      // =====================================================
      // SUCCESS: 200 - 299
      // =====================================================

      if (response.statusCode >= 200 &&
          response.statusCode < 300) {
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

    on TimeoutException {
      return ApiResponse<T>.failure(
        message: 'Request timed out. Please try again.',
        statusCode: 408,
      );
    }

    // =======================================================
    // OUR API EXCEPTION
    // =======================================================

    on ApiException catch (error) {
      return ApiResponse<T>.failure(
        message: error.message,
        statusCode: error.statusCode,
        data: error.data,
      );
    }

    // =======================================================
    // INTERNET / UNKNOWN ERROR
    // =======================================================

    catch (error) {
      return ApiResponse<T>.failure(
        message: 'Unable to connect to the server.',
      );
    }
  }

  // =========================================================
  // CLEAR LOCAL SESSION
  // =========================================================

  static Future<void> _clearSession() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('sessionID');
    await prefs.remove('role');
    await prefs.remove('username');
  }
}