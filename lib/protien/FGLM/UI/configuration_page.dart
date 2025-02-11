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
  final TextEditingController conveyorLength = TextEditingController();
  final TextEditingController conveyorSpeed = TextEditingController();
  final TextEditingController conveyorIndex = TextEditingController();
  final TextEditingController operatingVoltage = TextEditingController();
  final TextEditingController conductor4 = TextEditingController();
  final TextEditingController conductor7 = TextEditingController();
  final TextEditingController conductor2 = TextEditingController();

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
              buildGradientButton(context, 'New/Adding to Existing Monitoring System',
                  buildNewMonitoringSystem()),
              buildGradientButton(context, 'Monitoring Features Requested',
                   buildMonitoringFeatures()),   
              buildGradientButton(context, 'Conveyor Specifications',
                  buildConveyorSpecifications()),
              buildGradientButton(context, 'Wire',
                  buildWire()),
            ],
          ),
        ),
        const SizedBox(height: 20),
        buildCounterSection(),
        const SizedBox(height: 20),
        buildGradientConfiguratorButton(),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget buildGradientButton(
      BuildContext context, String title, Widget content) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [Color(0xFF73A1F9), Color(0xFF4D86F5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            builder: (context) => FractionallySizedBox(
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
                          width: 40,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
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
          );
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
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
        buildDropdownField('Chain Pin Type', [
          'Bolts',
          'Pin',
          'Log',
        ]),
        buildTextField('Enter Number Here',conveyorLength),
        buildDropdownField('Conveyor Length Unit', [
          'Feet',
          'Inches',
          'm Meter',
          'mm Milimeter'
        ]),
        buildTextField('Enter Conveyor Speed (Min/Max)',conveyorSpeed),
        buildDropdownField('Conveyor Speed Unit', [
          'Feet/Minute',
          'Meter/Minute',
        ]),
        buildTextField('Indexing or Variable Speed Conditions',conveyorIndex),
        buildDropdownField('Direction of Travel', [
          'Right to Left',
          'Left to Right',
        ]),
        buildDropdownField('What Type of Metal', [
          'Stainless Steel',
          'Zinc',
          'Mild Steel',
          'Other'
        ]),
        buildDropdownField('Style of Conveyor', [
          'I-Beam',
          'Meyn',
          'Sani Track',
          'T Rail',
          'Other'
        ]),
        buildDropdownField('Color of Trolley', [
          'Blue',
          'Green',
          'Grey',
          'Other'
        ]),
        buildDropdownField('Type of Trolly', [
          'Meyn Trolley Halve Green Wheel Bolt Version',
          'Meyn Plastic Click Version',
          'Meyn Stainless Steel Halve w/ Green Wheel',
          'Meyn Stainless Stell Halve Gray Wheel',
          'Stork Halve Bolt Version Blue Wheel',
          'Linco Plastic Halve Blue Wheel'
        ]),
        buildDropdownField('Temperature of Surrounding Area at Planned Location of Lubrication System it below 30°F or above 120°F?', [
          'Yes',
          'No'
        ]),
        buildDropdownField('Is the Conveyor Loaded or Unloaded at Planned Install Location? *', [
          'Loaded',
          'Unloaded'
        ]),
        buildDropdownField('Does Conveyor Swing, Sway, Surge, or Move Side-to-Side *', [
          'Yes',
          'No'
        ]),
        buildDropdownField('I Have A Plant Layout To Attach', [
          'Yes - Will Attach',
          'No - Do Not Have'
        ]),
        buildDropdownField('I Have The Required Pictures Of Each Chain To Attach', [
          'Yes - Will Attach',
          'No - Do Not Have'
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
        buildTextField('Operating Voltage - Single Phase: (Volts/hz] *',operatingVoltage),
        buildSectionDivider(),
      ],
    );
  }

  Widget buildNewMonitoringSystem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSectionDivider(),
        buildDropdownField('Connecting to Existing Monitoring', [
          'Yes',
          'No'
        ]),
        buildDropdownField('Add New Monitoring System', [
          'Yes',
          'No'
        ]),
        buildSectionDivider(),
      ],
    );
  }

  Widget buildMonitoringFeatures() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSectionDivider(),
        buildDropdownField('Drive Motor Amp', [
          'Yes',
          'No'
        ]),
        buildDropdownField('Drive Take-up-Air', [
          'Yes',
          'No'
        ]),
        buildDropdownField('Take-Up Distance', [
          'Yes',
          'No'
        ]),
        buildDropdownField('Drive Motor Temp', [
          'Yes',
          'No'
        ]),
        buildDropdownField('Drive Motor Vibration', [
          'Yes',
          'No'
        ]),
        buildDropdownField('Bent or Missing Trolley detect', [
          'Yes',
          'No'
        ]),
        buildSectionDivider(),
      ],
    );
  }

  Widget buildConveyorSpecifications() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSectionDivider(),
        buildDropdownField('Lubrication from the Side of Chain', [
          'Yes',
          'No'
        ]),
        buildDropdownField('Lubrication from the Top of Chain', [
          'Yes',
          'No'
        ]),
        buildDropdownField('Is the Conveyor Chain Clean?', [
          'Yes',
          'No'
        ]),
        buildSectionDivider(),
      ],
    );
  }
  
  Widget buildWire() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSectionDivider(),
        buildDropdownField('Measurement Units', [
          'Feet',
          'Inches', 
          'm Meter', 
          'mm Milimeter'
        ]),
        buildTextField('Enter 4 Conductor Number Here',conductor4),
        buildTextField('Enter 7 Conductor Number Here',conductor7),
        buildTextField('Enter 2 Conductor Number Here',conductor2),
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

  Widget buildCounterSection() {
    return Row(
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
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
    );
  }

  Widget buildGradientConfiguratorButton() {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.7, // Shorter width
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [Color(0xFF73A1F9), Color(0xFF4D86F5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
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
          ),
        ),
      ),
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
          icon: const Icon(Icons.home, color: Colors.blue),
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
