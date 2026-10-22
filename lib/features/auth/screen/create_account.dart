
import 'dart:async';
import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:mighty_lube/features/auth/repositories/user_repository.dart';
import '../../../Utils/utils.dart';
import '../../../core/widget/header_logo.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key,});

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
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

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
  String? _errorCountry;

  Timer? _delay;
  Timer? _otpCooldownTimer;
  String? _verificationToken;
  String? _verifiedEmail;
  String? _otpRequestedEmail;
  String? _otpMessage;
  bool _otpSent = false;
  bool _otpBusy = false;
  int _resendSeconds = 0;

  bool _isSubmitting = false;
  String _fsVersion = '...';

  @override
  void initState() {
    super.initState();
    _loadCountries();
    _loadFsVersion();
  }

  String get _currentEmail => emailController.text.trim().toLowerCase();

  bool get _isEmailVerified => _verifiedEmail == _currentEmail && _verificationToken != null;

  void _onEmailChanged(String value) {
    final current = value.trim().toLowerCase();
    if (_verifiedEmail != current || _otpRequestedEmail != current) {
      _otpCooldownTimer?.cancel();
      setState(() {
        _verificationToken = null;
        _verifiedEmail = null;
        _otpRequestedEmail = null;
        _otpSent = false;
        _otpMessage = null;
        _resendSeconds = 0;
        _otpController.clear();
      });
    }
    _validateEmail(value);
  }

  void _startOtpCooldown() {
    _otpCooldownTimer?.cancel();
    setState(() => _resendSeconds = 60);
    _otpCooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        if (_resendSeconds > 0) _resendSeconds--;
        if (_resendSeconds == 0) timer.cancel();
      });
    });
  }

  Future<void> _requestEmailOtp() async {
    if (_otpBusy || _isSubmitting || _resendSeconds > 0) return;
    _validateEmail(emailController.text);
    if (_errorEmail != null) return;
    final email = _currentEmail;
    setState(() {
      _otpBusy = true;
      _otpMessage = null;
    });
    try {
      final result = await UserRepository.requestEmailVerificationOtp(
        email: email,
        purpose: 'registration',
      );
      if (!mounted || email != _currentEmail) return;
      setState(() {
        _otpSent = result.success;
        _otpRequestedEmail = result.success ? email : null;
        _otpMessage = result.success ? 'Verification code sent. It expires in 5 minutes.' : (result.message ?? 'Unable to send verification code.');
      });
      if (result.success) _startOtpCooldown();
    } catch (_) {
      if (mounted && email == _currentEmail) {
        setState(() => _otpMessage = 'Unable to send verification code.');
      }
    } finally {
      if (mounted) setState(() => _otpBusy = false);
    }
  }

  Future<void> _confirmEmailOtp() async {
    if (_otpBusy || _isSubmitting || !_otpSent || _otpRequestedEmail != _currentEmail) return;
    final otp = _otpController.text.trim();

    if (!RegExp(r'^\d{6}$').hasMatch(otp)) {
      setState(() => _otpMessage = 'Enter the 6-digit verification code.');
      return;
    }
    final email = _currentEmail;
    setState(() {
      _otpBusy = true;
      _otpMessage = null;
    });
    try {
      final result = await UserRepository.verifyEmailVerificationOtp(
        email: email,
        otp: otp,
        purpose: 'registration',
      );
      if (!mounted || email != _currentEmail) return;
      if (result.success && result.data != null && result.data!.isNotEmpty) {
        _otpCooldownTimer?.cancel();
        setState(() {
          _verificationToken = result.data;
          _verifiedEmail = email;
          _otpSent = false;
          _resendSeconds = 0;
          _otpMessage = 'Email verified successfully.';
        });
      } else {
        setState(() => _otpMessage = result.message ?? 'Invalid or expired verification code.');
      }
    } catch (_) {
      if (mounted && email == _currentEmail) {
        setState(() => _otpMessage = 'Unable to verify code. Try again.');
      }
    } finally {
      if (mounted) setState(() => _otpBusy = false);
    }
  }

  Future<void> _loadFsVersion() async {
    try {
      final info = await PackageInfo.fromPlatform();
      if (!mounted) return;
      setState(() => _fsVersion = info.version.trim().isEmpty ? 'Unavailable' : info.version.trim());
    } catch (_) {
      if (!mounted) return;
      setState(() => _fsVersion = 'Unavailable');
    }
  }

