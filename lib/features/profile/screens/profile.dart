
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mighty_lube/features/application/screens/application_catalog_page.dart';
import 'package:mighty_lube/features/auth/repositories/user_repository.dart';
import 'package:mighty_lube/features/cart/repositories/cart_repositories.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/widget/custom_app_bar.dart';
import '../../../core/widget/custom_drawer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _firstNameController = TextEditingController();

  final _lastNameController = TextEditingController();

  final _userNameController = TextEditingController();

  final _companyNameController = TextEditingController();

  final _phoneNumberController = TextEditingController();

  final _emailController = TextEditingController();

  String? _firstNameError;
  String? _lastNameError;
  String? _usernameError;
  String? _companyNameError;
  String? _phoneNumberError;
  String _originalUsername = '';

  String? _requiredMax(String value, String label, int max) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return '$label is required';
    if (trimmed.length > max) return '$label must be at most $max characters';
    return null;
  }

  String? _phoneError(String value) {
    final phone = value.trim();
    if (phone.isEmpty) return 'Phone number is required';
// International numbers: optional leading + and 7–15 digits.
    if (!RegExp(r'^\+?\d{7,15}$').hasMatch(phone)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  void _validateProfileFields() {
    setState(() {
      _firstNameError = _requiredMax(_firstNameController.text, 'First name', 100);
      _lastNameError = _requiredMax(_lastNameController.text, 'Last name', 100);
      _companyNameError = _requiredMax(_companyNameController.text, 'Company name', 150);
      _phoneNumberError = _phoneError(_phoneNumberController.text);
      final username = _userNameController.text.trim().toLowerCase();
      if (username.isEmpty) {
        _usernameError = 'Username is required';
      } else if (username.length < 6) {
        _usernameError = 'Username must be at least 6 characters';
      } else if (username.length > 24) {
        _usernameError = 'Username must be at most 24 characters';
      } else {
        _usernameError = null;
      }
    });
  }

  bool get _hasProfileErrors =>
      _firstNameError != null || _lastNameError != null ||
          _usernameError != null || _companyNameError != null ||
          _phoneNumberError != null;

  bool _emailVerified = false;
  String _savedEmail = '';
  bool _emailActionLoading = false;

  int totalQuantities = 0;

  bool loading = false;

  bool removeLoading = false;

  bool saveLoading = false;

  Future<void> _emailVerificationFlow({required bool changeEmail}) async {

    if (_emailActionLoading || !mounted) return;
    setState(() {
      _emailActionLoading = true;
    });

    final emailInput = TextEditingController(
      text: changeEmail ? '' : _savedEmail,
    );
    final otpInput = TextEditingController();
    bool sent = false;
    bool busy = false;
    int remaining = 0;
    Timer? timer;
    String? message;
    bool completed = false;
    final purpose = changeEmail ? 'change-email' : 'verify-email';
    final emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

    try {
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) => StatefulBuilder(
          builder: (dialogContext, updateDialog) {
            void startCooldown() {
              timer?.cancel();
              updateDialog(() => remaining = 60);
              timer = Timer.periodic(const Duration(seconds: 1), (t) {
                if (!dialogContext.mounted) {
                  t.cancel();
                  return;
                }
                updateDialog(() {
                  if (remaining > 0) remaining--;
                });
                if (remaining == 0) t.cancel();
              });
            }

            Future<void> sendOtp() async {
              final target = emailInput.text.trim().toLowerCase();
              if (!emailPattern.hasMatch(target)) {
                updateDialog(() => message = 'Enter a valid email address.');
                return;
              }
              if (changeEmail && target == _savedEmail) {
                updateDialog(() => message = 'Enter a different email address.');
                return;
              }
              updateDialog(() { busy = true; message = null; });
              try {
                final result = await UserRepository.requestEmailVerificationOtp(
                  email: target,
                  purpose: purpose,
                );
                if (!dialogContext.mounted) return;
                updateDialog(() {
                  busy = false;
                  if (result.success) {
                    sent = true;
                    otpInput.clear();
                    message = 'A 6-digit code was sent to $target.';
                  } else {
                    message = result.message ?? 'Unable to send code.';
                  }
                });
                if (result.success) startCooldown();
              } catch (_) {
                if (dialogContext.mounted) {
                  updateDialog(() { busy = false; message = 'Unable to send code. Try again.'; });
                }
              }
            }

            Future<void> confirmOtp() async {
              final target = emailInput.text.trim().toLowerCase();
              final otp = otpInput.text.trim();
              if (!RegExp(r'^\d{6}$').hasMatch(otp)) {
                updateDialog(() => message = 'Enter the 6-digit verification code.');
                return;
              }
              updateDialog(() { busy = true; message = null; });
              try {
                final result = await UserRepository.verifyEmailVerificationOtp(
                  email: target,
                  otp: otp,
                  purpose: purpose,
                );
                if (!dialogContext.mounted) return;
                if (result.success) {
                  completed = true;
                  Navigator.of(dialogContext).pop();
                } else {
                  updateDialog(() {
                    busy = false;
                    message = result.message ?? 'Invalid or expired code.';
                  });
                }
              } catch (_) {
                if (dialogContext.mounted) {
                  updateDialog(() { busy = false; message = 'Verification failed. Try again.'; });
                }
              }
            }


            return AlertDialog(
              title: Text(changeEmail ? 'Change Email' : 'Verify Email'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      changeEmail
                          ? 'We will send a verification code to your new email.'
                          : 'Verify your existing email address.',
                    ),
                    const SizedBox(height: 12),

// Email Address
                    TextField(
                      controller: emailInput,
                      readOnly: !changeEmail || sent,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                        border: OutlineInputBorder(),
                      ),
                    ),

// Allow editing the new email after OTP is sent.
                    if (changeEmail && sent) ...[
                      const SizedBox(height: 8),
                      TextButton.icon(
                        onPressed: busy
                            ? null
                            : () {
                          timer?.cancel();

                          updateDialog(() {
                            sent = false;
                            remaining = 0;
                            message = null;
                            otpInput.clear();
                          });
                        },
                        icon: const Icon(Icons.edit_outlined),
                        label: const Text('Edit Email Address'),
                      ),
                    ],

// OTP Section
                    if (sent) ...[
                      const SizedBox(height: 12),
                      TextField(
                        controller: otpInput,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(6),
                        ],
                        decoration: const InputDecoration(
                          labelText: '6-digit OTP',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 8),

// Resend OTP
                      TextButton(
                        onPressed: busy || remaining > 0 ? null : sendOtp,
                        child: Text(
                          remaining > 0
                              ? 'Resend in ${remaining}s'
                              : 'Resend Code',
                        ),
                      ),
                    ],

// Success / Error Message
                    if (message != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        message!,
                        style: const TextStyle(fontSize: 13, color: Colors.red),
                      ),
                    ],
                  ],
                ),
              ),

              actions: [
                TextButton(
                  onPressed: busy
                      ? null
                      : () => Navigator.of(dialogContext).pop(),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: busy
                      ? null
                      : (sent ? confirmOtp : sendOtp),
                  child: Text(
                    busy
                        ? 'Please wait...'
                        : sent
                        ? 'Confirm OTP'
                        : 'Send OTP',
                  ),
                ),
              ],
            );
          },
        ),
      );

    } finally {
      timer?.cancel();

// Allow the dialog's closing animation and widget cleanup
// to complete before disposing its TextEditingControllers.
      await Future<void>.delayed(const Duration(milliseconds: 350));

      emailInput.dispose();
      otpInput.dispose();

      if (mounted) {
        setState(() {
          _emailActionLoading = false;
        });
      }
    }

    if (!mounted || !completed) return;

    await _loadData();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          changeEmail
              ? 'Email changed and verified.'
              : 'Email verified successfully.',
        ),
      ),
    );
  }


  Future<void> _deleteAccount() async {
    bool? confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Confirm Deletion',
          ),
          content: const Text(
            'Are you sure you want to delete your account? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(
                false,
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(
                true,
              ),
              child: const Text(
                'Delete',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirmDelete != true) {
      return;
    }

    String? password = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        TextEditingController controller = TextEditingController();

        return AlertDialog(
          title: const Text(
            'Enter Password',
          ),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Your Password:',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(
                controller.text,
              ),
              child: const Text(
                'DELETE',
                style: TextStyle(
                  color: Color.fromARGB(
                    255,
                    182,
                    63,
                    63,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    if (password == null || password.isEmpty) {
      return;
    }

    setState(() {
      removeLoading = true;
    });

    final response = await UserRepository.removeAccount(
      password: password,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      removeLoading = false;
    });

    if (response.success && response.data == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Successfully removed your account!',
          ),
        ),
      );

      Navigator.of(context).pushReplacementNamed(
        '/login',
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            response.message ?? 'Error removing your account',
          ),
        ),
      );
    }
  }

  Future<void> _saveChanges() async {
    if (saveLoading) return;
    _validateProfileFields();
    if (_hasProfileErrors) return;

    final username = _userNameController.text.trim().toLowerCase();
    setState(() => saveLoading = true);
    try {
// Match Create Account's username availability check only when changed.
      if (username != _originalUsername) {
        final check = await UserRepository.checkUser(username: username);
        if (!mounted) return;
        if (!check.success) {
          setState(() {
            _usernameError = check.fieldErrors['username'] ??
                check.message ?? check.data ?? 'Username unavailable';
          });
          return;
        }
      }

      final response = await UserRepository.updateAccount(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        username: username,
        companyName: _companyNameController.text.trim(),
        phoneNumber: _phoneNumberController.text.trim(),
        email: _savedEmail,
      );
      if (!mounted) return;

      if (response.success && response.data == true) {
        _originalUsername = username;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully updated your account')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message ?? 'Error updating your account')),
        );
      }
    } catch (e) {
      if (kDebugMode) print(e);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unable to update your account. Please try again.')),
        );
      }
    } finally {
      if (mounted) setState(() => saveLoading = false);
    }
  }

  Future<void> _loadData() async {
    try {
      setState(() {
        loading = true;
      });

      final userResponse = await UserRepository.getUserInfo();

      if (userResponse.success && userResponse.data != null) {
        final data = userResponse.data!;

        _firstNameController.text = data['firstName']?.toString() ?? '';
        _lastNameController.text = data['lastName']?.toString() ?? '';
        _userNameController.text = data['username']?.toString() ?? '';
        _originalUsername = _userNameController.text.trim().toLowerCase();
        _companyNameController.text = data['companyName']?.toString() ?? '';
        _phoneNumberController.text = data['phoneNumber']?.toString() ?? '';
        _emailController.text =
            data['emailAddress']?.toString() ?? data['email']?.toString() ?? '';
        _savedEmail = _emailController.text.trim().toLowerCase();
        _emailVerified = data['emailVerified'] == true;
      }

      final cartResponse = await CartRepository.getOrders();

      int total = 0;

      if (cartResponse.success && cartResponse.data != null) {
        for (final order in cartResponse.data!) {
          if (order is Map) {
            total += int.tryParse(
              order['quantity']?.toString() ?? '0',
            ) ??
                0;
          }
        }
      }

      if (!mounted) {
        return;
      }

      setState(() {
        totalQuantities = total;

        loading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print(
          'Failed to load data: $e',
        );
      }

      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _userNameController.dispose();
    _companyNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(
      BuildContext context,
      )
  {
    return Scaffold(
      appBar: CustomAppBar(
        link: const ApplicationCatalogPage(),
        customIcon: Icons.description,
        cartItemCount: totalQuantities,
      ),
      drawer: const CustomDrawer(),
      body: loading == true
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader(
                'Personal Details:',
              ),
              const SizedBox(
                height: 10,
              ),
              _buildProfileCard(
                context,
                children: [
                  buildTextFieldWithIcon(
                    Icons.person,
                    'First Name:',
                    'Current: ${_firstNameController.text}',
                    context,
                    _firstNameController,
                    errorText: _firstNameError,
                    onChanged: (value) => setState(() => _firstNameError = _requiredMax(value, 'First name', 100)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  buildTextFieldWithIcon(
                    Icons.person,
                    'Last Name:',
                    'Current: ${_lastNameController.text}',
                    context,
                    _lastNameController,
                    errorText: _lastNameError,
                    onChanged: (value) => setState(() => _lastNameError = _requiredMax(value, 'Last name', 100)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  buildTextFieldWithIcon(
                    Icons.account_circle,
                    'Display Name:',
                    'Current: ${_userNameController.text}',
                    context,
                    _userNameController,
                    errorText: _usernameError,
                    onChanged: (value) => setState(() => _usernameError = value.trim().isEmpty ? 'Username is required' : value.trim().length < 6 ? 'Username must be at least 6 characters' : value.trim().length > 24 ? 'Username must be at most 24 characters' : null),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              _buildSectionHeader(
                'Company Information:',
              ),
              const SizedBox(
                height: 10,
              ),
              _buildProfileCard(
                context,
                children: [
                  buildTextFieldWithIcon(
                    Icons.business,
                    'Company Name:',
                    'Enter company name',
                    context,
                    _companyNameController,
                    errorText: _companyNameError,
                    onChanged: (value) => setState(() => _companyNameError = _requiredMax(value, 'Company name', 150)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  buildTextFieldWithIcon(
                    Icons.phone,
                    'Phone Number:',
                    'Enter phone number',
                    context,
                    _phoneNumberController,
                    errorText: _phoneNumberError,
                    onChanged: (value) => setState(() => _phoneNumberError = _phoneError(value)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  buildTextFieldWithIcon(
                    Icons.email,
                    'Email Address:',
                    'Enter email address',
                    context,
                    _emailController,
                    readOnly: true,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        _emailVerified ? Icons.verified : Icons.info_outline,
                        color: _emailVerified ? Colors.green : Colors.orange,
                        size: 19,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(_emailVerified ? 'Email Verified' : 'Email Not Verified'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (!_emailVerified)
                        OutlinedButton(
                          onPressed: _emailActionLoading ? null : () => _emailVerificationFlow(changeEmail: false),
                          child: const Text('Verify Email'),
                        ),
                      OutlinedButton(
                        onPressed: _emailActionLoading ? null : () => _emailVerificationFlow(changeEmail: true),
                        child: const Text('Change Email'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              _buildSectionHeader(
                'Privacy Policy',
              ),
              const SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: () async {
// const url = 'https://mightylube.com/privacy-consent-policy/';
                  const url = 'https://mightylube.com/privacy-consent-policy/';

                  if (await canLaunchUrl(
                    Uri.parse(
                      url,
                    ),
                  )) {
                    await launchUrl(
                      Uri.parse(
                        url,
                      ),
                      mode: LaunchMode.platformDefault,
                    );
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: const Text(
                  'View Privacy Policy',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
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
                  onPressed: () {
                    _saveChanges();
                  },
                  child: saveLoading == true
                      ? const Center(
                    child: CircularProgressIndicator(),
                  )
                      : const Text(
                    'Save Changes',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(
                        255,
                        197,
                        63,
                        63,
                      ),
                      Color.fromARGB(
                        255,
                        197,
                        63,
                        63,
                      ),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    _deleteAccount();
                  },
                  child: removeLoading == true
                      ? const Center(
                    child: CircularProgressIndicator(),
                  )
                      : const Text(
                    'Delete Account',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
      String title,
      ) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(
          255,
          0,
          0,
          0,
        ),
      ),
    );
  }

  Widget _buildProfileCard(
      BuildContext context, {
        required List<Widget> children,
      }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          15.0,
        ),
        child: Column(
          children: children,
        ),
      ),
    );
  }

  Widget buildTextFieldWithIcon(
      IconData icon,
      String label,
      String hint,
      BuildContext context,
      TextEditingController controller, {
        bool obscureText = false,
        bool readOnly = false,
        String? errorText,
        ValueChanged<String>? onChanged,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextField(
          controller: controller,
          obscureText: obscureText,
          readOnly: readOnly,
          onChanged: onChanged,
          keyboardType: controller == _phoneNumberController ? TextInputType.phone : null,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: Colors.black,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            filled: true,
            fillColor: const Color.fromARGB(
              132,
              255,
              255,
              255,
            ),
            hintText: hint,
            errorText: errorText,
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}