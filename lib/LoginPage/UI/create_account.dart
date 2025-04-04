// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mighty_lube/api.dart';
import 'package:mighty_lube/header_logo.dart';
import 'package:password_strength_checker/password_strength_checker.dart';
import 'dart:async';
import 'package:dropdown_search/dropdown_search.dart';

class PWDRequirements {
  final String name;
  final bool Function(String) check;

  PWDRequirements(this.name, this.check);
}

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final TextEditingController companyController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  List<String> _countries = [];

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  // Load countries dynamically from a JSON file
  Future<void> _loadCountries() async {
    final String response =
        await rootBundle.loadString('assets/countries.json');
    final List<dynamic> data = json.decode(response);
    setState(() {
      _countries = data.cast<String>();
    });
  }

  String? countrytype;
  String? _errorPassword;
  String? _errorConfirmPassword;
  String? _errorUser;
  String? _errorEmail;
  Timer? _delay;

  List<PWDRequirements> requirements = [
    PWDRequirements(
        'Password must be at least 8 characters', (input) => input.length >= 8),
    PWDRequirements('Password must contain at least one uppercase letter',
        (input) => RegExp(r'[A-Z]').hasMatch(input)),
    PWDRequirements('Password must contain at least one lowercase letter',
        (input) => RegExp(r'[a-z]').hasMatch(input)),
    PWDRequirements('Password must contain at least one number',
        (input) => RegExp(r'[0-9]').hasMatch(input)),
    PWDRequirements('Password must contain at least one special character',
        (input) => RegExp(r'[!@#$%^&*(),.?":{}|<>-]').hasMatch(input)),
  ];
  List<PWDRequirements> _remains = [];

  Future<bool> _validateInputs() async {
    _validateEmail(emailController.text);
    _validatePassword(passwordController.text);
    _validateConfirmPassword(
        passwordController.text, confirmPasswordController.text);
    await _validateUser(usernameController.text);

    if ((_errorPassword?.isNotEmpty ??
        false ||
            (_errorConfirmPassword?.isNotEmpty ?? false) ||
            (_errorUser?.isNotEmpty ?? false))) {
      setState(() {});
      return false;
    }

    return true;
  }

  void _validatePassword(String password) {
    setState(() {
      _errorPassword = null;
      _remains = requirements.where((req) => !req.check(password)).toList();
      if (RegExp(r'.{8,}').hasMatch(password) == false) {
        _errorPassword = 'Password must be at least 8 characters';
      } else if (RegExp(r'[A-Z]').hasMatch(password) == false) {
        _errorPassword = 'Password must contain at least one uppercase letter';
      } else if (RegExp(r'[a-z]').hasMatch(password) == false) {
        _errorPassword = 'Password must contain at least one lowercase letter';
      } else if (RegExp(r'[0-9]').hasMatch(password) == false) {
        _errorPassword = 'Password must contain at least one number';
      } else if (RegExp(r'[!@#$%^&*(),.?":{}|<>-]').hasMatch(password) ==
          false) {
        _errorPassword = 'Password must contain at least one special character';
      }
    });
  }

  void _validateConfirmPassword(String password, String confirmPassword) {
    setState(() {
      _errorConfirmPassword = null;
      if (password != confirmPassword) {
        _errorConfirmPassword = 'Passwords do not match';
      } else {
        _errorConfirmPassword = null;
      }
    });
  }

  Future<void> _validateUser(String username) async {
    _errorUser = null;

    try {
      if (username.isEmpty) {
        _errorUser = 'Username cannot be empty';
      } else if (username.length < 6) {
        _errorUser = 'Username must be at least 6 characters';
      } else if (username.length > 24) {
        _errorUser = 'Username must be at most 24 characters';
      } else {
        var userCheck = await UserAPI().checkUser(username);
        if (userCheck != 'Username available!') {
          _errorUser = userCheck;
        } else {
          _errorUser = null;
        }
      }
    } catch (e) {
      _errorUser = 'Error checking username';
    }

    setState(() {});
  }

  void _validateUserDelayed(String username) {
    if (_delay?.isActive ?? false) {
      _delay!.cancel();
    }
    _delay = Timer(const Duration(milliseconds: 500), () {
      _validateUser(username);
    });
  }

  void _validateEmail(String email) {
    setState(() {
      if (email.isEmpty) {
        _errorEmail = 'Email is Required';
      } else if (!RegExp(r'[^@]+@[^@]+\.[^@]+$').hasMatch(email)) {
        _errorEmail = 'Email must include an @ and a domain(.com, .org, etc)';
      } else {
        _errorEmail = null;
      }

      return;
    });
  }

  @override
  void dispose() {
    _delay?.cancel();
    super.dispose();
  }

  final passNotifier = ValueNotifier<PasswordStrength?>(null);

  Future<void> createAccount(BuildContext context) async {
    if (!await _validateInputs()) {
      return;
    }

    final companyName = companyController.text;
    final firstName = firstNameController.text;
    final lastName = lastNameController.text;
    final phoneNumber = phoneController.text;
    final email = emailController.text;
    final username = usernameController.text;
    final password = passwordController.text;

    try {
      bool success = await UserAPI().makeAccount(username, password, firstName,
          lastName, email, phoneNumber, companyName, countrytype!);
      if (success) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                    title: const Text('Error'),
                    content: const Text('Error'), //testing error, will change
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Ok'),
                      )
                    ]));
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                  title: const Text('Error'),
                  content: const Text('Error'), //testing error, will change
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Ok'),
                    )
                  ]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const HeaderLogo(pressable: false),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(top: 10),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Register Page',
                        style: TextStyle(
                          fontSize: 26, // Increased font size for the title
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    buildTextField(
                        'Company Name:*', 'Company Name', companyController,
                        borderColor: Colors.grey),
                    const SizedBox(height: 15),
                    const Text('Name:*'),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: buildTextField(
                              '', 'First Name', firstNameController,
                              borderColor: Colors.grey),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: buildTextField(
                              '', 'Last Name', lastNameController,
                              borderColor: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    buildTextField(
                        'Phone Number:', 'Phone Number', phoneController,
                        borderColor: Colors.grey),
                    const SizedBox(height: 15),
                    buildTextField(
                        'Email Address:*', 'Email Address', emailController,
                        borderColor: Colors.grey, onChanged: (value) {
                      _validateEmail(value);
                    }, errorText: _errorEmail != null ? '' : null),
                    if (_errorEmail != null)
                      Text(
                        _errorEmail!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    const SizedBox(height: 15),
                    buildTextField('Username:*', 'Username', usernameController,
                        borderColor: Colors.grey, onChanged: (value) {
                      _validateUserDelayed(value);
                    }, errorText: _errorUser != null ? '' : null),
                    if (_errorUser != null)
                      Text(
                        _errorUser!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    const SizedBox(height: 15),
                    buildTextField('Password:*', 'Password', passwordController,
                        obscureText: true,
                        borderColor: Colors.grey, onChanged: (value) {
                      _validatePassword(value);
                      passNotifier.value =
                          PasswordStrength.calculate(text: value);
                    }, errorText: _errorPassword != null ? '' : null),
                    const SizedBox(height: 15),
                    buildTextField('Confirm Password:* ', 'Confirm Password',
                        confirmPasswordController,
                        obscureText: true,
                        borderColor: Colors.grey, onChanged: (value) {
                      _validateConfirmPassword(passwordController.text, value);
                    }, errorText: _errorConfirmPassword != null ? '' : null),
                    if (_errorConfirmPassword != null)
                      Text(
                        _errorConfirmPassword!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    const SizedBox(height: 15),
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
                    const SizedBox(height: 8),
                    PasswordStrengthChecker(strength: passNotifier),
                    const SizedBox(height: 15),
                    const Text('Country:'),
                    const SizedBox(height: 8),
                    DropdownSearch<String>(
                      items: _countries, // List of countries
                      selectedItem: countrytype,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor:
                              Colors.grey[200], // Softer background color
                          hintText: 'Select Country',
                          hintStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey, // Subtle hint text
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                        ),
                      ),
                      popupProps: PopupProps.dialog(
                        showSearchBox: true,
                        dialogProps: DialogProps(
                          backgroundColor: Colors.white,
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                            labelText:
                                'Search Country', // Label for the search box
                            labelStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey, // Text color for the label
                            ),
                            hintText: 'Type to search...', // Placeholder text
                            hintStyle: const TextStyle(
                              color: Colors
                                  .grey, // Lighter color for the placeholder
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black, // Text color for user input
                          ),
                        ),
                        itemBuilder: (context, item, isSelected) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: Text(
                              item,
                              style: TextStyle(
                                fontSize: 16,
                                color: isSelected
                                    ? Colors.blue
                                    : Colors.black, // Highlight selected item
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          );
                        },
                      ),
                      dropdownBuilder: (context, selectedItem) {
                        return Text(
                          selectedItem ?? "Select Country",
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                        );
                      },
                      filterFn: (item, filter) {
                        return item
                            .toLowerCase()
                            .startsWith(filter.toLowerCase());
                      },
                      onChanged: (value) {
                        setState(() {
                          countrytype = value;
                        });
                      },
                    ),
                    const SizedBox(height: 30),
                    buildGradientButton('Register', () {
                      createAccount(
                          context); // Call createAccount method on button press
                    }),
                    const SizedBox(height: 10),
                    buildGrayButton('Cancel', () {
                      Navigator.pop(context); // Navigate back on cancel
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to create text fields with consistent styling
  Widget buildTextField(
      String label, String hint, TextEditingController controller,
      {bool obscureText = false,
      String? errorText,
      required Color borderColor,
      void Function(String)? onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) Text(label),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            filled: true,
            fillColor: Colors.grey[100],
            hintText: hint,
            errorText: errorText,
          ),
        ),
      ],
    );
  }

  // Helper method to create the gradient "Register" button
  Widget buildGradientButton(String text, VoidCallback onPressed) {
    return Container(
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
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18, // Increased font size for better visibility
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Helper method to create the gray "Cancel" button
  Widget buildGrayButton(String text, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[300],
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18, // Increased font size for better visibility
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
