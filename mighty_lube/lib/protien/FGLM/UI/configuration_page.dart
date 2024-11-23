import 'package:flutter/material.dart';

class ConfigurationSection extends StatelessWidget {
  const ConfigurationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [
        buildGradientButton(context, 'General Information', buildGeneralInformationContent()),
        buildGradientButton(context, 'Customer Power Utilities', buildCustomerPowerUtilitiesContent()),
        buildGradientButton(context, 'New/Adding Monitoring System', buildNewMonitoringSystemContent()),
        buildGradientButton(context, 'Monitoring Features Requested', buildMonitoringFeaturesContent()),
        buildGradientButton(context, 'Conveyor Specifications', buildConveyorSpecificationsContent()),
        buildGradientButton(context, 'Wire', buildWireContent()),
      ],
    );
  }

  Widget buildGradientButton(BuildContext context, String title, Widget content) {
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
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
                          width: 50,
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
                          fontSize: 18,
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
                        child: const Text('Save'),
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

  Widget buildGeneralInformationContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSectionTitle('Conveyor Details'),
        buildTextField('Name of Conveyor System'),
        buildTextField('Conveyor Chain Size'),
        buildTextField('Protein: Chain Manufacturer'),
        buildTwoFieldRow(
          buildTextField('Wheel Manufacturer'),
          buildTextField('Chain Pin Type *'),
        ),
        buildSectionDivider(),
        buildSectionTitle('Conveyor Dimensions & Speed'),
        buildTwoFieldRow(
          buildTextField('Conveyor Length'),
          buildDropdownField('Conveyor Length Unit', ['Feet', 'Meters']),
        ),
        buildTwoFieldRow(
          buildTextField('Conveyor Speed (Min/Max)'),
          buildDropdownField(
              'Conveyor Speed Unit', ['Feet / minute', 'Meters / minute']),
        ),
        buildSectionDivider(),
        buildSectionTitle('Conveyor Movement Details'),
        buildTwoFieldRow(
          buildTextField('Indexing or Variable Speed Conditions'),
          buildTextField('Direction of Travel'),
        ),
        buildSectionDivider(),
        buildSectionTitle('Conveyor Material & Style'),
        buildTwoFieldRow(
          buildTextField('What Type of Metal *'),
          buildTextField('Style of Conveyor *'),
        ),
        buildTwoFieldRow(
          buildTextField('Color of Trolley *'),
          buildTextField('Type of Trolley *'),
        ),
        buildSectionDivider(),
        buildSectionTitle('Environmental Details'),
        buildTextField('Temperature of Surrounding Area'),
        buildTwoFieldRow(
          buildTextField('Is the Conveyor Loaded or Unloaded? *'),
          buildTextField(
              'Does Conveyor Swing, Sway, Surge, or Move Side-to-Side *'),
        ),
        buildSectionDivider(),
        buildSectionTitle('Attachments'),
        buildTextField('I Have A Plant Layout To Attach'),
        buildTextField('I Have The Required Pictures Of Each Chain To Attach'),
      ],
    );
  }

  Widget buildCustomerPowerUtilitiesContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTextField('Operating Voltage - Single Phase: (Volts/hz)'),
      ],
    );
  }

  Widget buildNewMonitoringSystemContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTextField('Connecting to Existing Monitoring'),
        buildTextField('Add New Monitoring System'),
      ],
    );
  }

  Widget buildMonitoringFeaturesContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTextField('Drive Motor Amp'),
        buildTextField('Drive Take-up – Air'),
        buildTextField('Take-Up Distance'),
        buildTextField('Bent or Missing Trolley Detect'),
        buildTextField('Lubrication from the Side of Chain'),
        buildTextField('Lubrication from the Top'),
      ],
    );
  }

  Widget buildConveyorSpecificationsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTextField('Lubrication from the Side of Chain'),
        buildTextField('Lubrication from the Top of Chain'),
        buildTextField('Time Lubrication'),
        buildTextField('Reservoir Size'),
        buildTextField('Is the Conveyor Chain Clean?'),
        buildTextField('Reservoir Size Quantity'),
        buildTextField('Time Delay Lubrication'),
      ],
    );
  }

  Widget buildWireContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTextField('Measurement Unit'),
        buildTextField('4 Conductor'),
        buildTextField('7 Conductor'),
        buildTextField('2 Conductor'),
        buildTextField('Is the Conveyor Chain Clean?'),
        buildTextField('Reservoir Size Quantity'),
        buildTextField('Time Delay Lubrication'),
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

  Widget buildTextField(String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget buildTwoFieldRow(Widget first, Widget second) {
    return Row(
      children: [
        Expanded(child: first),
        const SizedBox(width: 10),
        Expanded(child: second),
      ],
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
}
