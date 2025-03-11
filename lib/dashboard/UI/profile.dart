import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mighty_lube/api.dart';
import 'package:mighty_lube/app_bar.dart';
import 'package:mighty_lube/application/UI/application_home.dart';
import 'package:mighty_lube/drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _userNameController = TextEditingController();
  int totalQuantities = 0;
  bool loading = false;
  bool removeLoading = false;

  void _deleteAccount() async {
    bool? confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Deletion"),
          content: const Text(
              "Are you sure you want to delete your account? This action cannot be undone."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // Cancel deletion
              child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true), // Confirm deletion
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
    if (confirmDelete == false) return;
    String? password = await showDialog<String>(
      // ignore: use_build_context_synchronously
      context: context,
      builder: (BuildContext context) {
        TextEditingController controller = TextEditingController();
        return AlertDialog(
          title: const Text("Enter Password"),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: "Your Password:"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(controller.text),
              child:
                  const Text("DELETE", style: TextStyle(color: Color.fromARGB(255, 182, 63, 63))),
            ),
          ],
        );
      },
    );
    if (password == null || password == "") return;
    setState(() {
      removeLoading = true;
    });
    bool status = await UserAPI().removeAccount(password);
    setState(() {
      removeLoading = false;
    });
    if (status == true) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully removed your account!')),
      );
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacementNamed("/login");
    }
  }

  Future<void> _loadData() async {
    try {
      setState(() {
        loading = true;
      });
      final data = await UserAPI().getUserInfo();

      if (data != null) {
        _firstNameController.text = data['firstName'] ?? '';
        _lastNameController.text = data['lastName'] ?? '';
        _userNameController.text = data['username'] ?? '';
      }

      dynamic cart = await CartAPI().getOrders();
      for (var order in cart) {
        totalQuantities = order["quantity"] as int;
      }
      setState(() {
        loading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Failed to load data: $e');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        link: const ApplicationPage(),
        customIcon: Icons.description,
        cartItemCount: totalQuantities,
      ),
      drawer: const CustomDrawer(),
      body: (loading == true)
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader('Personal Details:'),
                    const SizedBox(height: 10),
                    _buildProfileCard(
                      context,
                      children: [
                        buildTextFieldWithIcon(Icons.person, 'First Name:',
                            'Current: ${_firstNameController.text}', context),
                        const SizedBox(height: 15),
                        buildTextFieldWithIcon(Icons.person, 'Last Name:',
                            'Current: ${_lastNameController.text}', context),
                        const SizedBox(height: 15),
                        buildTextFieldWithIcon(Icons.account_circle, 'Display Name:',
                            'Current: ${_userNameController.text}', context),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildSectionHeader('Company Information:'),
                    const SizedBox(height: 10),
                    _buildProfileCard(
                      context,
                      children: [
                        buildTextFieldWithIcon(
                            Icons.business, 'Company Name:', 'Enter company name', context),
                        const SizedBox(height: 15),
                        buildTextFieldWithIcon(
                            Icons.phone, 'Phone Number:', 'Enter phone number', context),
                        const SizedBox(height: 15),
                        buildTextFieldWithIcon(
                            Icons.email, 'Email Address:', 'Enter email address', context),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildSectionHeader('Password Change:'),
                    const SizedBox(height: 10),
                    _buildProfileCard(
                      context,
                      children: [
                        buildTextFieldWithIcon(
                            Icons.lock, 'Current Password:', 'Enter current password', context,
                            obscureText: true),
                        const SizedBox(height: 15),
                        buildTextFieldWithIcon(
                            Icons.lock_outline, 'New Password:', 'Enter new password', context,
                            obscureText: true),
                        const SizedBox(height: 15),
                        buildTextFieldWithIcon(Icons.lock_outline, 'Confirm Password:',
                            'Confirm new password', context,
                            obscureText: true),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildSectionHeader('Privacy Policy'),
                    const SizedBox(height: 8), // Add spacing
                    GestureDetector(
                      onTap: () async {
                        const url = 'https://mightylube.com/privacy-consent-policy/';
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(Uri.parse(url), mode: LaunchMode.platformDefault);
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
                    const SizedBox(height: 30),
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
                          // Add Save functionality
                        },
                        child: const Text(
                          'Save Changes',
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
                          colors: [
                            Color.fromARGB(255, 197, 63, 63),
                            Color.fromARGB(255, 197, 63, 63)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          _deleteAccount();
                        },
                        child: (removeLoading == true)
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
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        // Add Cancel functionality
                        Navigator.pop(context);
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

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 0, 0, 0),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, {required List<Widget> children}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: children,
        ),
      ),
    );
  }

  Widget buildTextFieldWithIcon(IconData icon, String label, String hint, BuildContext context,
      {bool obscureText = false}) {
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
        const SizedBox(height: 8),
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            filled: true,
            fillColor: const Color.fromARGB(132, 255, 255, 255),
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
