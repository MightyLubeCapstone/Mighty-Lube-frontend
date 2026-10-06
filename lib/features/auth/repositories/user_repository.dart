import '../../../core/network/api_response.dart';
import '../../../core/network/services/user_api_service.dart';

class UserRepository {
  UserRepository._();

  // =========================================================
  // CHECK SESSION
  // =========================================================

  static Future<ApiResponse<bool>> checkSession() async {
    return UserApiService.checkSession();
  }

  // =========================================================
  // CREATE ACCOUNT
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
    return UserApiService.makeAccount(
      username: username,
      password: password,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
      companyName: companyName,
      securityPin: securityPin,
      country: country,
    );
  }

  // =========================================================
  // UPDATE ACCOUNT
  // =========================================================

  static Future<ApiResponse<bool>> updateAccount({
    required String firstName,
    required String lastName,
    required String username,
    required String companyName,
    required String phoneNumber,
    required String email,
  }) async {
    return UserApiService.updateAccount(
      firstName: firstName,
      lastName: lastName,
      username: username,
      companyName: companyName,
      phoneNumber: phoneNumber,
      email: email,
    );
  }

  // =========================================================
  // REMOVE ACCOUNT
  // =========================================================

  static Future<ApiResponse<bool>> removeAccount({
    required String password,
  }) async {
    return UserApiService.removeAccount(
      password: password,
    );
  }

  // =========================================================
  // FORGOT PASSWORD
  // =========================================================

  static Future<ApiResponse<bool>> forgotPassword({
    required String email,
  }) async {
    return UserApiService.forgotPassword(
      email: email,
    );
  }

  // =========================================================
  // VALIDATE CODE
  // =========================================================

  static Future<ApiResponse<bool>> validateCode({
    required String email,
    required String passcode,
  }) async {
    return UserApiService.validateCode(
      email: email,
      passcode: passcode,
    );
  }

  // =========================================================
  // VALIDATE SECURITY PIN
  // =========================================================

  static Future<ApiResponse<bool>> validateSecurityPin({
    required String email,
    required String securityPin,
  }) async {
    return UserApiService.validateSecurityPin(
      email: email,
      securityPin: securityPin,
    );
  }

  // =========================================================
  // RESET PASSWORD
  // =========================================================

  static Future<ApiResponse<bool>> resetPassword({
    required String email,
    required String password,
  }) async {
    return UserApiService.resetPassword(
      email: email,
      password: password,
    );
  }

  // =========================================================
  // LOGIN
  //
  // rememberAccount = true
  // -> backend creates normal session + 30-day remember token
  // -> account is added/refreshed in the remembered account list
  //
  // rememberAccount = false
  // -> normal session only
  // =========================================================

  static Future<ApiResponse<bool>> login({
    required String username,
    required String password,
    bool rememberAccount = false,
  }) async {
    return UserApiService.login(
      username: username,
      password: password,
      rememberAccount: rememberAccount,
    );
  }

  // =========================================================
  // REMEMBERED ACCOUNTS
  //
  // Maximum 5 remembered accounts are stored locally.
  // Order is oldest -> newest.
  //
  // If a 6th account is remembered:
  // -> oldest account is removed
  // -> its remember token is revoked
  //
  // If an existing account is remembered again:
  // -> no duplicate is created
  // -> it becomes the newest remembered account
  // =========================================================

  static Future<List<Map<String, dynamic>>> getRememberedAccounts() async {
    return UserApiService.getRememberedAccounts();
  }

  static Future<bool> hasRememberedAccount() async {
    return UserApiService.hasRememberedAccount();
  }

  // Kept for compatibility with existing code.
  // Returns the newest remembered username.
  static Future<String?> getRememberedUsername() async {
    return UserApiService.getRememberedUsername();
  }

  // =========================================================
  // CONTINUE WITH REMEMBERED ACCOUNT
  //
  // Uses the selected account's 30-day remember token.
  // Backend generates a NEW normal 12-hour session.
  // No password is required.
  // =========================================================

  static Future<ApiResponse<bool>> continueWithRememberedAccount({
    String? username,
  }) async {
    return UserApiService.continueWithRememberedAccount(
      username: username,
    );
  }

  // =========================================================
  // FORGET REMEMBERED ACCOUNT
  //
  // Revokes only the selected account's remember token
  // and removes only that account from local storage.
  // Other remembered accounts remain unchanged.
  // =========================================================

  static Future<ApiResponse<bool>> forgetRememberedAccount({
    String? username,
  }) async {
    return UserApiService.forgetRememberedAccount(
      username: username,
    );
  }

  // =========================================================
  // LOGOUT
  //
  // Removes the current normal session only.
  // All remembered accounts remain available for "Continue as".
  // =========================================================

  static Future<ApiResponse<bool>> logout() async {
    return UserApiService.logout();
  }

  // =========================================================
  // CHECK USERNAME
  // =========================================================

  static Future<ApiResponse<String>> checkUser({
    required String username,
  }) async {
    return UserApiService.checkUser(
      username: username,
    );
  }

  // =========================================================
  // GET USER INFO
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> getUserInfo() async {
    return UserApiService.getUserInfo();
  }

  // =========================================================
  // CHECK ADMIN
  // =========================================================

  static Future<bool> isCurrentUserAdmin() async {
    return UserApiService.isCurrentUserAdmin();
  }
}