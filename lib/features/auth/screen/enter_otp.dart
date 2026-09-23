import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

  bool _validateCode(
      String code,
      ) {
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

  Future<bool> validatePasscode(
      String passCode,
      ) async {
    try {
      if (!_validateCode(
        passCode,
      )) {
        return false;
      }

      setState(() {
        loading = true;
      });

      final response = await UserRepository.validateCode(
        email: widget.email,
        passcode: passCode,
      );

      if (!mounted) {
        return false;
      }

      setState(() {
        loading = false;
      });

      return response.success && response.data == true;
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
    codeController.dispose();

    super.dispose();
  }

  @override
  Widget build(
      BuildContext context,
      ) {
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
                          'One-time Passcode',
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
                      const Text(
                        'Enter your passcode received via email below',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'One-time passcode:',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextField(
                        controller: codeController,
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
                          hintText: 'Enter your one-time passcode:',
                          errorText: _errorCode,
                        ),
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
                                onPressed: () async {
                                  final success = await validatePasscode(
                                    codeController.text,
                                  );

                                  if (!mounted) {
                                    return;
                                  }

                                  if (success) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChangePass(
                                          email: widget.email,
                                        ),
                                      ),
                                    );
                                  }
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