import '../../../../../../core/constants/app_assets.dart';
import '../../../../models/product_detail_data.dart';

const ProductDetailData cChannelOp139AData = ProductDetailData(
  // =========================================================
  // PRODUCT INFORMATION
  // =========================================================

  id: 'FRO_OP139A',
  title: 'OP-139A',
  imagePath: AppAssets.cChannelOp139A,
  description: 'The OP-139A oiler is a simple, yet effective and clean precision '
      'lubrication system for all types of conveyors.',

  // =========================================================
  // CONFIGURATION SECTIONS
  // =========================================================

  configurationSections: [
    // =======================================================
    // GENERAL INFORMATION
    // =======================================================

    ProductConfigurationSection(
      id: 'general',
      title: 'General Information',
      fields: [
        ProductFieldData(
            key: 'conveyorName',
            label: 'Name of Conveyor System',
            type: ProductFieldType.text,
            required: true
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
          key: 'chainManufacturer',
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

        // NOTE:
        // Current website recording showed these environment options
        // under "Indexing or Variable Speed Conditions".
        ProductFieldData(
          key: 'indexingVariableSpeedConditions',
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

        // Current website recording showed this as a text box.
        ProductFieldData(
          key: 'applicationEnvironment',
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
          key: 'surroundingTemperature',
          label: 'Temperature of Surrounding Area at Planned Location of Lubrication System is below 30°F or above 120°F?',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'conveyorLoadedStatus',
          label: 'Is the Conveyor Loaded or Unloaded at Planned Install Location?',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'conveyorSwingStatus',
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

    // =======================================================
    // CUSTOMER POWER UTILITIES
    // =======================================================

    ProductConfigurationSection(
      id: 'power',
      title: 'Customer Power Utilities',
      fields: [
        ProductFieldData(
          key: 'controlVoltage',
          label: 'Control Voltage (Volts/hz)',
          type: ProductFieldType.text,
          required: true
        ),

        ProductFieldData(
          key: 'compressedAirSupply',
          label: 'Compressed Air Supply',
          type: ProductFieldType.text,
          required: true
        ),

        // Website shows PSI, but complete dropdown list was not exposed.
        ProductFieldData(
          key: 'compressedAirSupplyUnit',
          label: 'Compressed Air Supply Unit',
          type: ProductFieldType.dropdown,
          required: true,
          hintText: 'PSI',
          options: [
            'PSI',
            'KPI',
            'Bar'
          ]
        ),
      ],
    ),

    // =======================================================
    // MONITORING
    // =======================================================

    ProductConfigurationSection(
      id: 'monitoringSystem',
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

    // =======================================================
    // CONVEYOR SPECIFICATIONS
    // =======================================================

    ProductConfigurationSection(
      id: 'conveyorSpecifications',
      title: 'Conveyor Specifications',
      fields: [
        ProductFieldData(
          key: 'wheelOpenRaceStyle',
          label: 'Wheel Open Race Style',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Not Applicable',
            'Open Inside',
            'Open Outside',
          ],
        ),

        ProductFieldData(
          key: 'wheelSealedStyle',
          label: 'Wheel Sealed Style',
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
            ]
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
          key: 'guideRollersOpenRaceStyle',
          label: 'Guide Rollers Open Race Style',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Not Applicable',
            'Open Inside',
            'Open Outside',
          ],
        ),

        ProductFieldData(
          key: 'guideRollersSealedStyle',
          label: 'Guide Rollers Sealed Style',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'openHole',
          label: 'Open Hole',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'dogActuator',
          label: 'Dog Actuator',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'pivotPoints',
          label: 'Pivot Points',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'kingPin',
          label: 'King Pin',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'railLubrication',
          label: 'Rail Lubrication',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
            key: 'currentLubricationEquipmentBrand',
            label: 'Current Lubrication Equipment (Brand)',
            type: ProductFieldType.text,
            required: true
        ),

        ProductFieldData(
            key: 'currentLubricantType',
            label: 'Current Lubricant Type',
            type: ProductFieldType.text,
            required: true
        ),

        ProductFieldData(
            key: 'currentLubricantViscosityGrade',
            label: 'Current Lubricant Viscosity/Grade',
            type: ProductFieldType.text,
            required: true
        ),

        ProductFieldData(
          key: 'lubricationFromSideOfChain',
          label: 'Lubrication from the Side of Chain',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'lubricationFromTopOfChain',
          label: 'Lubrication from the Top of Chain',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),
      ],
    ),
    // =======================================================
    // CONTROLLER
    // =======================================================
    ProductConfigurationSection(
      id: 'controller',
      title: 'Controller',
      fields: [
        ProductFieldData(
            key: 'chainMasterController',
            label: 'ChainMaster Controller',
            type: ProductFieldType.dropdown,
            required: true,
            options: [
              'Yes',
              'No',
            ]
        ),

        ProductFieldData(
            key: 'timer',
            label: 'Timer',
            type: ProductFieldType.dropdown,
            required: true,
            options: [
              'Not Required',
              '12 Hour',
              '1000 Hour'
            ]
        ),

        ProductFieldData(
            key: 'electricOnOff',
            label: 'Electric On/Off',
            type: ProductFieldType.dropdown,
            required: true,
            options: [
              'Yes',
              'No',
            ]

        ),

        ProductFieldData(
          key: 'pneumaticOnOff',
          label: 'Pneumatic On/Off',
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
          key: 'otherControllerInfo',
          label: 'Other Describe',
          type: ProductFieldType.text,
          multiline: true,
        ),

        ProductFieldData(
          key: 'specialControllerOptions',
          label: 'Special Options to Add on to Controller, I/O List, Conveyor Specifications, etc.',
          type: ProductFieldType.text,
          multiline: true,
        ),

        ProductFieldData(
          key: 'controllerSpecify',
          label: 'Please Specify',
          type: ProductFieldType.text,
          multiline: true,
        ),
      ],
    ),


    // =======================================================
    // FREE RAIL MEASUREMENTS
    // =======================================================

    ProductConfigurationSection(
      id: 'freeRailMeasurements',
      title: 'Free Rail Measurements',
      fields: [
        // Recording only confirms visible/current value as Feet.
        // Full dropdown option list was not exposed, so keep as text.
        ProductFieldData(
          key: 'freeRailMeasurementUnit',
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
          key: 'overheadFreeRailC',
          label: 'Overhead P&F Free Rail Rail (G)',
          type: ProductFieldType.text,
          hintText: 'Height',
          required: true,
          imagePath: AppAssets.CCO_CLS_G,
        ),

        ProductFieldData(
          key: 'overheadFreeRailD',
          label: 'Overhead P&F Free Rail Rail (H)',
          type: ProductFieldType.text,
          hintText: 'Width',
          required: true,
          imagePath: AppAssets.CCO_CLS_H,
        ),

        ProductFieldData(
          key: 'overheadTrolleyWheelPitchK',
          label: 'Overhead P&F Free Rail Trolley Wheel Pitch (K)',
          type: ProductFieldType.text,
          hintText: 'Center of Trolley Wheel to Center of Trolley Wheel',
          required: true,
          imagePath: AppAssets.CCO_CLS_K,
        ),

        ProductFieldData(
          key: 'overheadFreeRailTrolleyWheelC2',
          label: 'Overhead P&F Free Rail Trolley Wheel (K2)',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.CCO_CLS_Kp2,
        ),


        ProductFieldData(
          key: 'invertedPowerFreeRailE',
          label: 'Inverted Power and Free Chain Drop (A)',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.CCO_CLS_A,
        ),

        ProductFieldData(
          key: 'invertedPowerFreeTrolleyB',
          label: 'Inverted Power and Free Trolley Wheel (B)',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.CCO_CLS_B,
        ),

        ProductFieldData(
          key: 'invertedPowerFreRailG',
          label: 'Inverted Power and Free Rail (G)',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.CCO_CLS_G2,
        ),

        ProductFieldData(
          key: 'invertedPowerFreeRailH',
          label: 'Inverted Power and Free Rail (H)',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.CCO_CLS_H2,
        ),

        ProductFieldData(
          key: 'invertedPowerFreeTrolleyWheelPitchK',
          label: 'Inverted Power and Free Trolley Wheel Pitch (K)',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.CCO_CLS_K2,
        ),

        ProductFieldData(
          key: 'overheadFreeTrolleyWheelPositionL',
          label: 'Overhead P&F Free Rail Free Trolley Wheel Position (Vertical) (L)',
          type: ProductFieldType.text,
          hintText: 'Center of Free Trolley Wheel to Bottom of Rail',
          required: true,
          imagePath: AppAssets.CCO_CLS_L,
        ),
      ],
    ),

    // =======================================================
    // TECHNICIAN NOTE
    // =======================================================

    ProductConfigurationSection(
      id: 'technicianNote',
      title: 'Technician Note',
      fields: [
        ProductFieldData(
          key: 'technicianNote',
          label: 'Technician Note',
          type: ProductFieldType.text,
          multiline: true,
          required: true,
        ),
      ],
    ),
  ],
);