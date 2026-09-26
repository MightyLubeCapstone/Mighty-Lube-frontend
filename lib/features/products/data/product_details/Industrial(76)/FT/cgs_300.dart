import 'package:mighty_lube/core/constants/app_assets.dart';
import 'package:mighty_lube/features/products/models/product_detail_data.dart';

const ProductDetailData flatTopOpco300Data = ProductDetailData(
  id: 'FT_OPCO',
  title: 'OPCO 300 Series Automatic Sealed Wheel Lubricator',
  imagePath: AppAssets.flatTopOpco300,
  description: 'Automatic sealed wheel lubrication system designed for Flat Top conveyor applications.',

  configurationSections: [
    // =========================================================
    // 1. GENERAL INFORMATION
    // =========================================================

    ProductConfigurationSection(
      id: 'general_information',
      title: 'General Information',
      fields: [
        ProductFieldData(
          key: 'conveyorName',
          label: 'Name of Conveyor System',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'conveyorChainSize',
          label: 'Conveyor Chain Size',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'X348 Chain (3")',
            'X458 Chain (4")',
            'X678 Chain (6")',
            '3/8" Log Chain',
            'Other',
          ],
        ),

        ProductFieldData(
          key: 'industrialChainManufacturer',
          label: 'Chain Manufacturer',
          type: ProductFieldType.dropdown,
          required: true,
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
        ),

        ProductFieldData(
          key: 'wheelManufacturer',
          label: 'Wheel Manufacturer',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Green Line',
            'Frost',
            'M&M',
            'STOCK',
            'MEYN',
            'LINCO',
            'DC',
            'MEREL',
            'D&F',
            'OTHER'
          ]
        ),

        ProductFieldData(
          key: 'conveyorLength',
          label: 'Conveyor Length',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'conveyorLengthUnit',
          label: 'Conveyor Length Unit',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Feet',
            'Inches',
            'm Meter',
            'mm Millimeter',
          ],
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
          required: true,
          options: [
            'Feet / minute',
            'Meters / minute',
          ],
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
          required: true,
          options: [
            'Right to Left',
            'Left to Right',
          ],
        ),

        ProductFieldData(
          key: 'appEnviroment',
          label: 'Application Environment',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Ambient',
            'Caustic (i.e. Phosphate / E-Coat, etc.)',
            'Oven',
            'Wash Down',
            'Intrinsic',
            'Food Grade',
            'Other',
          ],
        ),

        ProductFieldData(
          key: 'surroundingTemp',
          label: 'Temperature of Surrounding Area at Planned Location of Lubrication System is below 30°F or above 120°F?',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'conveyorLoaded',
          label: 'Is the Conveyor Loaded or Unloaded at Planned Install Location?',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Loaded',
            'Unloaded',
          ],
        ),

        ProductFieldData(
          key: 'conveyorSwing',
          label: 'Does Conveyor Swing, Sway, Surge, or Move Side-to-Side?',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'conveyorStrandType',
          label: 'Is Conveyor Single or Double Strand',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Single',
            'Double',
          ],
        ),

      ],
    ),

    // =========================================================
    // 2. CUSTOMER POWER UTILITIES
    // =========================================================

    ProductConfigurationSection(
      id: 'customer_power_utilities',
      title: 'Customer Power Utilities',
      fields: [
        ProductFieldData(
          key: 'operatingVoltage',
          label: 'Operating Voltage - Single Phase: (Volts/hz)',
          type: ProductFieldType.text,
          required: true,
        ),

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
            label: 'Compressed Air Unit',
            type: ProductFieldType.dropdown,
            required: true,
            options: [
              'PSI',
              'KPI',
              'Bar'
            ]
        ),
      ],
    ),

    // =========================================================
    // 3. NEW / EXISTING MONITORING SYSTEM
    // =========================================================

    ProductConfigurationSection(
      id: 'monitoring_system',
      title:
      'New Monitoring System or Adding to Existing Monitoring System',
      fields: [
        ProductFieldData(
          key: 'existingMonitoring',
          label: 'Connecting to Existing Monitoring',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'newMonitoringSystem',
          label: 'Add New Monitoring System',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),
      ],
    ),

    // =========================================================
    // 4. CONVEYOR SPECIFICATIONS
    // =========================================================

    ProductConfigurationSection(
      id: 'conveyor_specifications',
      title: 'Conveyor Specifications',
      fields: [
        ProductFieldData(
          key: 'wheelOpenType',
          label: 'Wheel: Open Race Style',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Not Applicable',
            'Open Inside',
            'Open Outside'
          ]
        ),

        ProductFieldData(
          key: 'wheelClosedType',
          label: 'Wheel: Sealed Style',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Extended',
            'Flush',
            'Recessed',
          ],
        ),

        ProductFieldData(
          key: 'openInsideShieldedOutside',
          label: 'Open Inside / Shielded Outside',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'freeTrolleyWheels',
          label: 'Free Trolley Wheels',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'guideRollers',
          label: 'Guide Rollers',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'rollerChains',
          label: 'Roller Chains',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'bushings',
          label: 'Bushings',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'outboardWheels',
          label: 'Outboard Wheels',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'lubeBrand',
          label: 'Current Lubrication Equipment (Brand)',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'lubeViscosity',
          label: 'Current Lubricant Viscosity / Grade',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'currentGrease',
          label: 'Current Grease',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'currentLube',
          label: 'Current Lubricant',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'oilOrGrease',
          label: 'Oil or Grease',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'oilViscosity',
          label: 'Oil Viscosity',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'greaseNGLIGrade',
          label: 'Grease NLGI Grade',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'zerkLocation',
          label: 'Zerk Ftg Location [Left or Right: Facing Direction of Travel)',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Left',
            'Right'
          ]
        ),

        ProductFieldData(
          key: 'zerkFtgLocationOrientation',
          label: 'Zerk Ftg Location (Orientation)',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Center',
            '12 O Clock',
            '3 O Clock',
            '6 O Clock',
            '9 O Clock',
          ]
        ),

        ProductFieldData(
          key: 'wheelDiameter',
          label: 'Wheel Diameter',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'chainCleanStatus',
          label: 'Is the Conveyor Chain Clean?',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),
      ],
    ),

    // =========================================================
    // 5. CONTROLLER
    // =========================================================

    ProductConfigurationSection(
      id: 'controller',
      title: 'Controller',
      fields: [
        ProductFieldData(
          key: 'chainMaster',
          label: 'Chain Master Controller',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'remoteStatus',
          label: 'Remote Controller',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'mountStatus',
          label: 'Mounting',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'otherUnitStatus',
          label: 'Other Unit',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'timerStatus',
          label: 'Timer',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'electricStatus',
          label: 'Electric On / Off',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'mightyLubeMonitoring',
          label: 'Mighty Lube Monitoring',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'preMountRequirements',
          label: 'Pre-Mounting Requirements',
          type: ProductFieldType.text,
          required: true,
          options: [
            'OPCO Track',
            'Customer Provided Track',
            'Other'
          ]
        ),


        ProductFieldData(
          key: 'plcConnection',
          label: 'PLC Connection',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'otherControllerNotes',
          label: 'Other Controller Notes',
          type: ProductFieldType.text,
          required: true,
          multiline: true,
        ),
      ],
    ),

    // =========================================================
    // 6. FLAT TOP: MEASUREMENTS
    // =========================================================

    ProductConfigurationSection(
      id: 'flat_top_measurements',
      title: 'Flat Top: Measurements',
      fields: [
        ProductFieldData(
          key: 'ftUnitType',
          label: 'Measurement Unit',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Feet',
            'Inches',
            'm Meter',
            'mm Millimeter',
          ],
        ),

        ProductFieldData(
          key: 'ftTopG',
          label: 'Flat Top Measurement G',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.FT_G,
        ),

        ProductFieldData(
          key: 'ftTopH',
          label: 'Flat Top Measurement H',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.FT_H,
        ),

        ProductFieldData(
          key: 'ftTopA1',
          label: 'Flat Top Measurement A1',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.FT_A1,
        ),

        ProductFieldData(
          key: 'ftTopB1',
          label: 'Flat Top Measurement B1',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.FT_B1,
        ),

        ProductFieldData(
          key: 'ftTopH1',
          label: 'Flat Top Measurement H1',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.FT_H1,
        ),

        ProductFieldData(
          key: 'ftTopJ1',
          label: 'Flat Top Measurement J1',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.FT_J1,
        ),

        ProductFieldData(
          key: 'ftTopL1',
          label: 'Flat Top Measurement L1',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.FT_L1,
        ),

        ProductFieldData(
          key: 'ftTopM1',
          label: 'Flat Top Measurement M1',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.FT_M1,
        ),

        ProductFieldData(
          key: 'ftTopN1',
          label: 'Flat Top Measurement N1',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.FT_N1,
        ),

        ProductFieldData(
          key: 'ftTopP1',
          label: 'Flat Top Measurement P1',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.FT_P1,
        ),

        ProductFieldData(
          key: 'ftTopR1',
          label: 'Flat Top Measurement R1',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.FT_R1,
        ),
      ],
    ),

    // =======================================================
    // TECHNICIAN NOTE
    //
    // Not shown on current website recording.
    // Kept as optional because this application currently
    // supports technician notes across configurations.
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