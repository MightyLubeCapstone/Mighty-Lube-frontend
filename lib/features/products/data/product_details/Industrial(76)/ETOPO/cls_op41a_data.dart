import '../../../../../../core/constants/app_assets.dart';
import '../../../../models/product_detail_data.dart';

const ProductDetailData etopoOp41aData = ProductDetailData(
  id: 'ETO_OP41A',
  title: 'OP-41A Conveyor Lubricators',
  imagePath: AppAssets.etipoOP41A,
  description: 'OP-41A Conveyor Lubricators for Enclosed Track Inverted conveyor systems.',

  configurationSections: [
    // =========================================================
    // GENERAL INFORMATION
    // =========================================================

    ProductConfigurationSection(
      id: 'general',
      title: 'General Information',
      fields: [
        ProductFieldData(
          key: 'conveyorName',
          label: 'Name of Conveyor System',
          type: ProductFieldType.text,
          required: true,
        ),
        ProductFieldData(
          key: 'chainSize',
          label: 'Conveyor Chain Size',
          type: ProductFieldType.dropdown,
          options: [
            'X348 Chain (3")',
            'X458 Chain (4")',
            'OX678 Chain (6")',
            'Other',
          ],
          required: true,
        ),
        ProductFieldData(
          key: 'industrialChainManufacturer',
          label: 'Chain Manufacturer',
          type: ProductFieldType.dropdown,
          options: [
            'Daifuku',
            'Frost',
            'NKC',
            'Pacline',
            'Rapid',
            'WEBB',
            'Webb-Stiles',
            'Wilkie Brothers',
            'Other',
          ],
          required: true,
        ),
        ProductFieldData(
          key: 'conveyorLength',
          label: 'Conveyor Length',
          type: ProductFieldType.text,
          required: false,
        ),
        ProductFieldData(
          key: 'conveyorLengthUnit',
          label: 'Conveyor Length Unit',
          type: ProductFieldType.dropdown,
          options: [
            'Feet',
            'Inches',
            'm Meter',
            'mm Millimeter',
          ],
          required: true,
        ),
        ProductFieldData(
          key: 'conveyorSpeed',
          label: 'Conveyor Speed (Min/Max)',
          type: ProductFieldType.text,
          required: true,
        ),
        ProductFieldData(
          key: 'conveyorSpeedUnit',
          label: 'Conveyor Speed Unit',
          type: ProductFieldType.dropdown,
          options: [
            'Feet / minute',
            'Meters / minute',
          ],
          required: true,
        ),
        ProductFieldData(
          key: 'conveyorIndex',
          label: 'Indexing or Variable Speed Conditions',
          type: ProductFieldType.text,
          required: true,
        ),
        ProductFieldData(
          key: 'travelDirection',
          label: 'Direction of Travel',
          type: ProductFieldType.dropdown,
          options: [
            'Right to Left',
            'Left to Right',
          ],
          required: true,
        ),
        ProductFieldData(
          key: 'appEnviroment',
          label: 'Application Environment',
          type: ProductFieldType.dropdown,
          options: [
            'Ambient',
            'Caustic (i.e. Phosphate / E-Coat, etc.)',
            'Oven',
            'Wash Down',
            'Intrinsic',
            'Food Grade',
            'Other',
          ],
          required: true,
        ),
        ProductFieldData(
          key: 'surroundingTemp',
          label: 'Temperature of Surrounding Area at Planned Location of Lubrication System it below 30°F or above 120°F?',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
          required: true,
        ),
        ProductFieldData(
          key: 'conveyorLoaded',
          label:
          'Is the Conveyor Loaded or Unloaded at Planned Install Location?',
          type: ProductFieldType.dropdown,
          options: [
            'Loaded',
            'Unloaded',
          ],
          required: true,
        ),
        ProductFieldData(
          key: 'conveyorSwing',
          label: 'Does Conveyor Swing, Sway, Surge, or Move Side-to-Side',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
          required: true,
        ),
      ],
    ),

    // =========================================================
    // CUSTOMER POWER UTILITIES
    // =========================================================

    ProductConfigurationSection(
      id: 'powerUtilities',
      title: 'Customer Power Utilities',
      fields: [
        ProductFieldData(
          key: 'controlVoltage',
          label: 'Control Voltage (Volts/hz)',
          type: ProductFieldType.text,
          required: true,
        ),
        ProductFieldData(
          key: 'compressedAir',
          label: 'Compressed Air Supply',
          type: ProductFieldType.text,
          required: true,
        ),
        ProductFieldData(
          key: 'compressedAirUnit',
          label: 'Compressed Air Supply Unit',
          type: ProductFieldType.dropdown,
          options: [
            'PSI',
            'KPI',
            'Bar',
          ],
          required: true,
        ),
      ],
    ),

    // =========================================================
    // MONITORING SYSTEM
    // =========================================================

    ProductConfigurationSection(
      id: 'monitoring',
      title: 'New Monitoring System or Adding to Existing Monitoring System',
      fields: [
        ProductFieldData(
          key: 'existingMonitoring',
          label: 'Connecting to Existing Monitoring',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
          required: true,
        ),
        ProductFieldData(
          key: 'newMonitoringSystem',
          label: 'Add New Monitoring System',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
          required: true,
        ),
      ],
    ),

    // =========================================================
    // CONVEYOR SPECIFICATIONS
    // =========================================================

    ProductConfigurationSection(
      id: 'conveyorSpecifications',
      title: 'Conveyor Specifications',
      fields: [
        ProductFieldData(
          key: 'railLubeStatus',
          label: 'Rail Lubrication',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
          required: true,
        ),
        ProductFieldData(
          key: 'lubeBrand',
          label: 'Current Lubrication Equipment (Brand)',
          type: ProductFieldType.text,
          required: true,
        ),
        ProductFieldData(
          key: 'lubeType',
          label: 'Current Lubricant Type',
          type: ProductFieldType.text,
          required: true,
        ),
        ProductFieldData(
          key: 'lubeViscosity',
          label: 'Current Lubricant Viscosity/Grade',
          type: ProductFieldType.text,
          required: true,
        ),
        ProductFieldData(
          key: 'sideLubeStatus',
          label: 'Lubrication from the Side of Chain',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
          required: true,
        ),
        ProductFieldData(
          key: 'topLubeStatus',
          label: 'Lubrication from the Top of Chain',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
          required: true,
        ),
        ProductFieldData(
          key: 'optionalReservoir',
          label: 'Optional 5 Gallon Reservoir',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
          required: true,
        ),
        ProductFieldData(
          key: 'chainCleanStatus',
          label: 'Is the Conveyor Chain Clean?',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
          required: true,
        ),
      ],
    ),

    // =========================================================
    // CONTROLLER
    // =========================================================

    ProductConfigurationSection(
      id: 'controller',
      title: 'Controller',
      fields: [
        ProductFieldData(
          key: 'chainMaster',
          label: 'ChainMaster Controller',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
          required: true,
        ),
        ProductFieldData(
          key: 'otherUnitStatus',
          label: 'Controls other units (list):',
          type: ProductFieldType.text,
          required: true,
        ),
        ProductFieldData(
          key: 'timerStatus',
          label: 'Timer',
          type: ProductFieldType.dropdown,
          options: [
            'Not Required',
            '12 Hour',
            '1000 Hour',
          ],
          required: true,
        ),
        ProductFieldData(
          key: 'electricStatus',
          label: 'Electric On/Off',
          type: ProductFieldType.dropdown,
          options: [
            'On',
            'Off',
          ],
          required: true,
        ),
        ProductFieldData(
          key: 'pneumaticStatus',
          label: 'Pneumatic On/Off',
          type: ProductFieldType.dropdown,
          options: [
            'On',
            'Off',
          ],
          required: true,
        ),
        ProductFieldData(
          key: 'mightyLubeMonitoring',
          label: 'Mighty Lube Monitoring',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
          required: true,
        ),
        ProductFieldData(
          key: 'preMountingRequirements',
          label: 'Pre-Mounting Requirements',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'OPCO Truck',
            'Customer Provided Track',
            'Other'
          ],
        ),

        ProductFieldData(
          key: 'plcConnection',
          label: 'PLC Connection',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
          required: true,
        ),
        ProductFieldData(
          key: 'otherControllerInfo',
          label: 'Other Describe',
          type: ProductFieldType.text,
          required: false,
          multiline: true,
        ),
        ProductFieldData(
          key: 'controllerSpecialOptions',
          label: 'Special Options to Add on to Controller, I/O Link, Plug and Play, Dry Contacts (please specify)',
          type: ProductFieldType.text,
          required: false,
        ),
        ProductFieldData(
          key: 'controllerSpecialOptionsSpecify',
          label: 'Please Specify',
          type: ProductFieldType.text,
          required: false,
          multiline: true,
        ),
      ],
    ),

    // =========================================================
    // ENCLOSED TRACK INVERTED: MEASUREMENTS
    // =========================================================

    ProductConfigurationSection(
      id: 'measurements',
      title: 'Enclosed Track Inverted: Measurements',
      fields: [
        ProductFieldData(
          key: 'measurementUnits',
          label: 'Measurement Unit',
          type: ProductFieldType.dropdown,
          options: [
            'Feet',
            'Inches',
            'm Meter',
            'mm Millimeter',
          ],
          required: true,
        ),
        ProductFieldData(
          key: 'enclosedTrackB',
          label: 'Enclosed Track (Inverted) Power Trolley Wheel (B)',
          type: ProductFieldType.text,
          hintText: 'Diameter',
          imagePath: AppAssets.etioB,
          required: true,
        ),
        ProductFieldData(
          key: 'enclosedTrackG',
          label: 'Enclosed Track (Inverted) Power Rail (G)',
          type: ProductFieldType.text,
          hintText: 'Width',
          imagePath: AppAssets.etioB,
          required: true,
        ),
        ProductFieldData(
          key: 'enclosedTrackH',
          label: 'Enclosed Track (Inverted) Power Rail (H)',
          type: ProductFieldType.text,
          hintText: 'Height',
          imagePath: AppAssets.etioH,
          required: true,
        ),
        ProductFieldData(
          key: 'enclosedTrackS',
          label:
          'Enclosed Track (Inverted) Trolley Pitch [Spacing] Minimum - For variable pitch chain, Provide the Minimum Pitch Dimension (S)',
          type: ProductFieldType.text,
          hintText: 'Center of Power Wheel to Center of Power Wheel',
          imagePath: AppAssets.etioS,
          required: true,
        ),
        ProductFieldData(
          key: 'enclosedTrackK2',
          label: 'Enclosed Track (Inverted) Free Trolley Wheel (K2)',
          type: ProductFieldType.text,
          hintText: 'Diameter',
          imagePath: AppAssets.etioK2,
          required: true,
        ),
        ProductFieldData(
          key: 'enclosedTrackL2',
          label: 'Enclosed Track (Inverted) Free Rail (L2)',
          type: ProductFieldType.text,
          hintText: 'Width',
          imagePath: AppAssets.etioL2,
          required: true,
        ),
        ProductFieldData(
          key: 'enclosedTrackM2',
          label: 'Enclosed Track (Inverted) Free Rail (M2)',
          type: ProductFieldType.text,
          hintText: 'Height',
          imagePath: AppAssets.etioM2,
          required: true,
        ),
        ProductFieldData(
          key: 'enclosedTrackN2',
          label:
          'Enclosed Track (Inverted) Free Rail Vertical Position (Height) (N2)',
          type: ProductFieldType.text,
          hintText: 'Top of Power Rail to Bottom of Free Rail',
          imagePath: AppAssets.etioN2,
          required: true,
        ),
        ProductFieldData(
          key: 'enclosedTrackS2',
          label: 'Enclosed Track (Inverted) Power Trolley Wheel Pitch (S2)',
          type: ProductFieldType.text,
          hintText: 'Center of Trolley Wheel to Center of Trolley Wheel',
          imagePath: AppAssets.etioS2,
          required: true,
        ),
      ],
    ),

    // =======================================================
    // TECHNICIAN NOTE
    //
    // Existing app-specific field.
    // Kept optional.
    // =======================================================

    ProductConfigurationSection(
      id: 'technician',
      title: 'Technician Note',
      fields: [
        ProductFieldData(
          key: 'technicianNote',
          label: 'Technician Note',
          type: ProductFieldType.text,
          required: false,
          multiline: true,
          hintText:
          'Enter any additional notes or instructions here...',
        ),
      ],
    ),
  ],
);