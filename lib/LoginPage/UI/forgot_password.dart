import 'package:flutter/material.dart';
import 'package:mighty_lube/api.dart';
import 'package:mighty_lube/header_logo.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  // variables
  final TextEditingController emailController = TextEditingController();
  String? _errorEmail;

  Future<bool> forgotPassword(String email) async {
    if (!_validateEmail(email)) {
      return false;
    }
    bool status = await UserAPI().forgotPassword(email);
    if (status == true) {
      // render OTP page
      return true;
    }
    setState(() {
      _errorEmail = "Email not found!";
    });
    return false;
  }

  bool _validateEmail(String email) {
    setState(() {
      if (email.isEmpty) {
        _errorEmail = 'Email is Required';
      } else if (!RegExp(r'[^@]+@[^@]+\.[^@]+$').hasMatch(email)) {
        _errorEmail = 'Email must include an @\nEmail must include a domain(i.e., .com)';
      } else {
        _errorEmail = null;
      }
    });
    return _errorEmail == null;
  }

  @override
  Widget build(BuildContext context) {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: Column(
        children: [
          const HeaderLogo(pressable: false), // Add the logo header here
          Expanded(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: EdgeInsets.fromLTRB(20, 0, 20, keyboardHeight > 0 ? 0 : 100),
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
                          'Forgot Password',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Please enter your email. We will send you an email to reset your password if an account exists.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Email:',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                          filled: true,
                          fillColor: Colors.grey[100],
                          hintText: 'Enter your email address:',
                          errorText: _errorEmail,
                        ),
                      ),
                      const SizedBox(height: 20),
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
                                onPressed: () {
                                  Navigator.pop(context); // Cancel button
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
                                onPressed: () {
                                  // Add functionality for the submit button
                                  forgotPassword(emailController.text).then((success) => {
                                        if (success == true)
                                          {
                                            // render OTP page
                                            // ignore: use_build_context_synchronously
                                            Navigator.of(context)
                                                .pushReplacementNamed("/enter_otp"),
                                          }
                                      });
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
