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
  // =========================================================

  static Future<ApiResponse<bool>> login({
    required String username,
    required String password,
  }) async {
    return UserApiService.login(
      username: username,
      password: password,
    );
  }

  // =========================================================
  // LOGOUT
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