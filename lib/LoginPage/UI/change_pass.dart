import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mighty_lube/LoginPage/UI/login_page.dart';
import 'package:mighty_lube/api.dart';
import 'package:mighty_lube/header_logo.dart';

class PWDRequirements {
  final String name;
  final bool Function(String) check;

  PWDRequirements(this.name, this.check);
}

class ChangePass extends StatefulWidget {
  final String email;
  const ChangePass({super.key, required this.email});

  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  String? _errorPassword;

  bool loading = false;

  List<PWDRequirements> requirements = [
    PWDRequirements('Password must be at least 8 characters', (input) => input.length >= 8),
    PWDRequirements('Password must contain at least one uppercase letter',
        (input) => RegExp(r'[A-Z]').hasMatch(input)),
    PWDRequirements('Password must contain at least one lowercase letter',
        (input) => RegExp(r'[a-z]').hasMatch(input)),
    PWDRequirements(
        'Password must contain at least one number', (input) => RegExp(r'[0-9]').hasMatch(input)),
    PWDRequirements('Password must contain at least one special character',
        (input) => RegExp(r'[!@#$%^&*(),.?":{}|<>-]').hasMatch(input)),
  ];
  List<PWDRequirements> _remains = [];

  bool _validatePassword(String password) {
    setState(() {
      _remains = requirements.where((req) => !req.check(password)).toList();
      if (password.isEmpty) {
        _errorPassword = 'Password is required!';
      } else if (RegExp(r'.{8,}').hasMatch(password) == false) {
        _errorPassword = 'Password must be at least 8 characters';
      } else if (RegExp(r'[A-Z]').hasMatch(password) == false) {
        _errorPassword = 'Password must contain at least one uppercase letter';
      } else if (RegExp(r'[a-z]').hasMatch(password) == false) {
        _errorPassword = 'Password must contain at least one lowercase letter';
      } else if (RegExp(r'[0-9]').hasMatch(password) == false) {
        _errorPassword = 'Password must contain at least one number';
      } else if (RegExp(r'[!@#$%^&*(),.?":{}|<>-]').hasMatch(password) == false) {
        _errorPassword = 'Password must contain at least one special character';
      } else {
        _errorPassword = null;
      }
    });
    return _errorPassword == null;
  }

  Future<bool> resetPassword(String password) async {
    try {
      if (!_validatePassword(password)) {
        return false;
      }
      setState(() {
        loading = true;
      });
      bool status = await UserAPI().resetPassword(widget.email, password);
      setState(() {
        loading = false;
      });
      if (status == false) {
        // 400, same password
        _errorPassword = "Can not be your previous password!";
        setState(() {});
        return false;
      }
      // Yay, password is FINALLY reset...
      if (!mounted) return false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Successfully changed password!'),
        ),
      );
      // re-route to login :D
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
      return true;
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: Column(
        children: [
          const HeaderLogo(pressable: false), // Add the logo header here
          (loading == true)
              ? const Expanded(child: Center(child: CircularProgressIndicator()))
              : Expanded(
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
                                'Change password',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const SizedBox(height: 20),
                            const Text(
                              'Enter new password:',
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                                filled: true,
                                fillColor: Colors.grey[100],
                                hintText: 'Enter your new password:',
                                errorText: _errorPassword,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Confirm new password:',
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              onChanged: (value) => {
                                _validatePassword(value),
                              },
                              obscureText: true,
                              controller: confirmController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                                filled: true,
                                fillColor: Colors.grey[100],
                                hintText: 'Confirm your new password:',
                              ),
                            ),
                            if (_remains.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Password must meet the following requirements:',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  for (var req in _remains)
                                    Text(
                                      '- ${req.name}',
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                ],
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
                                        resetPassword(passwordController.text);
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