// =========================================================
// LOAD COUNTRIES
// =========================================================

  Future<void> _loadCountries() async {
    final String response = await rootBundle.loadString('assets/countries.json',);
    final List<dynamic> data = json.decode(response,);
    if (!mounted) {return;}
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
        (_errorCountry?.isNotEmpty ?? false);
  }

// =========================================================
// COMPANY
// =========================================================

  void _validateCompany(String value,) {
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

  void _validateFirstName(String value,) {
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

  void _validateLastName(String value,) {
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

  void _validatePhone(String value,) {
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

  void _validateEmail(String email,) {
    setState(() {
      final normalizedEmail = email.trim();
      if (normalizedEmail.isEmpty) {
        _errorEmail = 'Email is required';
      } else if (
      !RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$',
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
// 6 - 24 characters
// =========================================================

  Future<void> _validateUser(String username,) async {
    final normalizedUsername = username.trim().toLowerCase();
    if (normalizedUsername.isEmpty) {
      if (mounted) {
        setState(() {
          _errorUser = 'Username is required';
        });
      }
      return;
    }

    if (normalizedUsername.length < 6) {
      if (mounted) {
        setState(() {
          _errorUser = 'Username must be at least 6 characters';
        });
      }
      return;
    }

    if (normalizedUsername.length > 24) {
      if (mounted) {
        setState(() {
          _errorUser = 'Username must be at most 24 characters';
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


  void _validateUserDelayed(String username) {
    _delay?.cancel();

    _delay = Timer(
      const Duration(milliseconds: 500),
          () {
        if (!mounted) return;
        _validateUser(username);
      },
    );
  }


// =========================================================
// PASSWORD
//
// RULES:
// 1. 8 - 50 characters
// 2. Password is case-sensitive
//
// NO mandatory:
// - uppercase
// - lowercase
// - number
// - special character
// =========================================================

  void _validatePassword(String password,) {
    setState(() {
      if (password.isEmpty) {
        _errorPassword = 'Password is required';
      } else if (password.length < 8) {
        _errorPassword = 'Password must be at least 8 characters';
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

  void _validateConfirmPassword(String password, String confirmPassword,) {
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

  Future<void> createAccount(BuildContext context,) async {
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
        country: country,
        verificationToken: _verifiedEmail == email ? _verificationToken : null,
      );

      if (!mounted) {
        return;
      }

      if (result.success && result.data == true) {
        await showDialog<void>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: const Text('Account Created'),
            content: const Text(
                'Your account has been created successfully. You can now log in. Email verification is optional.'
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        if (!mounted) return;
        Navigator.of(context).pop();
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

  bool _applyBackendErrors(Map<String, String> fieldErrors, List<String> missingFields,) {
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

  void _showAccountCreationError(BuildContext context, String message,) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Account creation failed',),
        content: Text(message,),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Ok',),
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
    _otpCooldownTimer?.cancel();

    _otpController.dispose();

    companyController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }


// =========================================================
// BUILD
// =========================================================

  @override
  Widget build(BuildContext context,) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const HeaderLogo(pressable: false,),
          const SizedBox(height: 10,),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20,),
              child: Container(
                padding: const EdgeInsets.all(20,),
                margin: const EdgeInsets.only(top: 10,),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20,),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1,),
                      spreadRadius: 5,
                      blurRadius: 15,
                      offset: const Offset(0, 10,),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text('Create Account',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),

                    // COMPANY
                    buildTextField(
                      'Company Name:*',
                      'Company Name',
                      companyController,
                      borderColor: Colors.grey,
                      errorText: _errorCompany,
                      onChanged: _validateCompany,
                    ),

                    SizedBox(height: Utils.heightBetweenItem,),

                    // NAME
                    const Text('Name:*',),
                    const SizedBox(height: 5,),
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
                        const SizedBox(width: 10,),
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

                    SizedBox(height: Utils.heightBetweenItem,),

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

                    SizedBox(height: Utils.heightBetweenItem,),

                    // EMAIL
                    const Text('Email Address *',),
                    const SizedBox(height: 5,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: buildTextField(
                           '',
                            'Email Address',
                            emailController,
                            borderColor: Colors.grey,
                            keyboardType: TextInputType.emailAddress,
                            errorText: _errorEmail,
                            onChanged: _onEmailChanged,
                          ),
                        ),
                        const SizedBox(width: 5,),

                        OutlinedButton.icon(
                          onPressed: (_otpBusy || _isSubmitting || _resendSeconds > 0 || _isEmailVerified) ? null : _requestEmailOtp,
                          icon: Icon(_isEmailVerified ? Icons.verified : Icons.mark_email_unread_outlined),
                          label: Text(_isEmailVerified ? 'Verified' : _otpBusy ? 'wait...' : _resendSeconds > 0 ? 'Resend in ${_resendSeconds}s' : _otpSent ? 'Resend OTP' : 'Verify',
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.grey[100],
                            foregroundColor: Colors.black87,
                            disabledForegroundColor: Colors.grey,
                            // side: BorderSide(color: borderColor),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2,),
                            minimumSize: const Size(0, 48),
                          ),
                        ),

                        // OutlinedButton.icon(
                        //   onPressed: (_otpBusy || _isSubmitting || _resendSeconds > 0) ? null : _requestEmailOtp,
                        //   icon: const Icon(Icons.mark_email_unread_outlined),
                        //   label: Text(_otpBusy ? 'Please wait...' : _resendSeconds > 0 ? 'Resend in ${_resendSeconds}s' : _otpSent ? 'Resend OTP' : 'Verify'),
                        // ),
                      ],
                    ),

                    const SizedBox(height: 8),
                    if (_verifiedEmail == _currentEmail && _verificationToken != null)
                      const Row(
                        children: [
                          Icon(Icons.verified, color: Colors.green, size: 20),
                          SizedBox(width: 8),
                          Text('Email Verified', style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600)),
                        ],
                      )
                    else ...[
                      if (_otpSent && _otpRequestedEmail == _currentEmail) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _otpController,
                                keyboardType: TextInputType.number,
                                maxLength: 6,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                decoration: const InputDecoration(
                                  labelText: '6-digit OTP',
                                  counterText: '',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: _otpBusy ? null : _confirmEmailOtp,
                              child: const Text('Confirm'),
                            ),
                          ],
                        ),
                      ],
                    ],
                    if (_otpMessage != null) ...[
                      const SizedBox(height: 6),
                      Text(_otpMessage!,
                          style: TextStyle(
                            fontSize: 12,
                            color: _verifiedEmail == _currentEmail
                                ? Colors.green : Colors.red,
                          )),
                    ],

                    SizedBox(height: Utils.heightBetweenItem,),
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

                    SizedBox(height: Utils.heightBetweenItem,),

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

                    SizedBox(height: Utils.heightBetweenItem,),


// PASSWORD REQUIREMENTS
                    const Text(
                      'Password requirements:',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 4,),

                    const Text('• Password must be 8 to 50 characters.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),

                    const SizedBox(
                      height: 2,
                    ),

                    const Text('• Password is case-sensitive.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),

                    SizedBox(height: Utils.heightBetweenItem,),

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

                    SizedBox(height: Utils.heightBetweenItem,),


                    // COUNTRY
                    const Text('Country:*',),
                    const SizedBox(height: 5,),

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
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
              child: Text('Version $_fsVersion',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF30343B),),
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
      TextEditingController controller,
      {
        bool obscureText = false,
        String? errorText,
        required Color borderColor,
        void Function(String)? onChanged,
        TextInputType? keyboardType,
        List<TextInputFormatter>? inputFormatters,
      })
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Text(label,),
          const SizedBox(height: 8,),
        ],
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12,),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12,),
              borderSide: BorderSide(color: borderColor,),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2,),
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

  Widget buildGradientButton(String text, VoidCallback? onPressed,) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12,),
        gradient: const LinearGradient(
          colors: [
            Colors.blueAccent,
            Color(0xFF2563EB),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(text,
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

  Widget buildGrayButton(String text, VoidCallback? onPressed,) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12,),
        color: const Color(0xFFE5E7EB),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(text,
          style: const TextStyle(
            fontSize: 18,
            color: const Color(0xFF374151),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}