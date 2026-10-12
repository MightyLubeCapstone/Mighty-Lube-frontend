import 'package:flutter/material.dart';
import 'package:mighty_lube/features/auth/repositories/user_repository.dart';
import 'package:mighty_lube/features/auth/screen/enter_otp.dart';

import '../../../core/widget/header_logo.dart';

enum AccountRecoveryMode {
  password,
  username,
}

class ForgotPasswordPage extends StatefulWidget {
  final AccountRecoveryMode mode;

  const ForgotPasswordPage({
    super.key,
    this.mode = AccountRecoveryMode.password,
  });

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();

  String? _errorEmail;
  bool loading = false;
  bool usernameRequestSubmitted = false;

  bool get isUsernameMode =>
      widget.mode == AccountRecoveryMode.username;

  bool _validateEmail(String email) {
    setState(() {
      if (email.isEmpty) {
        _errorEmail = 'Email is Required';
      } else if (!RegExp(
        r'^[^\s@]+@[^\s@]+\.[^\s@]+$',
      ).hasMatch(email)) {
        _errorEmail = 'Please enter a valid email address.';
      } else {
        _errorEmail = null;
      }
    });

    return _errorEmail == null;
  }

  Future<void> _submit() async {
    if (loading || usernameRequestSubmitted) return;

    final email = emailController.text.trim().toLowerCase();

    if (!_validateEmail(email)) return;

    setState(() {
      loading = true;
      _errorEmail = null;
    });

    try {
      if (isUsernameMode) {
        // =====================================================
        // FORGOT USERNAME
        //
        // POST /api/email/forgot-username
        // =====================================================

        final response = await UserRepository.requestForgotUsername(
          email: email,
        );

        if (!mounted) return;

        if (response.success && response.data == true) {
          setState(() {
            usernameRequestSubmitted = true;
          });

          return;
        }

        setState(() {
          _errorEmail = response.message ??
              'Unable to send username. Please try again.';
        });

        return;
      }

      // =====================================================
      // FORGOT PASSWORD
      //
      // POST /api/email/forgot/request-otp
      // =====================================================

      final response = await UserRepository.requestPasswordResetOtp(
        email: email,
      );

      if (!mounted) return;

      if (response.success && response.data == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EnterOTP(
              email: email,
            ),
          ),
        );

        return;
      }

      setState(() {
        _errorEmail =
            response.message ?? 'Unable to send OTP. Please try again.';
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _errorEmail = isUsernameMode
            ? 'Unable to send username. Please try again.'
            : 'Unable to send OTP. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    final title = isUsernameMode
        ? 'Forgot Username'
        : 'Forgot Password';

    final description = isUsernameMode
        ? 'Enter your registered email address. '
        'If an account exists, your username will be sent to your email.'
        : 'Please enter your email. If an account exists, '
        'a one-time verification code will be sent to your email.';

    final buttonText = isUsernameMode
        ? 'Send Username'
        : 'Send OTP';

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: Column(
        children: [
          const HeaderLogo(
            pressable: false,
          ),
          Expanded(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: EdgeInsets.fromLTRB(
                  20,
                  0,
                  20,
                  keyboardHeight > 0 ? 0 : 100,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      spreadRadius: 5,
                      blurRadius: 15,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: usernameRequestSubmitted
                      ? _buildUsernameSuccess()
                      : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Email:',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: emailController,
                        enabled: !loading,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => _submit(),
                        onChanged: (_) {
                          if (_errorEmail != null) {
                            setState(() {
                              _errorEmail = null;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding:
                          const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          hintText: 'Enter your email address',
                          errorText: _errorEmail,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              margin: const EdgeInsets.only(
                                right: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(12),
                                color: Colors.grey[500],
                              ),
                              child: TextButton(
                                onPressed: loading
                                    ? null
                                    : () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontSize: 12,
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
                                borderRadius:
                                BorderRadius.circular(12),
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
                                onPressed: loading ? null : _submit,
                                child: loading
                                    ? const SizedBox(
                                  height: 22,
                                  width: 22,
                                  child:
                                  CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor:
                                    AlwaysStoppedAnimation<
                                        Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                                    : Text(
                                  buttonText,
                                  style: const TextStyle(
                                    fontSize: 12,
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

  Widget _buildUsernameSuccess() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.mark_email_read_outlined,
          color: Colors.green,
          size: 64,
        ),
        const SizedBox(height: 16),
        const Text(
          'Check Your Email',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'If an account exists with this email address, '
              'your username will be sent to your inbox.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Back to Login',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}