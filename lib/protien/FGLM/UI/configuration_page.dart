import 'package:flutter/material.dart';
import 'package:mighty_lube/protien/FGLM/API/flgm_api.dart';

class ConfigurationSection extends StatefulWidget {
  const ConfigurationSection({super.key});

  @override
  State<ConfigurationSection> createState() => _ConfigurationSectionState();
}

class _ConfigurationSectionState extends State<ConfigurationSection> {
  final controllers = FormAPI().controllers;
  final formData = FormAPI().formData;
  String? conveyorLengthUnit = FormAPI().conveyorLengthUnit;
  String? conveyorSpeedUnit = FormAPI().conveyorSpeedUnit;

  void formCall() async {
    final success = await FormAPI().fglmForm();
    if (success) {
      print('Successfully added FGLM data');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Successfully added data'),
        ),
      );
    } else {
      print('Failed to add FGLM data');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to add data'),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    controllers.forEach((key, controller) {
      controller.addListener(() {
        formData[key] = controller.text;
      });
    });
  }

  @override
  void dispose() {
    controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [
        buildGradientButton(context, 'General Information'),
        buildGradientButton(context, 'Customer Power Utilities'),
        buildGradientButton(context, 'Monitoring Features Requested'),
        buildGradientButton(context, 'Conveyor Specifications'),
        buildGradientButton(context, 'Wire'),
        buildGradientButton(context, 'Measurement'),
      ],
    );
  }

  // Create gradient buttons
  Widget buildGradientButton(BuildContext context, String title) {
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
          if (title == 'General Information') {
            // Show detailed form for General Information
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (context) => FractionallySizedBox(
                heightFactor: 0.90, // Ensures 90% of the screen is used
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
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'General Information',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        buildFormSections(), // Form sections with dividers
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
                          child: const Text('Save'),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
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
            ),
          ),
        ),
      ),
    );
  }

  // Build form sections with dividers
  Widget buildFormSections() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSectionTitle('Conveyor Details'),
        buildTextField('Name of Conveyor System', 'conveyorName'),
        buildTextField('Conveyor Chain Size', 'conveyorChainSize'),
        buildTextField('Protein: Chain Manufacturer', 'chainManufacturer'),
        buildTwoFieldRow(
          buildTextField('Wheel Manufacturer', 'wheelManufacturer'),
          buildTextField('Chain Pin Type *', 'chainPinType'),
        ),
        buildSectionDivider(),
        buildSectionTitle('Conveyor Dimensions & Speed'),
        buildTwoFieldRow(
          buildTextField('Conveyor Length', 'conveyorLength'),
          buildDropdownField('Conveyor Length Unit', ['Feet', 'Meters'],
              (value) {
            setState(() {
              conveyorLengthUnit = value;
              formData['conveyorLengthUnit'] = value;
            });
          }),
        ),
        buildTwoFieldRow(
          buildTextField('Conveyor Speed (Min/Max)', 'conveyorSpeed'),
          buildDropdownField(
              'Conveyor Speed Unit', ['Feet / minute', 'Meters / minute'],
              (value) {
            setState(() {
              conveyorSpeedUnit = value;
              formData['conveyorSpeedUnit'] = value;
            });
          }),
        ),
        buildSectionDivider(),
        buildSectionTitle('Conveyor Movement Details'),
        buildTwoFieldRow(
          buildTextField('Indexing or Variable Speed Conditions', 'indexing'),
          buildTextField('Direction of Travel', 'directionOfTravel'),
        ),
        buildSectionDivider(),
        buildSectionTitle('Conveyor Material & Style'),
        buildTwoFieldRow(
          buildTextField('What Type of Metal *', 'metalType'),
          buildTextField('Style of Conveyor *', 'conveyorStyle'),
        ),
        buildTwoFieldRow(
          buildTextField('Color of Trolley *', 'trolleyColor'),
          buildTextField('Type of Trolley *', 'trolleyType'),
        ),
        buildSectionDivider(),
        buildSectionTitle('Environmental Details'),
        buildTextField('Application Environment *', 'applicationEnvironment'),
        buildTextField('Temperature of Surrounding Area', 'temperature'),
        buildTwoFieldRow(
          buildTextField('Is the Conveyor Loaded or Unloaded? *', 'loaded'),
          buildTextField(
              'Does Conveyor Swing, Sway, Surge, or Move Side-to-Side *',
              'swing'),
        ),
        buildSectionDivider(),
        buildSectionTitle('Attachments'),
        buildTextField('I Have A Plant Layout To Attach', 'plantLayout'),
        buildTextField('I Have The Required Pictures Of Each Chain To Attach',
            'chainPictures'),
      ],
    );
  }

  // Helper to build a section title
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

  // Helper to build a section divider
  Widget buildSectionDivider() {
    return const Divider(
      color: Colors.grey,
      thickness: 1,
      height: 30,
    );
  }

  // Helper to build a single text field
  Widget buildTextField(String hint, String key) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextField(
        controller: controllers[key],
        decoration: InputDecoration(
          labelText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  // Helper to build a row with two fields
  Widget buildTwoFieldRow(Widget first, Widget second) {
    return Row(
      children: [
        Expanded(child: first),
        const SizedBox(width: 10),
        Expanded(child: second),
      ],
    );
  }

  // Helper to build a dropdown field
  Widget buildDropdownField(
      String label, List<String> options, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        value: formData[label],
        items: options
            .map((option) => DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
