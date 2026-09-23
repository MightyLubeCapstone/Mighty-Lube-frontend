import 'package:mighty_lube/core/constants/app_assets.dart';
import 'package:mighty_lube/features/products/models/product_detail_data.dart';

const ProductDetailData inBoardRollerChain300data = ProductDetailData(
  id: 'IBRC_300',
  title: 'OPCO 300 Series Automatic Sealed Wheel Lubricator',
  imagePath: AppAssets.inBoardRollerChain300,
  description: '',

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
          key: 'otherChainSize',
          label: 'Other Conveyor Chain Size',
          type: ProductFieldType.text,
          required: true,
          visibleWhenFieldKey: 'conveyorChainSize',
          visibleWhenValue: 'Other',
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
          key: 'otherIndustrialChainManufacturer',
          label: 'Other Chain Manufacturer',
          type: ProductFieldType.text,
          required: true,
          visibleWhenFieldKey: 'industrialChainManufacturer',
          visibleWhenValue: 'Other',
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
          key: 'otherWheelManufacturer',
          label: 'Other Wheel Manufacturer',
          type: ProductFieldType.text,
          required: true,
          visibleWhenFieldKey: 'wheelManufacturer',
          visibleWhenValue: 'Other',
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
          key: 'otherAppEnviroment',
          label: 'Other Application Environment',
          type: ProductFieldType.text,
          required: true,
          visibleWhenFieldKey: 'appEnviroment',
          visibleWhenValue: 'Other',
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
          key: 'plantLayout',
          label: 'I Have A Plant Layout To Attach',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes - Will Attach',
            'No - Do Not Have',
          ],
        ),

        ProductFieldData(
          key: 'requiredPics',
          label: 'I Have The Required Pictures Of Each Chain To Attach',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes - Will Attach',
            'No - Do Not Have',
          ],
        ),

        ProductFieldData(
          key: 'conveyorOverhead',
          label: 'Is the Conveyor Overhead, Inverted, or Inverted/Inverted?',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Overhead',
            'Inverted',
            'Inverted/Inverted'
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
      title: 'New Monitoring System or Adding to Existing Monitoring System',
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
          key: 'guideRollersRaceStyle',
          label: 'Guide Rollers Open Race Style',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'No Applicable',
            'Open Inside',
            'Open Outside',
          ]
        ),


        ProductFieldData(
            key: 'guideRollersSealed',
            label: 'Guide Rollers Sealed Style',
            type: ProductFieldType.dropdown,
            required: true,
            options: [
              'Extended',
              'Flush',
              'Recessed',
            ]
        ),

        ProductFieldData(
            key: 'openHole',
            label: 'Open Hole',
            type: ProductFieldType.dropdown,
            required: true,
            options: [
              'Yes',
              'No',
            ]
        ),

        ProductFieldData(
            key: 'rollerChains',
            label: 'Roller Chains',
            type: ProductFieldType.dropdown,
            required: true,
            options: [
              'Yes',
              'No',
            ],
        ),

        ProductFieldData(
          key: 'bushings',
          label: 'Bushings',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'outboardWheels',
          label: 'Outboard Wheels',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'lubeBrand',
          label: 'Current Lubrication Equipment (Brand)',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'lubricantType',
          label: 'Current Lubrication Type',
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
          key: 'cleanConveyor',
          label: 'Is the Conveyor Chain Clean?',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'currentGrease',
          label: 'Current Grease Type',
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
          key: 'zerkFtgLocation',
          label: 'Zerk Ftg Location [Left or Right: Facing Direction of Travel)',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'ftgLocation',
          label: 'Zerk Ftg Location (Orientation)',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Center',
            '12 0 clock',
            '3 0 clock',
            '6 0 clock',
            '9 0 clock',
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
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'remoteStatus',
          label: 'Remote Controller',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'mountStatus',
          label: 'Mounted on Greaser',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'otherUnitStatus',
          label: 'Control Other Unit',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'timerStatus',
          label: 'Timer',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Not Required',
            '12 Hour',
            '1000 Hour'
          ],
        ),

        ProductFieldData(
          key: 'electricStatus',
          label: 'Electric On / Off',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'mightyLubeMonitoring',
          label: 'Mighty Lube Monitoring',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'preMountRequirement',
          label: 'Pre-Mounting Requirements',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'OPCO Truck',
            'Customer Provided Truck',
            'Other'
          ],
        ),

        ProductFieldData(
          key: 'preMountRequirement',
          label: 'Other Pre-Mount Requirements',
          type: ProductFieldType.text,
          required: true,
          visibleWhenFieldKey: 'preMountType',
          visibleWhenValue: 'Other',
        ),

        ProductFieldData(
          key: 'plcConnection',
          label: 'PLC Connection',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
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
    // 6.: MEASUREMENTS
    // =========================================================

    ProductConfigurationSection(
      id: 'measurements',
      title: 'In Board Roller Chain: Measurements',
      fields: [
        ProductFieldData(
          key: 'measurementUnit',
          label: 'Measurement Unit',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Inches',
            'Feet',
            'Millimeters',
            'Centimeters',
          ],
        ),
        ProductFieldData(
          key: 'inBoardRollerChainRollerWheelA1',
          label: 'In Board Roller Chain Roller Wheel (A1)',
          type: ProductFieldType.text,
          required: true,
          hintText: 'Diameter',
          imagePath: AppAssets.ibrc_A1,
        ),
        ProductFieldData(
          key: 'inBoardRollerChainRollerWheelB1',
          label: 'In Board Roller Chain Roller Wheel (B1)',
          type: ProductFieldType.text,
          required: true,
          hintText: 'Width',
          imagePath: AppAssets.ibrc_B1,
        ),
        ProductFieldData(
          key: 'inBoardRollerChainLinkC1',
          label: 'In Board Roller Chain Link (C1)',
          type: ProductFieldType.text,
          required: true,
          hintText: 'Width',
          imagePath: AppAssets.ibrc_C1,
        ),
        ProductFieldData(
          key: 'inBoardRollerChainLinkD1',
          label: 'In Board Roller Chain Link (D1)',
          type: ProductFieldType.text,
          required: true,
          hintText: 'Thickness',
          imagePath: AppAssets.ibrc_D1,
        ),
        ProductFieldData(
          key: 'inBoardRollerChainLinkE1',
          label: 'In Board Roller Chain Inner Link Offset (E1)',
          type: ProductFieldType.text,
          required: true,
          hintText: 'Thickness',
          imagePath: AppAssets.ibrc_E1,
        ),
        ProductFieldData(
          key: 'inBoardRollerChainOuterLinkOffsetF1',
          label: 'In Board Roller Chain Outer Link Offset (F1)',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.ibrc_F1,
        ),
        ProductFieldData(
          key: 'inBoardRollerChainOuterLinkOffsetG1',
          label: 'In Board Roller Chain Zerk Fitting Offset (G1)',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.ibrc_G1,
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