import '../repositories/user_repository.dart';

class LoginResult {
  final bool success;
  final bool isAdmin;
  final String? message;

  const LoginResult({
    required this.success,
    this.isAdmin = false,
    this.message,
  });
}

class LoginController {
  LoginController._();

  // =========================================================
  // NORMAL USERNAME + PASSWORD LOGIN
  //
  // rememberAccount = true
  // -> normal 12-hour session
  // -> 30-day remembered login token
  // -> account is added/refreshed in remembered accounts
  //
  // rememberAccount = false
  // -> normal 12-hour session only
  // =========================================================

  static Future<LoginResult> login({
    required String username,
    required String password,
    bool rememberAccount = false,
  }) async {
    try {
      final loginResponse = await UserRepository.login(
        username: username,
        password: password,
        rememberAccount: rememberAccount,
      );

      final loginSuccess =
          loginResponse.success &&
              loginResponse.data == true;

      if (!loginSuccess) {
        return LoginResult(
          success: false,
          message:
          loginResponse.message ??
              'Incorrect username or password',
        );
      }

      final isAdmin =
      await UserRepository.isCurrentUserAdmin();

      return LoginResult(
        success: true,
        isAdmin: isAdmin,
      );
    } catch (_) {
      return const LoginResult(
        success: false,
        message: 'Failed to login',
      );
    }
  }

  // =========================================================
  // GET REMEMBERED ACCOUNTS
  //
  // Returns all remembered accounts stored on this device.
  //
  // Maximum accounts = 5.
  // Order = oldest -> newest.
  //
  // Passwords are never stored.
  // =========================================================

  static Future<List<Map<String, dynamic>>>
  getRememberedAccounts() async {
    try {
      return await UserRepository.getRememberedAccounts();
    } catch (_) {
      return <Map<String, dynamic>>[];
    }
  }

  // =========================================================
  // CHECK IF ANY REMEMBERED ACCOUNT EXISTS
  // =========================================================

  static Future<bool> hasRememberedAccount() async {
    try {
      return await UserRepository.hasRememberedAccount();
    } catch (_) {
      return false;
    }
  }

  // =========================================================
  // GET REMEMBERED USERNAME
  //
  // Kept for compatibility with existing code.
  // Returns the newest remembered username.
  // =========================================================

  static Future<String?> getRememberedUsername() async {
    try {
      return await UserRepository.getRememberedUsername();
    } catch (_) {
      return null;
    }
  }

  // =========================================================
  // CONTINUE WITH SELECTED REMEMBERED ACCOUNT
  //
  // User selects one of the remembered accounts.
  //
  // No password entry required.
  //
  // Uses that account's 30-day remember token.
  // Backend validates it and generates a NEW
  // normal 12-hour session.
  // =========================================================

  static Future<LoginResult> continueWithRememberedAccount({
    required String username,
  }) async {
    try {
      final response =
      await UserRepository.continueWithRememberedAccount(
        username: username,
      );

      final success =
          response.success &&
              response.data == true;

      if (!success) {
        return LoginResult(
          success: false,
          message:
          response.message ??
              'Remembered login is no longer available.',
        );
      }

      final isAdmin =
      await UserRepository.isCurrentUserAdmin();

      return LoginResult(
        success: true,
        isAdmin: isAdmin,
      );
    } catch (_) {
      return const LoginResult(
        success: false,
        message:
        'Unable to continue with remembered account.',
      );
    }
  }

  // =========================================================
  // FORGET SELECTED REMEMBERED ACCOUNT
  //
  // Removes/revokes ONLY the selected remembered account.
  //
  // Other remembered accounts remain available.
  // Does NOT delete the actual user account.
  // =========================================================

  static Future<bool> forgetRememberedAccount({
    required String username,
  }) async {
    try {
      final response =
      await UserRepository.forgetRememberedAccount(
        username: username,
      );

      return response.success &&
          response.data == true;
    } catch (_) {
      return false;
    }
  }
}