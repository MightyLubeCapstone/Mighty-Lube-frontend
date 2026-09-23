import 'package:flutter/material.dart';
import 'package:mighty_lube/features/auth/repositories/user_repository.dart';
import 'package:mighty_lube/features/auth/screen/enter_security_pin.dart';

import '../../../core/widget/header_logo.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({
    super.key,
  });

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();

  String? _errorEmail;

  bool loading = false;

  Future<bool> forgotPassword(
      String email,
      ) async {
    if (!_validateEmail(
      email,
    )) {
      return false;
    }

    setState(() {
      loading = true;
    });

    final response = await UserRepository.forgotPassword(
      email: email,
    );

    if (!mounted) {
      return false;
    }

    setState(() {
      loading = false;
    });

    if (response.success && response.data == true) {
      return true;
    }

    setState(() {
      _errorEmail = response.message ?? 'Email not found!';
    });

    return false;
  }

  bool _validateEmail(
      String email,
      ) {
    setState(() {
      if (email.isEmpty) {
        _errorEmail = 'Email is Required';
      } else if (!RegExp(r'[^@]+@[^@]+\.[^@]+$').hasMatch(email)) {
        _errorEmail =
        'Email must include an @\nEmail must include a domain(i.e., .com)';
      } else {
        _errorEmail = null;
      }
    });

    return _errorEmail == null;
  }

  @override
  void dispose() {
    emailController.dispose();

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
                          'Forgot Password',
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
                        'Please enter your email. If an account exists, you will be asked for your security PIN.',
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
                        'Email:',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextField(
                        controller: emailController,
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
                          hintText: 'Enter your email address:',
                          errorText: _errorEmail,
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
                                  final success = await forgotPassword(
                                    emailController.text,
                                  );

                                  if (!mounted) {
                                    return;
                                  }

                                  if (success) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EnterSecurityPin(
                                              email: emailController.text,
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