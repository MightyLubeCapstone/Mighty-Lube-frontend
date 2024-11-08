import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Consistent with the LoginPage header
          ),
        ),
        backgroundColor: const Color(0xFF579AF6),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader('Personal Details'),
              const SizedBox(height: 10),
              _buildProfileCard(
                context,
                children: [
                  buildTextFieldWithIcon(
                      Icons.person, 'First Name:', 'Enter first name', context),
                  const SizedBox(height: 15),
                  buildTextFieldWithIcon(
                      Icons.person, 'Last Name:', 'Enter last name', context),
                  const SizedBox(height: 15),
                  buildTextFieldWithIcon(
                      Icons.account_circle, 'Display Name:', 'Enter display name', context),
                ],
              ),
              const SizedBox(height: 20),
              _buildSectionHeader('Company Information'),
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
              _buildSectionHeader('Password Change'),
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
                  buildTextFieldWithIcon(
                      Icons.lock_outline, 'Confirm Password:', 'Confirm new password', context,
                      obscureText: true),
                ],
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

  Widget buildTextFieldWithIcon(
      IconData icon, String label, String hint, BuildContext context,
      {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500, // Match the weight in LoginPage
            color: Colors.black, // Match the text color in LoginPage
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.black), // Add color for consistency
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            filled: true,
            fillColor: const Color.fromARGB(170, 255, 255, 255), // Match the input box color in LoginPage
            hintText: hint,
            hintStyle: const TextStyle(
              color: Colors.grey, // Match hint text color in LoginPage
            ),
          ),
        ),
      ],
    );
  }
}


