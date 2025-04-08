import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/industrial/10.%20OHPRLB%20(20)/CCS%20(8)/products.dart';
import 'package:mighty_lube/helper_widgets.dart';


class ConfigurationSection extends StatefulWidget {
  const ConfigurationSection({super.key});

  @override
  State<ConfigurationSection> createState() => _ConfigurationSectionState();
}

class _ConfigurationSectionState extends State<ConfigurationSection> {
  int itemCount = 1; // Default count
  final TextEditingController systemName = TextEditingController();
  final TextEditingController conveyorLength = TextEditingController();
  final TextEditingController conveyorSpeed = TextEditingController();
  final TextEditingController bDiameter = TextEditingController();
  final TextEditingController hHeight = TextEditingController();
  final TextEditingController gWidth = TextEditingController();
  final TextEditingController aRail = TextEditingController();

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
              CommonWidgets.buildGradientButton(context, 'Overhead Power Rail: Measurements',buildMeasurements()),
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
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildTextField('Enter Name of Conveyor System Here',systemName),
        CommonWidgets.buildDropdownField('Conveyor Chain Size', [
          'X348 Chain (3”)',
          'X458 Chain (4”)',
          'OX678 Chain (6”)',
          '3/8" Log Chain',
          'Other'
        ]),
        CommonWidgets.buildDropdownField('Chain Manufacturer', [
          'Daifuku',
          'Frost',
          'NKC',
          'Pacline',
          'Rapid',
          'WEBB',
          'Webb-Stilies',
          'Wilkie Brothers',
          'Other'
        ]),
        CommonWidgets.buildTextField('Enter Conveyor Length', conveyorLength),
        CommonWidgets.buildDropdownField('Conveyor Length Unit', [
          'Feet',
          'Inches',
          'm Meter',
          'mm Milimeter'
        ]),
        CommonWidgets.buildDropdownField('Application Environment', [
          'Ambient',
          'Caustic (i.e. Phosphate/ E-Coat, etc.)',
          'Oven',
          'Wash Down', 'Intrinsic','Food Grade', 'Other'
        ]),
        CommonWidgets.buildDropdownField('Is the Conveyor Loaded or Unloaded at Planned Install Location?', [
          'Loaded',
          'Unloaded'
        ]),
        CommonWidgets.buildSectionDivider(),
      ],
    );
  }

  Widget buildMeasurements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonWidgets.buildSectionDivider(),
        CommonWidgets.buildDropdownField('Measurement Units', [
          'Feet',
          'Inches', 
          'm Meter', 
          'mm Milimeter'
        ]),
        
        // Image A
        CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Chain Drop (A)",
        hintText: "Rail to Center of Chain",
        imagePath: '', // there is no image on the site for this one
        controller: aRail,
        subHint: "(Rail to Center of Chain)",
      ),
        
        // Image B
        CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Overhead Power MonoRail Power Trolley Wheel (B)",
        hintText: "Diameter",
        imagePath: '', // there is no image on the site for this one
        controller: bDiameter,
        subHint: "(Diameter)",
      ),

        // Image G
        CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Overhead Power MonoRail Power Rail (G)",
        hintText: "Width",
        imagePath: '', // there is no image on the site for this one
        controller: gWidth,
        subHint: "(Width)",
      ),

        // Image H
        CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Overhead Power MonoRail Power Rail (H)",
        hintText: "Height",
        imagePath: '', // there is no image on the site for this one
        controller: hHeight,
        subHint: "(Height)",
      ),

        CommonWidgets.buildSectionDivider(),
      ],
    );
  }
}
