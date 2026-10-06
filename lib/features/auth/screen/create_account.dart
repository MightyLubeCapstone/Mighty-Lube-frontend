import 'dart:async';
import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mighty_lube/features/auth/repositories/user_repository.dart';

import '../../../core/widget/header_logo.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({
    super.key,
  });

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
  final TextEditingController securityPinController = TextEditingController();

  List<String> _countries = [];

  String? countrytype;

  String? _errorCompany;
  String? _errorFirstName;
  String? _errorLastName;
  String? _errorPhone;
  String? _errorPassword;
  String? _errorConfirmPassword;
  String? _errorUser;
  String? _errorEmail;
  String? _errorSecurityPin;
  String? _errorCountry;

  Timer? _delay;

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  // =========================================================
  // LOAD COUNTRIES
  // =========================================================

  Future<void> _loadCountries() async {
    final String response = await rootBundle.loadString(
      'assets/countries.json',
    );

    final List<dynamic> data = json.decode(
      response,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _countries = data.cast<String>();
    });
  }

  // =========================================================
  // VALIDATE ALL INPUTS
  // =========================================================

  Future<bool> _validateInputs() async {
    _validateCompany(
      companyController.text,
    );

    _validateFirstName(
      firstNameController.text,
    );

    _validateLastName(
      lastNameController.text,
    );

    _validatePhone(
      phoneController.text,
    );

    _validateEmail(
      emailController.text,
    );

    _validatePassword(
      passwordController.text,
    );

    _validateConfirmPassword(
      passwordController.text,
      confirmPasswordController.text,
    );

    _validateSecurityPin(
      securityPinController.text,
    );

    _validateCountry();

    await _validateUser(
      usernameController.text,
    );

    return !_hasValidationErrors;
  }

  bool get _hasValidationErrors {
    return (_errorCompany?.isNotEmpty ?? false) ||
        (_errorFirstName?.isNotEmpty ?? false) ||
        (_errorLastName?.isNotEmpty ?? false) ||
        (_errorPhone?.isNotEmpty ?? false) ||
        (_errorPassword?.isNotEmpty ?? false) ||
        (_errorConfirmPassword?.isNotEmpty ?? false) ||
        (_errorUser?.isNotEmpty ?? false) ||
        (_errorEmail?.isNotEmpty ?? false) ||
        (_errorSecurityPin?.isNotEmpty ?? false) ||
        (_errorCountry?.isNotEmpty ?? false);
  }

  // =========================================================
  // COMPANY
  // =========================================================

  void _validateCompany(
      String value,
      ) {
    setState(() {
      final company = value.trim();

      if (company.isEmpty) {
        _errorCompany = 'Company name is required';
      } else if (company.length > 150) {
        _errorCompany = 'Company name must be at most 150 characters';
      } else {
        _errorCompany = null;
      }
    });
  }

  // =========================================================
  // FIRST NAME
  // =========================================================

  void _validateFirstName(
      String value,
      ) {
    setState(() {
      final firstName = value.trim();

      if (firstName.isEmpty) {
        _errorFirstName = 'First name is required';
      } else if (firstName.length > 100) {
        _errorFirstName = 'First name must be at most 100 characters';
      } else {
        _errorFirstName = null;
      }
    });
  }

  // =========================================================
  // LAST NAME
  // =========================================================

  void _validateLastName(
      String value,
      ) {
    setState(() {
      final lastName = value.trim();

      if (lastName.isEmpty) {
        _errorLastName = 'Last name is required';
      } else if (lastName.length > 100) {
        _errorLastName = 'Last name must be at most 100 characters';
      } else {
        _errorLastName = null;
      }
    });
  }

  // =========================================================
  // PHONE
  // =========================================================

  void _validatePhone(
      String value,
      ) {
    setState(() {
      final rawPhone = value.trim();

      if (rawPhone.isEmpty) {
        _errorPhone = 'Phone number is required';
        return;
      }

      final bool hasLeadingPlus = rawPhone.startsWith('+');

      final String digits = rawPhone.replaceAll(
        RegExp(r'\D'),
        '',
      );

      final String normalizedPhone =
      hasLeadingPlus ? '+$digits' : digits;

      if (!RegExp(r'^\+?\d{7,15}$').hasMatch(normalizedPhone)) {
        _errorPhone = 'Enter a valid phone number';
      } else {
        _errorPhone = null;
      }
    });
  }

  // =========================================================
  // EMAIL
  // =========================================================

  void _validateEmail(
      String email,
      ) {
    setState(() {
      final normalizedEmail = email.trim();

      if (normalizedEmail.isEmpty) {
        _errorEmail = 'Email is required';
      } else if (!RegExp(
        r'^[^\s@]+@[^\s@]+\.[^\s@]+$',
      ).hasMatch(normalizedEmail)) {
        _errorEmail = 'Enter a valid email address';
      } else {
        _errorEmail = null;
      }
    });
  }

  // =========================================================
  // USERNAME
  //
  // RULE:
  // 3 - 50 characters
  // =========================================================

  Future<void> _validateUser(
      String username,
      ) async {
    final normalizedUsername = username.trim().toLowerCase();

    if (normalizedUsername.isEmpty) {
      if (mounted) {
        setState(() {
          _errorUser = 'Username is required';
        });
      }
      return;
    }

    if (normalizedUsername.length < 3) {
      if (mounted) {
        setState(() {
          _errorUser = 'Username must be at least 3 characters';
        });
      }
      return;
    }

    if (normalizedUsername.length > 50) {
      if (mounted) {
        setState(() {
          _errorUser = 'Username must be at most 50 characters';
        });
      }
      return;
    }

    try {
      final userCheck = await UserRepository.checkUser(
        username: normalizedUsername,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        if (!userCheck.success) {
          _errorUser =
              userCheck.fieldErrors['username'] ??
                  userCheck.message ??
                  userCheck.data ??
                  'Username unavailable';
        } else {
          _errorUser = null;
        }
      });
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _errorUser = 'Unable to check username';
      });
    }
  }

  void _validateUserDelayed(
      String username,
      ) {
    _delay?.cancel();

    _delay = Timer(
      const Duration(
        milliseconds: 500,
      ),
          () {
        _validateUser(
          username,
        );
      },
    );
  }

  // =========================================================
  // PASSWORD
  //
  // RULES:
  // 1. 6 - 50 characters
  // 2. Password is case-sensitive
  //
  // NO mandatory:
  // - uppercase
  // - lowercase
  // - number
  // - special character
  // =========================================================

  void _validatePassword(
      String password,
      ) {
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
  }

  // =========================================================
  // CONFIRM PASSWORD
  // =========================================================

  void _validateConfirmPassword(
      String password,
      String confirmPassword,
      ) {
    setState(() {
      if (confirmPassword.isEmpty) {
        _errorConfirmPassword = 'Confirm password is required';
      } else if (password != confirmPassword) {
        _errorConfirmPassword = 'Passwords do not match';
      } else {
        _errorConfirmPassword = null;
      }
    });
  }

  // =========================================================
  // SECURITY PIN
  // =========================================================

  void _validateSecurityPin(
      String securityPin,
      ) {
    setState(() {
      final pin = securityPin.trim();

      if (pin.isEmpty) {
        _errorSecurityPin = 'Security PIN is required';
      } else if (!RegExp(r'^\d{6}$').hasMatch(pin)) {
        _errorSecurityPin = 'Security PIN must be exactly 6 digits';
      } else {
        _errorSecurityPin = null;
      }
    });
  }

  // =========================================================
  // COUNTRY
  // =========================================================

  void _validateCountry() {
    setState(() {
      if (countrytype == null || countrytype!.trim().isEmpty) {
        _errorCountry = 'Country is required';
      } else {
        _errorCountry = null;
      }
    });
  }

  // =========================================================
  // CREATE ACCOUNT
  // =========================================================

  Future<void> createAccount(
      BuildContext context,
      ) async {
    if (_isSubmitting) {
      return;
    }

    if (!await _validateInputs()) {
      return;
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final companyName = companyController.text.trim();
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final phoneNumber = phoneController.text.trim();
    final email = emailController.text.trim().toLowerCase();
    final username = usernameController.text.trim().toLowerCase();

    // IMPORTANT:
    // Password is NOT lowercased or uppercased.
    // This keeps the password case-sensitive.
    final password = passwordController.text;

    final securityPin = securityPinController.text.trim();
    final country = countrytype!.trim();

    try {
      final result = await UserRepository.makeAccount(
        username: username,
        password: password,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        companyName: companyName,
        securityPin: securityPin,
        country: country,
      );

      if (!mounted) {
        return;
      }

      if (result.success && result.data == true) {
        Navigator.pushReplacementNamed(
          context,
          '/dashboard',
        );
        return;
      }

      final bool hasFieldErrors = _applyBackendErrors(
        result.fieldErrors,
        result.missingFields,
      );

      if (!hasFieldErrors) {
        _showAccountCreationError(
          context,
          result.message ?? 'Unable to create account.',
        );
      }
    } catch (_) {
      if (!mounted) {
        return;
      }

      _showAccountCreationError(
        context,
        'Unable to create account.',
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  // =========================================================
  // BACKEND FIELD ERRORS
  // =========================================================

  bool _applyBackendErrors(
      Map<String, String> fieldErrors,
      List<String> missingFields,
      ) {
    bool hasFieldError = false;

    setState(() {
      for (final entry in fieldErrors.entries) {
        final field = entry.key.trim().toLowerCase();
        final message = entry.value.trim();

        if (message.isEmpty) {
          continue;
        }

        switch (field) {
          case 'companyname':
          case 'company':
            _errorCompany = message;
            hasFieldError = true;
            break;

          case 'firstname':
            _errorFirstName = message;
            hasFieldError = true;
            break;

          case 'lastname':
            _errorLastName = message;
            hasFieldError = true;
            break;

          case 'phonenumber':
          case 'phone':
            _errorPhone = message;
            hasFieldError = true;
            break;

          case 'email':
          case 'emailaddress':
            _errorEmail = message;
            hasFieldError = true;
            break;

          case 'username':
            _errorUser = message;
            hasFieldError = true;
            break;

          case 'password':
            _errorPassword = message;
            hasFieldError = true;
            break;

          case 'securitypin':
            _errorSecurityPin = message;
            hasFieldError = true;
            break;

          case 'country':
            _errorCountry = message;
            hasFieldError = true;
            break;
        }
      }

      for (final rawField in missingFields) {
        final field = rawField.trim().toLowerCase();

        switch (field) {
          case 'companyname':
          case 'company':
            _errorCompany ??= 'Company name is required';
            hasFieldError = true;
            break;

          case 'firstname':
            _errorFirstName ??= 'First name is required';
            hasFieldError = true;
            break;

          case 'lastname':
            _errorLastName ??= 'Last name is required';
            hasFieldError = true;
            break;

          case 'phonenumber':
          case 'phone':
            _errorPhone ??= 'Phone number is required';
            hasFieldError = true;
            break;

          case 'email':
          case 'emailaddress':
            _errorEmail ??= 'Email is required';
            hasFieldError = true;
            break;

          case 'username':
            _errorUser ??= 'Username is required';
            hasFieldError = true;
            break;

          case 'password':
            _errorPassword ??= 'Password is required';
            hasFieldError = true;
            break;

          case 'securitypin':
            _errorSecurityPin ??= 'Security PIN is required';
            hasFieldError = true;
            break;

          case 'country':
            _errorCountry ??= 'Country is required';
            hasFieldError = true;
            break;
        }
      }
    });

    return hasFieldError;
  }

  // =========================================================
  // ERROR DIALOG
  // =========================================================

  void _showAccountCreationError(
      BuildContext context,
      String message,
      ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Account creation failed',
        ),
        content: Text(
          message,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Ok',
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void dispose() {
    _delay?.cancel();

    companyController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    securityPinController.dispose();

    super.dispose();
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(
      BuildContext context,
      ) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const HeaderLogo(
            pressable: false,
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Container(
                padding: const EdgeInsets.all(
                  20,
                ),
                margin: const EdgeInsets.only(
                  top: 10,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Register Page',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    // COMPANY
                    buildTextField(
                      'Company Name:*',
                      'Company Name',
                      companyController,
                      borderColor: Colors.grey,
                      errorText: _errorCompany,
                      onChanged: _validateCompany,
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    // NAME
                    const Text(
                      'Name:*',
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: buildTextField(
                            '',
                            'First Name',
                            firstNameController,
                            borderColor: Colors.grey,
                            errorText: _errorFirstName,
                            onChanged: _validateFirstName,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: buildTextField(
                            '',
                            'Last Name',
                            lastNameController,
                            borderColor: Colors.grey,
                            errorText: _errorLastName,
                            onChanged: _validateLastName,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    // PHONE
                    buildTextField(
                      'Phone Number:*',
                      'Phone Number',
                      phoneController,
                      borderColor: Colors.grey,
                      keyboardType: TextInputType.phone,
                      errorText: _errorPhone,
                      onChanged: _validatePhone,
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    // EMAIL
                    buildTextField(
                      'Email Address:*',
                      'Email Address',
                      emailController,
                      borderColor: Colors.grey,
                      keyboardType: TextInputType.emailAddress,
                      errorText: _errorEmail,
                      onChanged: _validateEmail,
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    // USERNAME
                    buildTextField(
                      'Username:*',
                      'Username',
                      usernameController,
                      borderColor: Colors.grey,
                      errorText: _errorUser,
                      onChanged: (value) {
                        _validateUserDelayed(
                          value,
                        );
                      },
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    // PASSWORD
                    buildTextField(
                      'Password:*',
                      'Password',
                      passwordController,
                      obscureText: true,
                      borderColor: Colors.grey,
                      errorText: _errorPassword,
                      onChanged: (value) {
                        _validatePassword(
                          value,
                        );

                        if (confirmPasswordController.text.isNotEmpty) {
                          _validateConfirmPassword(
                            value,
                            confirmPasswordController.text,
                          );
                        }
                      },
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    // PASSWORD REQUIREMENTS
                    const Text(
                      'Password requirements:',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(
                      height: 4,
                    ),

                    const Text(
                      '• Password must be 6 to 50 characters.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),

                    const SizedBox(
                      height: 2,
                    ),

                    const Text(
                      '• Password is case-sensitive.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    // CONFIRM PASSWORD
                    buildTextField(
                      'Confirm Password:*',
                      'Confirm Password',
                      confirmPasswordController,
                      obscureText: true,
                      borderColor: Colors.grey,
                      errorText: _errorConfirmPassword,
                      onChanged: (value) {
                        _validateConfirmPassword(
                          passwordController.text,
                          value,
                        );
                      },
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    // SECURITY PIN
                    buildTextField(
                      'Security PIN:*',
                      '6-digit Security PIN',
                      securityPinController,
                      borderColor: Colors.grey,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(
                          6,
                        ),
                      ],
                      errorText: _errorSecurityPin,
                      onChanged: _validateSecurityPin,
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    // COUNTRY
                    const Text(
                      'Country:*',
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                    DropdownSearch<String>(
                      items: _countries,
                      selectedItem: countrytype,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: 'Select Country',
                          hintStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 20,
                          ),
                          errorText: _errorCountry,
                        ),
                      ),
                      popupProps: PopupProps.dialog(
                        showSearchBox: true,
                        dialogProps: DialogProps(
                          backgroundColor: Colors.white,
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                          ),
                        ),
                        searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                            labelText: 'Search Country',
                            labelStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                            hintText: 'Type to search...',
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                12,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        itemBuilder: (
                            context,
                            item,
                            isSelected,
                            ) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            child: Text(
                              item,
                              style: TextStyle(
                                fontSize: 16,
                                color: isSelected
                                    ? Colors.blue
                                    : Colors.black,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          );
                        },
                      ),
                      dropdownBuilder: (
                          context,
                          selectedItem,
                          ) {
                        return Text(
                          selectedItem ?? 'Select Country',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        );
                      },
                      filterFn: (
                          item,
                          filter,
                          ) {
                        return item.toLowerCase().startsWith(
                          filter.toLowerCase(),
                        );
                      },
                      onChanged: (value) {
                        setState(() {
                          countrytype = value;
                          _errorCountry = null;
                        });
                      },
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    // REGISTER
                    buildGradientButton(
                      _isSubmitting
                          ? 'Creating Account...'
                          : 'Register',
                      _isSubmitting
                          ? null
                          : () {
                        createAccount(
                          context,
                        );
                      },
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    // CANCEL
                    buildGrayButton(
                      'Cancel',
                      _isSubmitting
                          ? null
                          : () {
                        Navigator.pop(
                          context,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // TEXT FIELD
  // =========================================================

  Widget buildTextField(
      String label,
      String hint,
      TextEditingController controller, {
        bool obscureText = false,
        String? errorText,
        required Color borderColor,
        void Function(String)? onChanged,
        TextInputType? keyboardType,
        List<TextInputFormatter>? inputFormatters,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Text(
            label,
          ),
          const SizedBox(
            height: 8,
          ),
        ],
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                12,
              ),
              borderSide: BorderSide(
                color: borderColor,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 20,
            ),
            filled: true,
            fillColor: Colors.grey[100],
            hintText: hint,
            errorText: errorText,
          ),
        ),
      ],
    );
  }

  // =========================================================
  // REGISTER BUTTON
  // =========================================================

  Widget buildGradientButton(
      String text,
      VoidCallback? onPressed,
      ) {
    return Container(
      width: double.infinity,
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
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // =========================================================
  // CANCEL BUTTON
  // =========================================================

  Widget buildGrayButton(
      String text,
      VoidCallback? onPressed,
      ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          12,
        ),
        color: Colors.grey[300],
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}