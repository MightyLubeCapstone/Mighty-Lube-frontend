import 'package:flutter/material.dart';
import 'package:mighty_lube/application/UI/applicationHome.dart';
import 'package:mighty_lube/industrial/11.%20PAFOOI%20(17)/CCS%20(3)/products.dart';
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
  final TextEditingController conveyorSpeed = TextEditingController();
  final TextEditingController lCenter = TextEditingController();
  final TextEditingController gWidth = TextEditingController();
  final TextEditingController hHeight = TextEditingController();
  final TextEditingController aCenter = TextEditingController();
  final TextEditingController g2Width = TextEditingController();
  final TextEditingController h2Height = TextEditingController();

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
              CommonWidgets.buildGradientButton(context, 'P&F: Measurements',buildMeasurements()),


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
        CommonWidgets.buildTextField('Enter Name of Conveyor System',conveyorSystem),
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
          'Webb-Stiles',
          'Wilkie Brothers',
          'Other'
        ]),
        CommonWidgets.buildTextField('Enter Conveyor Length',conveyorLength),
        CommonWidgets.buildDropdownField('Conveyor Length Units', [
          'Feet',
          'Inches', 
          'm Meter', 
          'mm Milimeter'
        ]),
        CommonWidgets.buildTextField('Enter Conveyor Speed (Min/Max)',conveyorSpeed),
        CommonWidgets.buildDropdownField('Conveyor Speed Unit', [
          'Feet /minute',
          'Meters /minute',
        ]),        
        CommonWidgets.buildDropdownField('Direction of Travel', [
          'Right to Left',
          'Left to Right',
        ]),        
        CommonWidgets.buildDropdownField('Ambient Enviroment', [
          'Ambient',
          'Caustic (i.e. Phosphate/E-Coat,etc.)',
          'Oven',
          'Wash Down',
          'Intrinsic',
          'Food Grade',
          'Other'
        ]),
        CommonWidgets.buildDropdownField('Is the Conveyor Overhead, Inverted, or Inverted/Inverted', [
          'Inverted',
          'Overhead', 
          'Inverted/Inverted'
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
        
        // Image L
        CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Overhead P&F Free Rail Free Trolley Wheel Position (Vertical) (L)",
        hintText: "Center of Free Trolley Wheel to Bottom of Rail",
        imagePath: 'assets/Measurements/11/CCS/L.png', 
        controller: lCenter,
        subHint: "(Center of Free Trolley Wheel to Bottom of Rail)",
      ),
        
        // Image G
        CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Overhead P&F Free Rail Rail (G)",
        hintText: "Width",
        imagePath: 'assets/Measurements/11/CCS/G.png', 
        controller: gWidth,
        subHint: "(Width)",
      ),

        // Image H
        CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Overhead P&F Free Rail Rail (H)",
        hintText: "Height",
        imagePath: 'assets/Measurements/11/CCS/H.png', 
        controller: hHeight,
        subHint: "(Height)",
      ),

        // Image A
        CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Inverted Power and Free Chain Drop (A)",
        hintText: "Center of Chain to Opposite Edge of Rail",
        imagePath: 'assets/Measurements/11/CCS/A.png', 
        controller: aCenter,
        subHint: "(Center of Chain to Opposite Edge of Rail)",
      ),

        // Image G2
        CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Inverted Power and Free Rail (G)",
        hintText: "Width",
        imagePath: 'assets/Measurements/11/CCS/G2.png', 
        controller: g2Width,
        subHint: "(Width)",
      ),

        // Image H2
        CommonWidgets.buildMeasurementFieldWithImage(
        context: context,
        title: "Inverted Power and Free Rail (H)",
        hintText: "Height",
        imagePath: 'assets/Measurements/11/CCS/H2.png', 
        controller: h2Height,
        subHint: "(Height)",
      ),

        CommonWidgets.buildSectionDivider(),
      ],
    );
  }


}