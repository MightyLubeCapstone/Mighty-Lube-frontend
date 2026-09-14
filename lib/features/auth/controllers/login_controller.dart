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

  static Future<LoginResult> login({
    required String username,
    required String password,
  }) async {
    try {
      final loginResponse = await UserRepository.login(
        username: username,
        password: password,
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

      final isAdmin = await UserRepository.isCurrentUserAdmin();

      return LoginResult(
        success: true,
        isAdmin: isAdmin,
      );
    } catch (error) {
      return const LoginResult(
        success: false,
        message: 'Failed to login',
      );
    }
  }
}