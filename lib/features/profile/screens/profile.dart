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

  int totalQuantities = 0;

  bool loading = false;

  bool removeLoading = false;

  bool saveLoading = false;

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
    try {
      setState(() {
        saveLoading = true;
      });

      final response = await UserRepository.updateAccount(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        username: _userNameController.text,
        companyName: _companyNameController.text,
        phoneNumber: _phoneNumberController.text,
        email: _emailController.text,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        saveLoading = false;
      });

      if (response.success && response.data == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Successfully updated your account',
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response.message ?? 'Error updating your account',
            ),
          ),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      if (mounted) {
        setState(() {
          saveLoading = false;
        });
      }
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
        _companyNameController.text = data['companyName']?.toString() ?? '';
        _phoneNumberController.text = data['phoneNumber']?.toString() ?? '';
        _emailController.text =
            data['emailAddress']?.toString() ?? data['email']?.toString() ?? '';
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
      ) {
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
                  const url =
                      'https://mightylube.com/privacy-consent-policy/';

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
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}