import '../../../../../core/constants/app_assets.dart';
import '../../../models/product_detail_data.dart';

const ProductDetailData cChannelFreeRail314LoadWheelGreaserData =
ProductDetailData(
  // =========================================================
  // PRODUCT INFORMATION
  // =========================================================

  id: 'FRO_314',

  title: 'Free Rail 314 "Load" Wheel Greaser',

  imagePath: AppAssets.cChannelFr314,

  description: 'Free Rail 314 "Load" Wheel Greaser.',

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
        ),

        ProductFieldData(
          key: 'wheelManufacturer',
          label: 'Wheel Manufacturer',
          type: ProductFieldType.dropdown,
          options: [
            'Green Line',
            'Frost',
            'M&M',
            'Stork',
            'Meyn',
            'Linco',
            'DC',
            'Merel',
            'D&F',
            'Other',
          ],
        ),

        ProductFieldData(
          key: 'otherWheelManufacturer',
          label: 'Other Wheel Manufacturer',
          type: ProductFieldType.text,
          visibleWhenFieldKey: 'wheelManufacturer',
          visibleWhenValue: 'Other',
        ),

        ProductFieldData(
          key: 'conveyorLength',
          label: 'Conveyor Length',
          type: ProductFieldType.text,
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
        ),

        ProductFieldData(
          key: 'conveyorSpeed',
          label: 'Conveyor Speed (Min/Max)',
          type: ProductFieldType.text,
        ),

        // Recording showed "Feet / minute" but did not expose
        // the complete dropdown option list.
        ProductFieldData(
          key: 'conveyorSpeedUnit',
          label: 'Conveyor Speed Unit',
          type: ProductFieldType.text,
          hintText: 'Feet / minute',
        ),

        ProductFieldData(
          key: 'indexingVariableSpeedConditions',
          label: 'Indexing or Variable Speed Conditions',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'travelDirection',
          label: 'Direction of Travel',
          type: ProductFieldType.text,
        ),

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
          key: 'otherApplicationEnvironment',
          label: 'Other Application Environment',
          type: ProductFieldType.text,
          visibleWhenFieldKey: 'applicationEnvironment',
          visibleWhenValue: 'Other',
        ),

        ProductFieldData(
          key: 'surroundingTemperature',
          label:
          'Temperature of Surrounding Area at Planned Location of Lubrication System it below 30°F or above 120°F?',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'conveyorSwingStatus',
          label:
          'Does Conveyor Swing, Sway, Surge, or Move Side-to-Side',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'conveyorOrientation',
          label:
          'Is the Conveyor Overhead, Inverted, or Inverted/Inverted?',
          type: ProductFieldType.text,
        ),
      ],
    ),

    // =======================================================
    // CUSTOMER POWER UTILITIES
    // =======================================================

    ProductConfigurationSection(
      id: 'customerPowerUtilities',
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
          key: 'compressedAirSupply',
          label: 'Compressed Air Supply',
          type: ProductFieldType.text,
          required: true,
        ),

        // Complete dropdown options were not visible.
        ProductFieldData(
          key: 'compressedAirSupplyUnit',
          label: 'Compressed Air Supply Unit',
          type: ProductFieldType.text,
          hintText: 'PSI',
        ),
      ],
    ),

    // =======================================================
    // NEW MONITORING SYSTEM OR ADDING TO EXISTING
    // =======================================================

    ProductConfigurationSection(
      id: 'monitoringSystem',
      title:
      'New Monitoring System or Adding to Existing Monitoring System',
      fields: [
        ProductFieldData(
          key: 'existingMonitoring',
          label: 'Connecting to Existing Monitoring',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'newMonitoringSystem',
          label: 'Add New Monitoring System',
          type: ProductFieldType.text,
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
          key: 'freeTrolleyWheels',
          label: 'Free Trolley Wheels',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'dogActuator',
          label: 'Dog Actuator',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'pivotPoints',
          label: 'Pivot Points',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'kingPin',
          label: 'King Pin',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'currentLubricationEquipmentBrand',
          label: 'Current Lubrication Equipment (Brand)',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'currentLubricantType',
          label: 'Current Lubricant Type',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'currentLubricantViscosityGrade',
          label: 'Current Lubricant Viscosity/Grade',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'currentGreaseType',
          label: 'Current Grease Type',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'currentGreaseNlgiGrade',
          label: 'Current Grease NLGI Grade',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'zerkFittingLocationSide',
          label:
          'Zerk Ftg Location [Left or Right: Facing Direction of Travel]',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'zerkFittingLocationOrientation',
          label: 'Zerk Ftg Location (Orientation)',
          type: ProductFieldType.dropdown,
          options: [
            'Center',
            '12 O\'clock',
            '3 O\'clock',
            '6 O\'clock',
            '9 O\'clock',
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
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'remote',
          label: 'Remote',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'mountedOnGreaser',
          label: 'Mounted on Greaser',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'controlsOtherUnits',
          label: 'Controls other units (list):',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'timer',
          label: 'Timer',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'electricOnOff',
          label: 'Electric On/Off',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'mightyLubeMonitoring',
          label: 'Mighty Lube Monitoring',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'preMountingRequirements',
          label: 'Pre-Mounting Requirements',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'plcConnection',
          label: 'PLC Connection',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'otherControllerInfo',
          label: 'Other Describe',
          type: ProductFieldType.text,
          multiline: true,
        ),
      ],
    ),

    // =======================================================
    // INVERTED P&F: MEASUREMENTS
    // =======================================================

    ProductConfigurationSection(
      id: 'invertedPowerFreeMeasurements',
      title: 'Inverted P&F: Measurements',
      fields: [
        // Complete website dropdown list was not shown.
        ProductFieldData(
          key: 'measurementUnit',
          label: 'Measurement Unit',
          type: ProductFieldType.text,
          hintText: 'Feet',
        ),

        ProductFieldData(
          key: 'invertedPowerTrolleyWheelB',
          label: 'Inverted Power and Free Power Trolley Wheel (B)',
          type: ProductFieldType.text,
          hintText: 'Diameter',
        ),

        ProductFieldData(
          key: 'invertedZerkFittingVerticalE',
          label:
          'Inverted Power and Free Zerk Fitting Vertical Location (E)',
          type: ProductFieldType.text,
          hintText: 'Bottom of Rail to Zerk Fitting',
        ),

        ProductFieldData(
          key: 'invertedRailG',
          label: 'Inverted Power and Free Rail (G)',
          type: ProductFieldType.text,
          hintText: 'Width',
        ),

        ProductFieldData(
          key: 'invertedRailH',
          label: 'Inverted Power and Free Rail (H)',
          type: ProductFieldType.text,
          hintText: 'Height',
        ),

        ProductFieldData(
          key: 'invertedTrolleyWheelPitchK',
          label: 'Inverted Power and Free Trolley Wheel Pitch (K)',
          type: ProductFieldType.text,
          hintText:
          'Center of Trolley Wheel to Center of Trolley Wheel',
        ),

        ProductFieldData(
          key: 'invertedCarrierTrolleyPitchT',
          label:
          'Inverted Power and Free Free Rail Carrier Trolley Pitch (T)',
          type: ProductFieldType.text,
          hintText: 'Lead to Load',
        ),

        ProductFieldData(
          key: 'invertedCarrierTrolleyPitchU',
          label:
          'Inverted Power and Free Free Rail Carrier Trolley Pitch (U)',
          type: ProductFieldType.text,
          hintText: 'Load to Load',
        ),

        ProductFieldData(
          key: 'invertedCarrierTrolleyPitchV',
          label:
          'Inverted Power and Free Free Rail Carrier Trolley Pitch (V)',
          type: ProductFieldType.text,
          hintText: 'Load to Trailing',
        ),

        ProductFieldData(
          key: 'invertedFreeTrolleyWheelOffsetW',
          label:
          'Inverted Power and Free Free Trolley Wheel Offset (W)',
          type: ProductFieldType.text,
          hintText: 'Outside to Outside of Free Trolley Wheels',
        ),
      ],
    ),

    // =======================================================
    // TECHNICIAN NOTE
    // Explicitly retained
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