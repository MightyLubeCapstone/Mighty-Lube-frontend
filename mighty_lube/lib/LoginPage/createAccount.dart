import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mighty_lube/app_state.dart';

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180, // Increased height for a larger logo area
      color: const Color.fromARGB(255, 87, 154, 246),
      child: Center(
        child: SvgPicture.asset(
          'assets/WhiteML_Logo-w-tag-vector.svg',
          width: 150, // Increased width for a larger logo
          height: 150,
          color: const Color.fromARGB(255, 249, 249, 250),
        ),
      ),
    );
  }
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

  String? countrytype;

  Future<void> createAccount(BuildContext context) async {
    final companyName = companyController.text;
    final firstName = firstNameController.text;
    final lastName = lastNameController.text;
    final phoneNumber = phoneController.text;
    final email = emailController.text;
    final username = usernameController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (password != confirmPassword) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                  title: const Text('Error'),
                  content: const Text('Passwords do not match'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Ok'),
                    )
                  ]));
      return;
    }

    try {
      bool success = await ApiState().makeAccount(username, password, firstName,
          lastName, email, phoneNumber, companyName, countrytype ?? "");

      print(success);
      print(firstName);
      print(lastName);
      print(phoneNumber);
      print(email);
      print(username);
      print(password);
      print(countrytype);

      if (success) {
        Navigator.pushNamed(context, '/dashboard');
      } else {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                    title: const Text('Error'),
                    content:
                        const Text(' Error 1: '), //testing error, will change
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
                  content:
                      const Text(' Error 2 :'), //testing error, will change
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
          const HeaderLogo(),
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
                      color: Colors.black.withOpacity(0.1),
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
                        'Company Name:*', 'Company Name', companyController),
                    const SizedBox(height: 15),
                    const Text('Name:*'),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: buildTextField(
                              '', 'First Name', firstNameController),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: buildTextField(
                              '', 'Last Name', lastNameController),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    buildTextField(
                        'Phone Number:', 'Phone Number', phoneController),
                    const SizedBox(height: 15),
                    buildTextField(
                        'Email Address:*', 'Email Address', emailController),
                    const SizedBox(height: 15),
                    buildTextField(
                        'Username:*', 'Username', usernameController),
                    const SizedBox(height: 15),
                    buildTextField(
                        'Password:*', 'Enter Password', passwordController,
                        obscureText: true),
                    const SizedBox(height: 15),
                    buildTextField(
                        '', 'Confirm Password', confirmPasswordController,
                        obscureText: true),
                    const SizedBox(height: 15),
                    const Text('Country:'),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: countrytype,
                      items: const [
                        DropdownMenuItem(value: 'USA', child: Text('USA')),
                        DropdownMenuItem(
                            value: 'Canada', child: Text('Canada')),
                        DropdownMenuItem(value: 'UK', child: Text('UK')),
                      ],
                      onChanged: (value) {
                        countrytype = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: 'Select Country',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 20),
                      ),
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
      {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) Text(label),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            filled: true,
            fillColor: Colors.grey[100],
            hintText: hint,
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
          colors: [Color(0xFF73A1F9), Color(0xFF4D86F5)],
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
