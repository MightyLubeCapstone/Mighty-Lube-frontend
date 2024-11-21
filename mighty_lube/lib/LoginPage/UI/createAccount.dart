import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:mighty_lube/LoginPage/API/app_state.dart';

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

  List<String> _countries = [];

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }
  // Load countries dynamically from a JSON file
  Future<void> _loadCountries() async {
    final String response = await rootBundle.loadString('assets/countries.json');
    final List<dynamic> data = json.decode(response);
    setState(() {
      _countries = data.cast<String>();
    });
  }

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
                      DropdownSearch<String>(
                      items: _countries, // List of countries
                      selectedItem: countrytype,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200], // Softer background color
                          hintText: 'Select Country',
                          hintStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey, // Subtle hint text
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                            labelText: 'Search Country', // Label for the search box
                            labelStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey, // Text color for the label
                            ),
                            hintText: 'Type to search...', // Placeholder text
                            hintStyle: TextStyle(
                              color: Colors.grey, // Lighter color for the placeholder
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black, // Text color for user input
                          ),
                        ),
                        itemBuilder: (context, item, isSelected) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            child: Text(
                              item,
                              style: TextStyle(
                                fontSize: 16,
                                color: isSelected ? Colors.blue : Colors.black, // Highlight selected item
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          );
                        },
                      ),
                      dropdownBuilder: (context, selectedItem) {
                        return Text(
                          selectedItem ?? "Select Country",
                          style: const TextStyle(fontSize: 16, color: Colors.black),
                        );
                      },
                      filterFn: (item, filter) {
                        return item.toLowerCase().startsWith(filter.toLowerCase());
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
