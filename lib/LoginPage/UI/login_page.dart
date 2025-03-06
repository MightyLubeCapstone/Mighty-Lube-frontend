import 'package:flutter/material.dart';
import 'package:mighty_lube/api.dart';
import 'package:mighty_lube/header_logo.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool usererror = false;
  bool passerror = false;
  bool loading = false;

  Future<void> login() async {
    final username = usernameController.text;
    final password = passwordController.text;

    setState(() {
      usererror = false;
      passerror = false;
      loading = true;
    });

    if (username.isNotEmpty && password.isNotEmpty) {
      try {
        bool loginSuccess = await UserAPI().loginUser(username, password);
        if (loginSuccess) {
          if (mounted) {
            Navigator.pushNamed(context, '/dashboard');
          }
        } else {
          if (mounted) {
            showError(context, 'Incorrect username or password');
          }
          setState(() {
            loading = false;
            usererror = true;
            passerror = true;
          });
        }
      } catch (e) {
        if (mounted) {
          showError(context, 'Failed to login');
        }
      }
    } else {
      setState(() {
        if (username.isEmpty) usererror = true;
        if (password.isEmpty) passerror = true;
        setState(() {
          loading = false;
        });
      });
      showError(context, 'Please enter a username and password');
    }
  }

  void showError(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: const Text("Login Error"), content: Text(message), actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              )
            ]));
  }

  @override
  Widget build(BuildContext context) {
    if (loading == true) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()), // Loading indicator
      );
    } else {
      return Scaffold(
        backgroundColor: const Color(0xFFF3F4F6),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HeaderLogo(pressable: false),
            const SizedBox(height: 10),
            Expanded(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
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
                            'Welcome Back!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Center(
                          child: Text(
                            'Login to your account',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Username:',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: usererror ? Colors.red : Colors.grey),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                            filled: true,
                            fillColor: Colors.grey[100],
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Password:',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: passerror ? Colors.red : Colors.grey),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                            filled: true,
                            fillColor: Colors.grey[100],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/forgot_password');
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: double.infinity,
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
                              login(); // since it could take a bit, look into loading icons
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
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
                              Navigator.pushNamed(context, '/create_account');
                            },
                            child: const Text(
                              'Create Account',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
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
}
