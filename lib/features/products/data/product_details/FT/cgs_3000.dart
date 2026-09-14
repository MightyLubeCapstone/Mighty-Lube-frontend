import 'package:mighty_lube/core/constants/app_assets.dart';
import 'package:mighty_lube/features/products/models/product_detail_data.dart';

const ProductDetailData flatTopOpco300Data = ProductDetailData(
  id: 'FT_OPCO',
  title: 'OPCO 300 Series Automatic Sealed Wheel Lubricator',
  imagePath: AppAssets.flatTopOpco300,
  description:
  'Automatic sealed wheel lubrication system designed for Flat Top conveyor applications.',

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
          key: 'chainSize',
          label: 'Conveyor Chain Size',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'otherChainSize',
          label: 'Other Conveyor Chain Size',
          type: ProductFieldType.text,
          required: true,
          visibleWhenFieldKey: 'chainSize',
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
          type: ProductFieldType.text,
          required: true,
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
          required: false,
        ),

        ProductFieldData(
          key: 'travelDirection',
          label: 'Direction of Travel',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'appEnviroment',
          label: 'Application Environment',
          type: ProductFieldType.text,
          required: true,
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
          label:
          'Temperature of Surrounding Area at Planned Location of Lubrication System is below 30°F or above 120°F?',
          type: ProductFieldType.dropdown,
          required: false,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'conveyorLoaded',
          label:
          'Is the Conveyor Loaded or Unloaded at Planned Install Location?',
          type: ProductFieldType.text,
          required: false,
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
          type: ProductFieldType.text,
          required: true,
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
          required: false,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'newMonitoringSystem',
          label: 'Add New Monitoring System',
          type: ProductFieldType.dropdown,
          required: false,
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
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'wheelClosedType',
          label: 'Wheel: Sealed Style',
          type: ProductFieldType.dropdown,
          required: false,
          options: [
            'Extended',
            'Flush',
            'Recessed',
          ],
        ),

        ProductFieldData(
          key: 'openInsideShieldedOutside',
          label: 'Open Inside / Shielded Outside',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'freeTrolleyWheels',
          label: 'Free Trolley Wheels',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'guideRollers',
          label: 'Guide Rollers',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'rollerChains',
          label: 'Roller Chains',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'bushings',
          label: 'Bushings',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'outboardWheels',
          label: 'Outboard Wheels',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'lubeBrand',
          label: 'Current Lubrication Equipment (Brand)',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'lubeViscosity',
          label: 'Current Lubricant Viscosity / Grade',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'currentGrease',
          label: 'Current Grease',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'currentLube',
          label: 'Current Lubricant',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'oilOrGrease',
          label: 'Oil or Grease',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'oilViscosity',
          label: 'Oil Viscosity',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'greaseNGLIGrade',
          label: 'Grease NLGI Grade',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'zerkDirection',
          label: 'Zerk Fitting Direction',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'zerkFtgLocation',
          label: 'Zerk Ftg Location',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'wheelDiameter',
          label: 'Wheel Diameter',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'chainCleanStatus',
          label: 'Is the Conveyor Chain Clean?',
          type: ProductFieldType.dropdown,
          required: false,
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
          required: false,
        ),

        ProductFieldData(
          key: 'remoteStatus',
          label: 'Remote Controller',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'mountStatus',
          label: 'Mounting',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'otherUnitStatus',
          label: 'Other Unit',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'timerStatus',
          label: 'Timer',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'electricStatus',
          label: 'Electric On / Off',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'mightyLubeMonitoring',
          label: 'Mighty Lube Monitoring',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'preMountType',
          label: 'Pre-Mount Type',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'otherPreMountType',
          label: 'Other Pre-Mount Type',
          type: ProductFieldType.text,
          required: false,
          visibleWhenFieldKey: 'preMountType',
          visibleWhenValue: 'Other',
        ),

        ProductFieldData(
          key: 'plcConnection',
          label: 'PLC Connection',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'otherControllerNotes',
          label: 'Other Controller Notes',
          type: ProductFieldType.text,
          required: false,
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
          required: false,
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
          required: false,
        ),

        ProductFieldData(
          key: 'ftTopH',
          label: 'Flat Top Measurement H',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'ftTopA1',
          label: 'Flat Top Measurement A1',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'ftTopB1',
          label: 'Flat Top Measurement B1',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'ftTopH1',
          label: 'Flat Top Measurement H1',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'ftTopJ1',
          label: 'Flat Top Measurement J1',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'ftTopL1',
          label: 'Flat Top Measurement L1',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'ftTopM1',
          label: 'Flat Top Measurement M1',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'ftTopN1',
          label: 'Flat Top Measurement N1',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'ftTopP1',
          label: 'Flat Top Measurement P1',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'ftTopR1',
          label: 'Flat Top Measurement R1',
          type: ProductFieldType.text,
          required: false,
        ),
      ],
    ),
  ],
);