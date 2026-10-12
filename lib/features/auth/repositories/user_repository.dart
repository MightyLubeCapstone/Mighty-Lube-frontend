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
    required String country,
    String? verificationToken,
  }) async {
    return UserApiService.makeAccount(
      username: username,
      password: password,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
      companyName: companyName,
      country: country,
      verificationToken: verificationToken,
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
// EMAIL VERIFICATION
// =========================================================

  static Future<ApiResponse<bool>> requestEmailVerificationOtp({
    required String email,
    required String purpose,
  }) async {
    return UserApiService.requestEmailVerificationOtp(
      email: email,
      purpose: purpose,
    );
  }

  static Future<ApiResponse<String?>> verifyEmailVerificationOtp({
    required String email,
    required String otp,
    required String purpose,
  }) async {
    return UserApiService.verifyEmailVerificationOtp(
      email: email,
      otp: otp,
      purpose: purpose,
    );
  }

  // =========================================================
  // FORGOT PASSWORD (LEGACY)
  // =========================================================

  static Future<ApiResponse<bool>> forgotPassword({
    required String email,
  }) async {
    return UserApiService.forgotPassword(
      email: email,
    );
  }

  // =========================================================
  // VALIDATE CODE (LEGACY)
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
  // VALIDATE SECURITY PIN (LEGACY)
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
  // RESET PASSWORD (LEGACY)
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
  // EMAIL OTP PASSWORD RECOVERY
  // =========================================================

  // POST /api/email/forgot/request-otp
  static Future<ApiResponse<bool>> requestPasswordResetOtp({
    required String email,
  }) async {
    return UserApiService.requestPasswordResetOtp(
      email: email,
    );
  }

  // POST /api/email/forgot/verify-otp
  static Future<ApiResponse<bool>> verifyPasswordResetOtp({
    required String email,
    required String otp,
  }) async {
    return UserApiService.verifyPasswordResetOtp(
      email: email,
      otp: otp,
    );
  }

  // POST /api/email/forgot/reset-password
  static Future<ApiResponse<bool>> resetPasswordWithOtp({
    required String email,
    required String otp,
    required String password,
  }) async {
    return UserApiService.resetPasswordWithOtp(
      email: email,
      otp: otp,
      password: password,
    );
  }

  // =========================================================
  // FORGOT USERNAME (NEW)
  //
  // Sends the existing username to the registered email.
  // No OTP or username reset is required.
  //
  // POST /api/email/forgot-username
  // =========================================================

  static Future<ApiResponse<bool>> requestForgotUsername({
    required String email,
  }) async {
    return UserApiService.requestForgotUsername(
      email: email.trim().toLowerCase(),
    );
  }

  // =========================================================
  // LOGIN
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