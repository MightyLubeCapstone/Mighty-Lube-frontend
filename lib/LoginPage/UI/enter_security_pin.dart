import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mighty_lube/LoginPage/UI/change_pass.dart';
import 'package:mighty_lube/api.dart';
import 'package:mighty_lube/header_logo.dart';

class EnterSecurityPin extends StatefulWidget {
  final String email;
  const EnterSecurityPin({super.key, required this.email});

  @override
  State<EnterSecurityPin> createState() => _EnterSecurityPinState();
}

class _EnterSecurityPinState extends State<EnterSecurityPin> {
  final TextEditingController securityPinController = TextEditingController();
  String? _errorSecurityPin;

  bool loading = false;

  bool _validateSecurityPin(String securityPin) {
    setState(() {
      if (securityPin.trim().isEmpty) {
        _errorSecurityPin = 'Security PIN is required!';
      } else {
        _errorSecurityPin = null;
      }
    });
    return _errorSecurityPin == null;
  }

  Future<bool> validateSecurityPin(String securityPin) async {
    try {
      if (!_validateSecurityPin(securityPin)) return false;
      setState(() {
        loading = true;
      });
      bool status =
          await UserAPI().validateSecurityPin(widget.email, securityPin);
      setState(() {
        loading = false;
      });
      if (!status) {
        setState(() {
          _errorSecurityPin = 'Invalid security PIN!';
        });
      }
      return status == true;
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      return false;
    }
  }

  @override
  void dispose() {
    securityPinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: Column(
        children: [
          const HeaderLogo(pressable: false),
          (loading == true)
              ? const Expanded(
                  child: Center(child: CircularProgressIndicator()))
              : Expanded(
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: EdgeInsets.fromLTRB(
                          20, 0, 20, keyboardHeight > 0 ? 0 : 100),
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
                                'Security PIN',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Enter your security PIN to reset your password.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Security PIN:',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: securityPinController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                filled: true,
                                fillColor: Colors.grey[100],
                                hintText: 'Enter your security PIN:',
                                errorText: _errorSecurityPin,
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
                                        Navigator.pop(context);
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
                                        colors: [
                                          Colors.blueAccent,
                                          Colors.lightBlueAccent
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        final securityPin =
                                            securityPinController.text.trim();
                                        validateSecurityPin(securityPin)
                                            .then(
                                          (success) => {
                                            if (success)
                                              {
                                                Navigator.pushReplacement(
                                                  // ignore: use_build_context_synchronously
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChangePass(
                                                            email:
                                                                widget.email,
                                                            securityPin:
                                                                securityPin),
                                                  ),
                                                )
                                              }
                                          },
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
