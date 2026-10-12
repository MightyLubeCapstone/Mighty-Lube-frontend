import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mighty_lube/features/auth/repositories/user_repository.dart';
import 'package:mighty_lube/features/auth/screen/change_pass.dart';

import '../../../core/widget/header_logo.dart';

class EnterOTP extends StatefulWidget {
  final String email;

  const EnterOTP({
    super.key,
    required this.email,
  });

  @override
  State<EnterOTP> createState() => _EnterOtpState();
}

class _EnterOtpState extends State<EnterOTP> {
  final TextEditingController codeController = TextEditingController();

  String? _errorCode;
  bool loading = false;
  bool _resending = false;
  int _resendSeconds = 60;
  Timer? _resendTimer;

  @override
  void initState() {
    super.initState();
    _startResendCooldown();
  }

  void _startResendCooldown() {
    _resendTimer?.cancel();
    _resendSeconds = 60;
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_resendSeconds <= 1) {
        timer.cancel();
        setState(() => _resendSeconds = 0);
      } else {
        setState(() => _resendSeconds--);
      }
    });
  }

  bool _validateCode(String code) {
    setState(() {
      if (code.isEmpty) {
        _errorCode = 'Code is required!';
      } else if (!RegExp(r'^\d{6}$').hasMatch(code)) {
        _errorCode = 'Code must be exactly 6 numbers!';
      } else {
        _errorCode = null;
      }
    });
    return _errorCode == null;
  }

  Future<bool> validatePasscode(String passCode) async {
    if (!_validateCode(passCode)) return false;

    setState(() {
      loading = true;
      _errorCode = null;
    });

    try {
      final response = await UserRepository.verifyPasswordResetOtp(
        email: widget.email,
        otp: passCode,
      );

      if (!mounted) return false;
      final success = response.success && response.data == true;
      setState(() {
        loading = false;
        if (!success) {
          _errorCode = response.message ?? 'Invalid or expired OTP. Please try again.';
        }
      });
      return success;
    } catch (error) {
      if (kDebugMode) debugPrint('OTP verification failed: $error');
      if (mounted) {
        setState(() {
          loading = false;
          _errorCode = 'Unable to verify OTP right now. Please try again.';
        });
      }
      return false;
    }
  }

  Future<void> _resendOtp() async {
    if (_resending || loading || _resendSeconds > 0) return;

    setState(() => _resending = true);
    try {
      final response = await UserRepository.requestPasswordResetOtp(
        email: widget.email,
      );
      if (!mounted) return;
      if (response.success && response.data == true) {
        codeController.clear();
        setState(() => _errorCode = null);
        _startResendCooldown();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('If an account exists with this email, a new OTP has been sent.'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message ?? 'Unable to resend OTP. Please try again.')),
        );
      }
    } catch (error) {
      if (kDebugMode) debugPrint('OTP resend failed: $error');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to resend OTP right now. Please try again.')),
        );
      }
    } finally {
      if (mounted) setState(() => _resending = false);
    }
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: Column(
        children: [
          const HeaderLogo(pressable: false),
          loading
              ? const Expanded(
            child: Center(child: CircularProgressIndicator()),
          )
              : Expanded(
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'One-time Passcode',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Enter the 6-digit verification code sent to your email below.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Text(
                          widget.email,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'One-time passcode:',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: codeController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(6),
                        ],
                        onChanged: (_) {
                          if (_errorCode != null) {
                            setState(() => _errorCode = null);
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                          filled: true,
                          fillColor: Colors.grey[100],
                          hintText: 'Enter your one-time passcode:',
                          errorText: _errorCode,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Text(
                              'OTP expires in 10 minutes',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ),
                          TextButton(
                            onPressed: (_resendSeconds == 0 && !_resending && !loading)
                                ? _resendOtp
                                : null,
                            child: Text(
                              _resending
                                  ? 'Sending...'
                                  : _resendSeconds > 0
                                  ? 'Resend (${_resendSeconds}s)'
                                  : 'Resend OTP',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey[500],
                              ),
                              child: TextButton(
                                onPressed: () => Navigator.pop(context),
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
                              margin: const EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: const LinearGradient(
                                  colors: [Colors.blueAccent, Colors.lightBlueAccent],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: TextButton(
                                onPressed: () async {
                                  final otp = codeController.text.trim();
                                  final success = await validatePasscode(otp);
                                  if (!mounted) return;
                                  if (success) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChangePass(
                                          email: widget.email,
                                          otp: otp,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: const Text(
                                  'Verify OTP',
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
