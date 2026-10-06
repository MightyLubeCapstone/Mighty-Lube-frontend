import 'dart:convert';

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
  static const String _rememberedAccountsKey = 'rememberedAccounts';
  static const int _maxRememberedAccounts = 5;
  static const String _legacyRememberTokenKey = 'rememberToken';
  static const String _legacyRememberTokenExpiresAtKey = 'rememberTokenExpiresAt';

  // =========================================================
  // CHECK SESSION
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

    return _failureFrom<bool>(
      response,
      fallbackMessage: 'Session is invalid or expired.',
      data: false,
    );
  }

  // =========================================================
  // CREATE ACCOUNT
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
    final normalizedUsername = username.trim().toLowerCase();
    final normalizedEmail = email.trim().toLowerCase();

    final response = await ApiClient.post<Map<String, dynamic>>(
      url: ApiEndpoints.users,
      requiresAuth: false,
      body: {
        'username': normalizedUsername,
        'password': password,
        'firstName': firstName.trim(),
        'lastName': lastName.trim(),
        'emailAddress': normalizedEmail,
        'phoneNumber': phoneNumber.trim(),
        'companyName': companyName.trim(),
        'securityPin': securityPin.trim(),
        'country': country.trim(),
      },
      parser: _mapParser,
    );

    if (!response.success) {
      return _failureFrom<bool>(
        response,
        fallbackMessage: 'Unable to create account.',
        data: false,
      );
    }

    final sessionID = response.data?['sessionID']?.toString();

    if (sessionID != null && sessionID.trim().isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString(
        _sessionIDKey,
        sessionID.trim(),
      );

      await prefs.setString(
        _usernameKey,
        normalizedUsername,
      );

      final role = response.data?['role']
          ?.toString()
          .trim()
          .toLowerCase();

      if (role != null && role.isNotEmpty) {
        await prefs.setString(
          _roleKey,
          role,
        );
      }
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
    final normalizedUsername = username.trim().toLowerCase();
    final normalizedEmail = email.trim().toLowerCase();

    final response = await ApiClient.put<dynamic>(
      url: ApiEndpoints.users,
      requiresAuth: true,
      body: {
        'firstName': firstName.trim(),
        'lastName': lastName.trim(),
        'username': normalizedUsername,
        'companyName': companyName.trim(),
        'phoneNumber': phoneNumber.trim(),
        'email': normalizedEmail,
      },
    );

    if (!response.success) {
      return _failureFrom<bool>(
        response,
        fallbackMessage: 'Unable to update account.',
        data: false,
      );
    }

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      _usernameKey,
      normalizedUsername,
    );

    return ApiResponse<bool>.success(
      data: true,
      message: response.message,
      statusCode: response.statusCode,
    );
  }

  // =========================================================
  // REMOVE ACCOUNT
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
      return _failureFrom<bool>(
        response,
        fallbackMessage: 'Unable to remove account.',
        data: false,
      );
    }

    await _clearLocalSession();

    return ApiResponse<bool>.success(
      data: true,
      message: response.message,
      statusCode: response.statusCode,
    );
  }

  // =========================================================
  // FORGOT PASSWORD
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
        'email': email.trim().toLowerCase(),
      },
    );

    if (!response.success) {
      return _failureFrom<bool>(
        response,
        fallbackMessage: 'Unable to process forgot password.',
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
  // GET /api/email/forgot
  // =========================================================

  static Future<ApiResponse<bool>> validateCode({
    required String email,
    required String passcode,
  }) async {
    final response = await ApiClient.get<dynamic>(
      url: '${ApiEndpoints.apiBaseUrl}/email/forgot',
      requiresAuth: false,
      headers: {
        'email': email.trim().toLowerCase(),
        'passcode': passcode.trim(),
      },
    );

    if (!response.success) {
      return _failureFrom<bool>(
        response,
        fallbackMessage: 'Invalid verification code.',
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
        'email': email.trim().toLowerCase(),
        'securityPin': securityPin.trim(),
      },
    );

    if (!response.success) {
      return _failureFrom<bool>(
        response,
        fallbackMessage: 'Invalid security PIN.',
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
        'email': email.trim().toLowerCase(),
        'password': password,
      },
    );

    if (!response.success) {
      return _failureFrom<bool>(
        response,
        fallbackMessage: 'Unable to reset password.',
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
  // POST /api/sessions
  // =========================================================

  static Future<ApiResponse<bool>> login({
    required String username,
    required String password,
    bool rememberAccount = false,
  }) async {
    final normalizedUsername = username.trim().toLowerCase();

    final response = await ApiClient.post<Map<String, dynamic>>(
      url: '${ApiEndpoints.apiBaseUrl}/sessions',
      requiresAuth: false,
      body: {
        'username': normalizedUsername,
        'password': password,
        'rememberAccount': rememberAccount,
      },
      parser: _mapParser,
    );

    if (!response.success) {
      return _failureFrom<bool>(
        response,
        fallbackMessage: 'Unable to login.',
        data: false,
      );
    }

    final sessionID = response.data?['sessionID']?.toString();

    if (sessionID == null || sessionID.trim().isEmpty) {
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
      sessionID.trim(),
    );

    await prefs.setString(
      _roleKey,
      role,
    );

    await prefs.setString(
      _usernameKey,
      normalizedUsername,
    );

    final rememberToken = response.data?['rememberToken']?.toString().trim();
    final rememberTokenExpiresAt =
    response.data?['rememberTokenExpiresAt']?.toString().trim();

    if (rememberAccount && rememberToken != null && rememberToken.isNotEmpty) {
      await _saveRememberedAccount(
        username: normalizedUsername,
        role: role,
        rememberToken: rememberToken,
        expiresAt: rememberTokenExpiresAt,
      );
    }

    return ApiResponse<bool>.success(
      data: true,
      message: response.message,
      statusCode: response.statusCode,
    );
  }

  // =========================================================
  // REMEMBERED ACCOUNTS
  // =========================================================

  static Future<List<Map<String, dynamic>>> getRememberedAccounts() async {
    final prefs = await SharedPreferences.getInstance();
    await _migrateLegacyRememberedAccountIfNeeded(prefs);
    final accounts = _readRememberedAccounts(prefs);
    final now = DateTime.now();
    final valid = <Map<String, dynamic>>[];

    for (final account in accounts) {
      final username = account['username']?.toString().trim().toLowerCase() ?? '';
      final token = account['rememberToken']?.toString().trim() ?? '';
      final expiresAt = DateTime.tryParse(account['expiresAt']?.toString() ?? '');
      if (username.isNotEmpty && token.isNotEmpty && expiresAt != null && expiresAt.isAfter(now)) {
        valid.add(account);
      }
    }

    if (valid.length != accounts.length) {
      await _writeRememberedAccounts(prefs, valid);
    }
    return valid;
  }

  static Future<bool> hasRememberedAccount() async =>
      (await getRememberedAccounts()).isNotEmpty;

  static Future<String?> getRememberedUsername() async {
    final accounts = await getRememberedAccounts();
    return accounts.isEmpty ? null : accounts.last['username']?.toString();
  }

  static Future<ApiResponse<bool>> continueWithRememberedAccount({String? username}) async {
    final accounts = await getRememberedAccounts();
    final wanted = username?.trim().toLowerCase();
    Map<String, dynamic>? account;

    if (wanted != null && wanted.isNotEmpty) {
      for (final item in accounts) {
        if (item['username']?.toString().trim().toLowerCase() == wanted) {
          account = item;
          break;
        }
      }
    } else if (accounts.isNotEmpty) {
      account = accounts.last;
    }

    if (account == null) {
      return ApiResponse<bool>.failure(message: 'No remembered account found.', data: false);
    }

    final selectedUsername = account['username'].toString().trim().toLowerCase();
    final token = account['rememberToken'].toString().trim();
    final response = await ApiClient.post<Map<String, dynamic>>(
      url: '${ApiEndpoints.apiBaseUrl}/sessions/remember',
      requiresAuth: false,
      body: {'username': selectedUsername, 'rememberToken': token},
      parser: _mapParser,
    );

    if (!response.success) {
      if (response.statusCode == 401) await _removeRememberedAccountLocally(selectedUsername);
      return _failureFrom<bool>(response, fallbackMessage: 'Unable to continue with remembered account.', data: false);
    }

    final sessionID = response.data?['sessionID']?.toString().trim();
    if (sessionID == null || sessionID.isEmpty) {
      return ApiResponse<bool>.failure(message: 'Session ID missing from remembered login response.', statusCode: response.statusCode, data: false);
    }

    final role = response.data?['role']?.toString().trim().toLowerCase() ??
        account['role']?.toString().trim().toLowerCase() ?? 'user';
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sessionIDKey, sessionID);
    await prefs.setString(_roleKey, role);
    await prefs.setString(_usernameKey, selectedUsername);
    return ApiResponse<bool>.success(data: true, message: response.message, statusCode: response.statusCode);
  }

  static Future<ApiResponse<bool>> forgetRememberedAccount({String? username}) async {
    final accounts = await getRememberedAccounts();
    final wanted = username?.trim().toLowerCase();
    Map<String, dynamic>? account;
    if (wanted != null && wanted.isNotEmpty) {
      for (final item in accounts) {
        if (item['username']?.toString().trim().toLowerCase() == wanted) { account = item; break; }
      }
    } else if (accounts.isNotEmpty) {
      account = accounts.last;
    }
    if (account == null) return ApiResponse<bool>.success(data: true, message: 'Remembered account removed.');

    final selectedUsername = account['username'].toString().trim().toLowerCase();
    final token = account['rememberToken'].toString().trim();
    final response = await _revokeRememberToken(username: selectedUsername, rememberToken: token);
    if (!response.success) return _failureFrom<bool>(response, fallbackMessage: 'Unable to forget remembered account.', data: false);
    await _removeRememberedAccountLocally(selectedUsername);
    return ApiResponse<bool>.success(data: true, message: response.message ?? 'Remembered account removed.', statusCode: response.statusCode);
  }

  // =========================================================
  // LOGOUT
  //
  // DELETE /api/sessions
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

    await _clearLocalSession();

    if (!response.success) {
      return _failureFrom<bool>(
        response,
        fallbackMessage: 'Unable to logout from server.',
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
  // GET /api/users/username
  // =========================================================

  static Future<ApiResponse<String>> checkUser({
    required String username,
  }) async {
    final normalizedUsername = username.trim().toLowerCase();

    final response = await ApiClient.get<dynamic>(
      url: '${ApiEndpoints.users}/username',
      requiresAuth: false,
      headers: {
        'username': normalizedUsername,
      },
    );

    if (!response.success) {
      if (response.statusCode == 400) {
        return ApiResponse<String>.failure(
          message: response.message ?? 'Username already exists',
          statusCode: response.statusCode,
          data: 'Username already exists',
          fieldErrors: response.fieldErrors,
          missingFields: response.missingFields,
          errorCode: response.errorCode,
        );
      }

      return ApiResponse<String>.failure(
        message: response.message ?? 'Unable to check username.',
        statusCode: response.statusCode,
        fieldErrors: response.fieldErrors,
        missingFields: response.missingFields,
        errorCode: response.errorCode,
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

    final isAdmin = userInfo['isAdmin'] ?? userInfo['admin'];

    if (isAdmin is bool) {
      return isAdmin;
    }

    if (isAdmin is num) {
      return isAdmin == 1;
    }

    if (isAdmin is String) {
      return isAdmin.toLowerCase() == 'true';
    }

    final role = userInfo['role']
        ?.toString()
        .trim()
        .toLowerCase();

    return role == 'admin' || role == 'administrator';
  }

  // =========================================================
  // COPY NETWORK FAILURE
  //
  // Keeps structured backend validation information while
  // converting ApiResponse<dynamic> / ApiResponse<Map> into
  // the response type expected by this service.
  // =========================================================

  static ApiResponse<T> _failureFrom<T>(
      ApiResponse<dynamic> response, {
        required String fallbackMessage,
        T? data,
      }) {
    return ApiResponse<T>.failure(
      message: response.message ?? fallbackMessage,
      statusCode: response.statusCode,
      data: data,
      fieldErrors: response.fieldErrors,
      missingFields: response.missingFields,
      errorCode: response.errorCode,
    );
  }

  // =========================================================
  // LOCAL SESSION / REMEMBERED ACCOUNT STORAGE
  // =========================================================

  static Future<void> _clearLocalSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sessionIDKey);
    await prefs.remove(_roleKey);
    await prefs.remove(_usernameKey);
  }

  static List<Map<String, dynamic>> _readRememberedAccounts(SharedPreferences prefs) {
    final raw = prefs.getString(_rememberedAccountsKey);
    if (raw == null || raw.trim().isEmpty) return <Map<String, dynamic>>[];
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) return <Map<String, dynamic>>[];
      return decoded.whereType<Map>().map((e) => Map<String, dynamic>.from(e)).toList();
    } catch (_) {
      return <Map<String, dynamic>>[];
    }
  }

  static Future<void> _writeRememberedAccounts(SharedPreferences prefs, List<Map<String, dynamic>> accounts) async {
    if (accounts.isEmpty) {
      await prefs.remove(_rememberedAccountsKey);
    } else {
      await prefs.setString(_rememberedAccountsKey, jsonEncode(accounts));
    }
  }

  static Future<void> _saveRememberedAccount({required String username, required String role, required String rememberToken, String? expiresAt}) async {
    final prefs = await SharedPreferences.getInstance();
    await _migrateLegacyRememberedAccountIfNeeded(prefs);
    final u = username.trim().toLowerCase();
    final token = rememberToken.trim();
    final accounts = _readRememberedAccounts(prefs);

    final old = accounts.where((a) => a['username']?.toString().trim().toLowerCase() == u).toList();
    for (final item in old) {
      final oldToken = item['rememberToken']?.toString().trim() ?? '';
      if (oldToken.isNotEmpty && oldToken != token) await _revokeRememberToken(username: u, rememberToken: oldToken);
    }
    accounts.removeWhere((a) => a['username']?.toString().trim().toLowerCase() == u);
    accounts.add({'username': u, 'role': role.trim().toLowerCase(), 'rememberToken': token, 'expiresAt': expiresAt?.trim() ?? ''});

    while (accounts.length > _maxRememberedAccounts) {
      final oldest = accounts.removeAt(0);
      final ou = oldest['username']?.toString().trim().toLowerCase() ?? '';
      final ot = oldest['rememberToken']?.toString().trim() ?? '';
      if (ou.isNotEmpty && ot.isNotEmpty) await _revokeRememberToken(username: ou, rememberToken: ot);
    }
    await _writeRememberedAccounts(prefs, accounts);
  }

  static Future<void> _removeRememberedAccountLocally(String username) async {
    final prefs = await SharedPreferences.getInstance();
    final u = username.trim().toLowerCase();
    final accounts = _readRememberedAccounts(prefs)..removeWhere((a) => a['username']?.toString().trim().toLowerCase() == u);
    await _writeRememberedAccounts(prefs, accounts);
  }

  static Future<ApiResponse<dynamic>> _revokeRememberToken({required String username, required String rememberToken}) {
    return ApiClient.delete<dynamic>(
      url: '${ApiEndpoints.apiBaseUrl}/sessions/remember',
      requiresAuth: false,
      body: {'username': username.trim().toLowerCase(), 'rememberToken': rememberToken.trim()},
    );
  }

  static Future<void> _migrateLegacyRememberedAccountIfNeeded(SharedPreferences prefs) async {
    final current = _readRememberedAccounts(prefs);
    if (current.isNotEmpty) {
      await prefs.remove(_legacyRememberTokenKey);
      await prefs.remove(_legacyRememberTokenExpiresAtKey);
      return;
    }
    final username = prefs.getString(_usernameKey)?.trim().toLowerCase();
    final token = prefs.getString(_legacyRememberTokenKey)?.trim();
    final expiry = prefs.getString(_legacyRememberTokenExpiresAtKey)?.trim();
    if (username != null && username.isNotEmpty && token != null && token.isNotEmpty) {
      await _writeRememberedAccounts(prefs, [{'username': username, 'role': prefs.getString(_roleKey)?.trim().toLowerCase() ?? 'user', 'rememberToken': token, 'expiresAt': expiry ?? ''}]);
    }
    await prefs.remove(_legacyRememberTokenKey);
    await prefs.remove(_legacyRememberTokenExpiresAtKey);
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
