import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mighty_lube/features/auth/repositories/user_repository.dart';
import 'package:mighty_lube/features/auth/screen/login_page.dart';

import '../../../core/widget/header_logo.dart';

class ChangePass extends StatefulWidget {
  final String email;

  final String securityPin;

  // OTP used by the new email-based password recovery flow.
  final String otp;

  const ChangePass({
    super.key,
    required this.email,
    this.securityPin = '',
    this.otp = '',
  });

  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmController = TextEditingController();

  String? _errorPassword;

  String? _errorConfirmPassword;

  bool loading = false;

  // Match CreateAccountPage password rules: 6–50 characters, case-sensitive.
  bool _validatePassword(String password) {
    setState(() {
      if (password.isEmpty) {
        _errorPassword = 'Password is required';
      } else if (password.length < 6) {
        _errorPassword = 'Password must be at least 6 characters';
      } else if (password.length > 50) {
        _errorPassword = 'Password must be at most 50 characters';
      } else {
        _errorPassword = null;
      }
    });
    return _errorPassword == null;
  }

  bool _validateConfirmPassword(
      String password,
      String confirmPassword,
      ) {
    setState(() {
      if (confirmPassword.isEmpty) {
        _errorConfirmPassword = 'Confirm password is required!';
      } else if (password != confirmPassword) {
        _errorConfirmPassword = 'Passwords do not match!';
      } else {
        _errorConfirmPassword = null;
      }
    });

    return _errorConfirmPassword == null;
  }

  Future<bool> resetPassword(
      String password,
      ) async {
    try {
      if (!_validatePassword(
        password,
      ) ||
          !_validateConfirmPassword(
            password,
            confirmController.text,
          )) {
        return false;
      }

      setState(() {
        loading = true;
      });

      // Keep the legacy reset path available for existing callers.
      // The new OTP flow supplies a verified OTP from EnterOTP.
      final result = widget.otp.trim().isNotEmpty
          ? await UserRepository.resetPasswordWithOtp(
        email: widget.email,
        otp: widget.otp.trim(),
        password: password,
      )
          : await UserRepository.resetPassword(
        email: widget.email,
        password: password,
      );

      if (!mounted) {
        return false;
      }

      setState(() {
        loading = false;
      });

      if (!result.success || result.data != true) {
        setState(() {
          _errorPassword = result.message ?? 'Unable to reset password.';
        });

        return false;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Successfully changed password!',
          ),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );

      return true;
    } catch (error) {
      if (kDebugMode) {
        print(
          error,
        );
      }

      if (mounted) {
        setState(() {
          loading = false;
        });
      }

      return false;
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context,) {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: Column(
        children: [
          const HeaderLogo(
            pressable: false,
          ),
          loading == true
              ? const Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
              : Expanded(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(
                  20,
                ),
                margin: EdgeInsets.fromLTRB(
                  20,
                  0,
                  20,
                  keyboardHeight > 0 ? 0 : 100,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: 0.1,
                      ),
                      spreadRadius: 5,
                      blurRadius: 15,
                      offset: const Offset(
                        0,
                        10,
                      ),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Change password',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Enter new password:',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          hintText: 'Enter your new password:',
                          errorText: _errorPassword,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Confirm new password:',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextField(
                        onChanged: (value) => {
                          _validateConfirmPassword(
                            passwordController.text,
                            value,
                          ),
                        },
                        obscureText: true,
                        controller: confirmController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          hintText: 'Confirm your new password:',
                          errorText: _errorConfirmPassword,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Password requirements:',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '• Password must be 6 to 50 characters.',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        '• Password is case-sensitive.',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              margin: const EdgeInsets.only(
                                right: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  12,
                                ),
                                color: Colors.grey[500],
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pop(
                                    context,
                                  );
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 50,
                              margin: const EdgeInsets.only(
                                left: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  12,
                                ),
                                gradient: const LinearGradient(
                                  colors: [
                                    Colors.blueAccent,
                                    Colors.lightBlueAccent,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  resetPassword(
                                    passwordController.text,
                                  );
                                },
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}