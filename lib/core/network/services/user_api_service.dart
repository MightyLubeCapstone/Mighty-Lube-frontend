import 'package:shared_preferences/shared_preferences.dart';

import '../api_client.dart';
import '../api_endpoints.dart';
import '../api_response.dart';

class UserApiService {
  UserApiService._();

  // =========================================================
  // SESSION STORAGE KEYS
  // =========================================================

  static const String _sessionIDKey = 'sessionID';
  static const String _roleKey = 'role';
  static const String _usernameKey = 'username';

  // =========================================================
  // CHECK SESSION
  //
  // OLD:
  // UserAPI.checkSession()
  //
  // GET /api/sessions
  // =========================================================

  static Future<ApiResponse<bool>> checkSession() async {
    final prefs = await SharedPreferences.getInstance();

    final sessionID = prefs.getString(_sessionIDKey);

    if (sessionID == null || sessionID.trim().isEmpty) {
      return ApiResponse<bool>.success(
        data: false,
        message: 'No active session.',
      );
    }

    final response = await ApiClient.get<Map<String, dynamic>>(
      url: '${ApiEndpoints.apiBaseUrl}/sessions',
      requiresAuth: true,
      parser: _mapParser,
    );

    if (response.success) {
      return ApiResponse<bool>.success(
        data: true,
        message: response.message,
        statusCode: response.statusCode,
      );
    }

    await _clearLocalSession();

    return ApiResponse<bool>.failure(
      message: response.message ?? 'Session is invalid or expired.',
      statusCode: response.statusCode,
      data: false,
    );
  }

  // =========================================================
  // CREATE ACCOUNT
  //
  // OLD:
  // UserAPI.makeAccount(...)
  //
  // POST /api/users
  // =========================================================

  static Future<ApiResponse<bool>> makeAccount({
    required String username,
    required String password,
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String companyName,
    required String securityPin,
    required String country,
  }) async {
    final response = await ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.users,
      requiresAuth: false,
      body: {
        'username': username,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'emailAddress': email,
        'phoneNumber': phoneNumber,
        'companyName': companyName,
        'securityPin': securityPin,
        'country': country,
      },
      parser: _mapParser,
    );

    if (!response.success) {
      return ApiResponse<bool>.failure(
        message: response.message ?? 'Unable to create account.',
        statusCode: response.statusCode,
        data: false,
      );
    }

    final sessionID = response.data?['sessionID']?.toString();

    if (sessionID != null && sessionID.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString(
        _sessionIDKey,
        sessionID,
      );
    }

