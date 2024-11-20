import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dropdown_search/dropdown_search.dart';

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
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
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
                    buildTextField('Company Name:*', 'Company Name'),
                    const SizedBox(height: 15),
                    const Text('Name:*'),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: buildTextField('', 'First Name'),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: buildTextField('', 'Last Name'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    buildTextField('Phone Number:', 'Phone Number'),
                    const SizedBox(height: 15),
                    buildTextField('Email Address:*', 'Email Address'),
                    const SizedBox(height: 15),
                    buildTextField('Username:*', 'Username'),
                    const SizedBox(height: 15),
                    buildTextField('Password:*', 'Enter Password',obscureText: true),
                    const SizedBox(height: 15),
                    buildTextField('', 'Confirm Password', obscureText: true),
                    const SizedBox(height: 15),
                    const Text('Country:'),
                    const SizedBox(height: 8),
                    DropdownSearch<String>(
                      items: _countries,
                      selectedItem: null,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: 'Country',
                          hintText: 'Type or select a country',
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Color(0xFF4D86F5),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      popupProps: PopupProps.dialog(
                        showSearchBox: true,
                        searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                            hintText: 'Search countries...',
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                        fit: FlexFit.tight,
                        dialogProps: DialogProps(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        print('Selected country: $value');
                      },
                    ),
                    const SizedBox(height: 30),
                    buildGradientButton('Register', () {
                      // Register functionality
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
  Widget buildTextField(String label, String hint, {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) Text(label),
        const SizedBox(height: 8),
        TextField(
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

