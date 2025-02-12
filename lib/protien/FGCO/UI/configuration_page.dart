import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/protien/protienHome.dart';

class ConfigurationSection extends StatefulWidget {
  const ConfigurationSection({super.key});

  @override
  State<ConfigurationSection> createState() => _ConfigurationSectionState();
}

class _ConfigurationSectionState extends State<ConfigurationSection> {
  int itemCount = 1; // Default count
  final TextEditingController conveyorSystem = TextEditingController();
  final TextEditingController conveyorVolts = TextEditingController();
  final TextEditingController conveyorOptions = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildBreadcrumbNavigation(context),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              buildGradientButton(context, 'General Information',
                  buildGeneralInformationContent()),
              buildGradientButton(context, 'Customer Power Utilities',
                  buildCustomerPowerUtilitiesContent()),
              buildGradientButton(context, 'OP-SS',
                  buildOPSS()),
              buildGradientButton(context, 'Additional Options Avaliable',
                  buildAdditional()),
            ],
          ),
        ),
        const SizedBox(height: 20),
        buildCounterWithConfiguratorButton(),
        const SizedBox(height: 20),
      ],
    );
  }


  Widget buildGradientButton(BuildContext context, String title, Widget content) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    height: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      border: Border.all(
        color: Colors.white.withOpacity(0.8), // Border color
        width: 2, // Border width
      ),
      gradient: const LinearGradient(
        colors: [Color(0xFF73A1F9), Color(0xFF4D86F5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 12,
          offset: const Offset(0, 6), // Deeper shadow
        ),
        BoxShadow(
          color: Colors.white.withOpacity(0.2),
          blurRadius: 5,
          offset: const Offset(-2, -2), // Subtle top-left light effect
        ),
      ],
    ),
    child: TextButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) => Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFF3F4F6), Color(0xFFE0E4E7)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: FractionallySizedBox(
              heightFactor: 0.90,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Center(
                        child: Container(
                          width: 50,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 20),
                      content,
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),
    ),
  );
}
  



  Widget buildGeneralInformationContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTextField('Name of Conveyor System',conveyorSystem),
        buildSectionDivider(),
        buildSectionTitle('Conveyor Details'),
        buildDropdownField('Conveyor Chain Size', [
          'X348 Chain (3”)',
          'X458 Chain (4”)',
          'OX678 Chain (6”)',
          '3/8" Log Chain'
          'Other'
        ]),
        buildDropdownField('Protein: Chain Manufacturer', [
          'Green Line',
          'Frost',
          'M&M',
          'Stork',
          'Meyn',
          'Linco',
          'DC',
          'Merel',
          'D&F',
          'Other'
        ]),
        buildDropdownField('Is the Conveyor Loaded or Unloaded at Planned Install Location?', [
          'Loaded',
          'Unloaded'
        ]),
        buildDropdownField('Is this a Drip Line?', [
          'Yes',
          'No'
        ]),
        buildSectionDivider(),
      ],
    );
  }

  Widget buildCustomerPowerUtilitiesContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSectionDivider(),
        buildTextField('Enter Operating Voltage - 3 Phase: (Volts/hz)',conveyorVolts),
        buildSectionDivider(),
      ],
    );
  }

  Widget buildOPSS() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSectionDivider(),
        buildDropdownField('Confirm Installation Clearance of: Minimum of 2" (.61m) for Clearance fo Moter Height from Rail AND Motor Gear Housing assembly width', [
          'Yes',
          'No'
        ]),
        buildSectionDivider(),
      ],
    );
  }

Widget buildAdditional() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSectionDivider(),
        buildDropdownField(' 3-Station Push Button Switch', [
          'Yes',
          'No'
        ]),
        buildDropdownField('Totally Enclosed Food-Grade Metal Shroud', [
          'Yes',
          'No'
        ]),
        buildTextField('Enter Other Information Here: ',conveyorOptions),
        buildSectionDivider(),
      ],
    );
  }





  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  Widget buildSectionDivider() {
    return const Divider(
      color: Colors.grey,
      thickness: 1,
      height: 30,
    );
  }

  Widget buildDropdownField(String label, List<String> options) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        items: options
            .map((option) => DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                ))
            .toList(),
        onChanged: (value) {},
      ),
    );
  }

  Widget buildCounterWithConfiguratorButton() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      // Counter Section
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                if (itemCount > 1) itemCount--;
              });
            },
            icon: const Icon(Icons.remove_circle_outline,
                color: Colors.blue, size: 30),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              '$itemCount',
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                itemCount++;
              });
            },
            icon: const Icon(Icons.add_circle_outline,
                color: Colors.blue, size: 30),
          ),
        ],
      ),

      const SizedBox(height: 15), // Spacing between counter and button

      // Gradient Button
      Container(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Colors.white.withOpacity(0.8), // Border color
            width: 2, // Border width
          ),
          gradient: const LinearGradient(
            colors: [Color(0xFF73A1F9), Color(0xFF4D86F5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 6), // Deeper shadow
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(-2, -2), // Subtle top-left light effect
            ),
          ],
        ),
        child: TextButton(
          onPressed: () {
            // Add your "Add to Configurator" logic here
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text(
            'ADD TO CONFIGURATOR',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    ],
  );
}

  Widget buildTextField(String hintText, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15.0), // Padding applied correctly
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0), // Adds rounded corners
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0), // Ensures consistent style
          borderSide: const BorderSide(color: Colors.grey), // Default border color
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0), // Rounded corners when focused
          borderSide: const BorderSide(color: Colors.blue, width: 2.0), // Highlight color
        ),
      ),
    ),
  );
}
}

Widget buildBreadcrumbNavigation(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      children: [
        IconButton(
          icon: const Icon(Icons.home, color: Color(0xFF579AF6),),
          onPressed: () {
            // Navigate to the home page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ApplicationPage()),
            );
          },
        ),
        const Text(' > '),
        GestureDetector(
          onTap: () {
            // Navigate to the Protein page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProteinHome()),
            ); // Replace with navigation to your Protein page
          },
          child: const Text(
            'Products',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    ),
  );
}