    return ApiResponse<bool>.success(
      data: true,
      message: response.message,
      statusCode: response.statusCode,
    );
  }

  // =========================================================
  // UPDATE ACCOUNT
  //
  // OLD:
  // UserAPI.updateAccount(...)
  //
  // PUT /api/users
  // =========================================================

  static Future<ApiResponse<bool>> updateAccount({
    required String firstName,
    required String lastName,
    required String username,
    required String companyName,
    required String phoneNumber,
    required String email,
  }) async {
    final response = await ApiClient.put<dynamic>(
      url: ApiEndpoints.users,
      requiresAuth: true,
      body: {
        'firstName': firstName,
        'lastName': lastName,
        'username': username,
        'companyName': companyName,
        'phoneNumber': phoneNumber,
        'email': email,
      },
    );

    if (!response.success) {
      return ApiResponse<bool>.failure(
        message: response.message ?? 'Unable to update account.',
        statusCode: response.statusCode,
        data: false,
      );
    }

    return ApiResponse<bool>.success(
      data: true,
      message: response.message,
      statusCode: response.statusCode,
    );
  }

  // =========================================================
  // REMOVE ACCOUNT
  //
  // OLD:
  // UserAPI.removeAccount(password)
  //
  // DELETE /api/users
  // =========================================================

  static Future<ApiResponse<bool>> removeAccount({
    required String password,
  }) async {
    final response = await ApiClient.delete<dynamic>(
      url: ApiEndpoints.users,
      requiresAuth: true,
      body: {
        'password': password,
      },
    );

    if (!response.success) {
      return ApiResponse<bool>.failure(
        message: response.message ?? 'Unable to remove account.',
        statusCode: response.statusCode,
        data: false,
      );
    }

    return ApiResponse<bool>.success(
      data: true,
      message: response.message,
      statusCode: response.statusCode,
    );
  }

  // =========================================================
  // FORGOT PASSWORD
  //
  // OLD:
  // UserAPI.forgotPassword(email)
  //
  // POST /api/email/forgot
  // =========================================================

  static Future<ApiResponse<bool>> forgotPassword({
    required String email,
  }) async {
    final response = await ApiClient.post<dynamic>(
      url: '${ApiEndpoints.apiBaseUrl}/email/forgot',
      requiresAuth: false,
      body: {
        'email': email,
      },
    );

    if (!response.success) {
      return ApiResponse<bool>.failure(
        message: response.message ?? 'Unable to process forgot password.',
        statusCode: response.statusCode,
        data: false,
      );
    }

    return ApiResponse<bool>.success(
      data: true,
      message: response.message,
      statusCode: response.statusCode,
    );
  }

  // =========================================================
  // VALIDATE PASSCODE
  //
  // OLD:
  // UserAPI.validateCode(email, passcode)
  //
  // GET /api/email/forgot
  //
  // email + passcode are sent as headers because that is
  // exactly what the old backend contract expects.
  // =========================================================

  static Future<ApiResponse<bool>> validateCode({
    required String email,
    required String passcode,
  }) async {
    final response = await ApiClient.get<dynamic>(
      url: '${ApiEndpoints.apiBaseUrl}/email/forgot',
      requiresAuth: false,
      headers: {
        'email': email,
        'passcode': passcode,
      },
    );

    if (!response.success) {
      return ApiResponse<bool>.failure(
        message: response.message ?? 'Invalid verification code.',
        statusCode: response.statusCode,
        data: false,
      );
    }

    return ApiResponse<bool>.success(
      data: true,
      message: response.message,
      statusCode: response.statusCode,
    );
  }

  // =========================================================
  // VALIDATE SECURITY PIN
  //
  // OLD:
  // UserAPI.validateSecurityPin(email, securityPin)
  //
  // POST /api/email/forgot/verify-pin
  // =========================================================

  static Future<ApiResponse<bool>> validateSecurityPin({
    required String email,
    required String securityPin,
  }) async {
    final response = await ApiClient.post<dynamic>(
      url: '${ApiEndpoints.apiBaseUrl}/email/forgot/verify-pin',
      requiresAuth: false,
      body: {
        'email': email.trim(),
        'securityPin': securityPin.trim(),
      },
    );

    if (!response.success) {
      return ApiResponse<bool>.failure(
        message: response.message ?? 'Invalid security PIN.',
        statusCode: response.statusCode,
        data: false,
      );
    }

    return ApiResponse<bool>.success(
      data: true,
      message: response.message,
      statusCode: response.statusCode,
    );
  }

  // =========================================================
  // RESET PASSWORD
  //
  // OLD:
  // UserAPI.resetPassword(email, password)
  //
  // PUT /api/email/forgot
  // =========================================================

  static Future<ApiResponse<bool>> resetPassword({
    required String email,
    required String password,
  }) async {
    final response = await ApiClient.put<dynamic>(
      url: '${ApiEndpoints.apiBaseUrl}/email/forgot',
      requiresAuth: false,
      body: {
        'email': email.trim(),
        'password': password,
      },
    );

    if (!response.success) {
      return ApiResponse<bool>.failure(
        message: response.message ?? 'Unable to reset password.',
        statusCode: response.statusCode,
        data: false,
      );
    }

    return ApiResponse<bool>.success(
      data: true,
      message: response.message,
      statusCode: response.statusCode,
    );
  }

  // =========================================================
  // LOGIN
  //
  // OLD:
  // UserAPI.loginUser(username, password)
  //
  // POST /api/sessions
  //
  // Backend response:
  //
  // {
  //   "status": "success",
  //   "sessionID": "...",
  //   "role": "..."
  // }
  // =========================================================

  static Future<ApiResponse<bool>> login({
    required String username,
    required String password,
  }) async {
    final response = await ApiClient.post<Map<String, dynamic>>(
      url: '${ApiEndpoints.apiBaseUrl}/sessions',
      requiresAuth: false,
      body: {
        'username': username,
        'password': password,
      },
      parser: _mapParser,
    );

    if (!response.success) {
      return ApiResponse<bool>.failure(
        message: response.message ?? 'Unable to login.',
        statusCode: response.statusCode,
        data: false,
      );
    }

    final sessionID = response.data?['sessionID']?.toString();

    if (sessionID == null || sessionID.isEmpty) {
      return ApiResponse<bool>.failure(
        message: 'Session ID missing from login response.',
        statusCode: response.statusCode,
        data: false,
      );
    }

    final role = response.data?['role']
        ?.toString()
        .trim()
        .toLowerCase() ??
        'user';

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      _sessionIDKey,
      sessionID,
    );

    await prefs.setString(
      _roleKey,
      role,
    );

    await prefs.setString(
      _usernameKey,
      username.trim(),
    );

    return ApiResponse<bool>.success(
      data: true,
      message: response.message,
      statusCode: response.statusCode,
    );
  }

  // =========================================================
  // LOGOUT
  //
  // OLD:
  // UserAPI.logoutUser()
  //
  // DELETE /api/sessions
  //
  // IMPORTANT:
  // Backend does NOT have /api/sessions/logout.
  // =========================================================

  static Future<ApiResponse<bool>> logout() async {
    final prefs = await SharedPreferences.getInstance();

    final sessionID = prefs.getString(_sessionIDKey);

    if (sessionID == null || sessionID.trim().isEmpty) {
      await _clearLocalSession();

      return ApiResponse<bool>.success(
        data: true,
        message: 'Already logged out.',
      );
    }

    final response = await ApiClient.delete<dynamic>(
      url: '${ApiEndpoints.apiBaseUrl}/sessions',
      requiresAuth: true,
    );

    // Same behaviour as OLD UserAPI:
    // Local session is removed even if backend logout fails.
    await _clearLocalSession();

    if (!response.success) {
      return ApiResponse<bool>.failure(
        message: response.message ?? 'Unable to logout from server.',
        statusCode: response.statusCode,
        data: false,
      );
    }

    return ApiResponse<bool>.success(
      data: true,
      message: response.message,
      statusCode: response.statusCode,
    );
  }

  // =========================================================
  // CHECK USERNAME
  //
  // OLD:
  // UserAPI.checkUser(username)
  //
  // GET /api/users/username
  // =========================================================

  static Future<ApiResponse<String>> checkUser({
    required String username,
  }) async {
    final response = await ApiClient.get<dynamic>(
      url: '${ApiEndpoints.users}/username',
      requiresAuth: false,
      headers: {
        'username': username,
      },
    );

    if (!response.success) {
      if (response.statusCode == 400) {
        return ApiResponse<String>.failure(
          message: 'Username already exists',
          statusCode: response.statusCode,
          data: 'Username already exists',
        );
      }

      return ApiResponse<String>.failure(
        message: response.message ?? 'Unable to check username.',
        statusCode: response.statusCode,
      );
    }

    return ApiResponse<String>.success(
      data: response.message ?? 'Username available!',
      message: response.message,
      statusCode: response.statusCode,
    );
  }

  // =========================================================
  // GET USER INFO
  //
  // OLD:
  // UserAPI.getUserInfo()
  //
  // GET /api/users/userinfo
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> getUserInfo() async {
    return ApiClient.get<Map<String, dynamic>>(
      url: '${ApiEndpoints.users}/userinfo',
      requiresAuth: true,
      parser: _mapParser,
    );
  }

  // =========================================================
  // CHECK CURRENT USER ADMIN
  //
  // OLD:
  // UserAPI.isCurrentUserAdmin()
  //
  // First checks locally saved role.
  // If unavailable, fetches user-info.
  //
  // Supports:
  // isAdmin
  // admin
  // role
  // =========================================================

  static Future<bool> isCurrentUserAdmin() async {
    final prefs = await SharedPreferences.getInstance();

    final savedRole = prefs.getString(_roleKey)?.trim().toLowerCase();

    if (savedRole != null) {
      return savedRole == 'admin';
    }

    final response = await getUserInfo();

    if (!response.success || response.data == null) {
      return false;
    }

    final userInfo = response.data!;

    final isAdmin =
        userInfo['isAdmin'] ??
            userInfo['admin'];

    if (isAdmin is bool) {
      return isAdmin;
    }

    if (isAdmin is num) {
      return isAdmin == 1;
    }

    if (isAdmin is String) {
      return isAdmin.toLowerCase() == 'true';
    }

    final role =
    userInfo['role']
        ?.toString()
        .trim()
        .toLowerCase();

    return role == 'admin' ||
        role == 'administrator';
  }

  // =========================================================
  // CLEAR LOCAL SESSION
  // =========================================================

  static Future<void> _clearLocalSession() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_sessionIDKey);
    await prefs.remove(_roleKey);
    await prefs.remove(_usernameKey);
  }

  // =========================================================
  // MAP PARSER
  // =========================================================

  static Map<String, dynamic> _mapParser(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data;
    }

    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }

    return <String, dynamic>{};
  }
}