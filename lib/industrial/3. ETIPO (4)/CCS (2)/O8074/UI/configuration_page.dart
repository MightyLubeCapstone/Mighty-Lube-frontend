import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/industrial/3.%20ETIPO%20(4)/CCS%20(2)/products.dart';
import 'package:mighty_lube/helper_widgets.dart';


class ConfigurationSection extends StatefulWidget {
  const ConfigurationSection({super.key});

  @override
  State<ConfigurationSection> createState() => _ConfigurationSectionState();
}


class _ConfigurationSectionState extends State<ConfigurationSection> {
  int itemCount = 1; // Default count
  final TextEditingController conveyorSystem = TextEditingController();
  final TextEditingController conveyorLength = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonWidgets.buildBreadcrumbNavigation(context,'>',const ApplicationPage(),'Products',const CCSProducts()),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              CommonWidgets.buildGradientButton(context, 'General Information',buildGeneralInformationContent()),
            ],
          ),
        ),
       
        CommonWidgets.buildConfiguratorWithCounter(),
        const SizedBox(height: 20),
      ],
    );
  }

//actual buttons w/ the questions :) 

  Widget buildGeneralInformationContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionTitle('Conveyor Details'),
        CommonWidgets.buildTextField('Enter Name of Conveyor System',conveyorSystem),
        CommonWidgets.buildDropdownField('Chain Manufacturer', [
          'Daifuku', 'Frost', 'NKC', 'Pacline', 'Rapid', 'WEBB', 'Webb-Stiles', 'Wilkie Brothers', 'Others'
        ]),
        CommonWidgets.buildTextField('Enter Conveyor Length',conveyorLength),
        CommonWidgets.buildDropdownField('Conveyor Length Unit', [
          'Feet', 'Inches', 'm Meter', 'mm Millimeters'
        ]),
        CommonWidgets.buildDropdownField('Conveyor Speed Unit', [
          'Feet/Minute', 'Meters/Minute'
        ]),
        
      ],
    );
  }
}
