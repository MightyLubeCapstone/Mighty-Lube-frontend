import '../../../../../../core/constants/app_assets.dart';
import '../../../../models/product_detail_data.dart';

const ProductDetailData pfoFreeRail314LoadWheelGreaserData =
ProductDetailData(
  // =========================================================
  // PRODUCT INFORMATION
  // =========================================================

  id: 'PFO_CGS_FR314',
  title: 'Free Rail 314 “Load” Wheel Greaser',
  imagePath: AppAssets.PFO_CGS_FR314,
  description: 'Free Rail 314 “Load” Wheel Greaser.',

  configurationSections: [

    // =======================================================
    // 1. GENERAL INFORMATION
    // =======================================================

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
          key: 'wheelManufacturer',
          label: 'Wheel Manufacturer',
          type: ProductFieldType.dropdown,
          required: true,
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
          key: 'indexingVariableSpeedConditions',
          label: 'Indexing or Variable Speed Conditions',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'directionOfTravel',
          label: 'Direction of Travel',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Right to Left',
            'Left to Right',
          ],
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
          key: 'surroundingTemperature',
          label: 'Temperature of Surrounding Area at Planned Location of Lubrication System it below 30°F or above 120°F?',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'conveyorSwingStatus',
          label: 'Does Conveyor Swing, Sway, Surge, or Move Side-to-Side',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'conveyorOrientation',
          label: 'Is the Conveyor Overhead, Inverted, or Inverted/Inverted?',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Overhead',
            'Inverted',
            'Inverted/Inverted',
          ],
        ),
      ],
    ),

    // =======================================================
    // 2. CUSTOMER POWER UTILITIES
    // =======================================================

    ProductConfigurationSection(
      id: 'customerPowerUtilities',
      title: 'Customer Power Utilities',
      fields: [
        ProductFieldData(
          key: 'operatingVoltage',
          label: 'Operating Voltage - Single Phase: (Volts/hz]',
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

        ProductFieldData(
          key: 'compressedAirSupplyUnit',
          label: 'Compressed Air Supply Unit',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'PSI',
            'Bar',
            'KPI',
          ],
        ),
      ],
    ),

    // =======================================================
    // 3. MONITORING SYSTEM
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
    // 4. CONVEYOR SPECIFICATIONS
    // =======================================================

    ProductConfigurationSection(
      id: 'conveyorSpecifications',
      title: 'Conveyor Specifications',
      fields: [
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
          key: 'currentLubricationEquipmentBrand',
          label: 'Current Lubrication Equipment (Brand)',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'currentLubricantType',
          label: 'Current Lubricant Type',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'currentLubricantViscosityGrade',
          label: 'Current Lubricant Viscosity/Grade',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'currentGreaseType',
          label: 'Current Grease Type',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'currentGreaseNlgiGrade',
          label: 'Current Grease NLGI Grade',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'zerkFittingLocationSide',
          label:
          'Zerk Ftg Location [Left or Right: Facing Direction of Travel)',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Right',
            'Left',
          ],
        ),

        ProductFieldData(
          key: 'zerkFittingLocationOrientation',
          label: 'Zerk Ftg Location (Orientation)',
          type: ProductFieldType.dropdown,
          required: true,
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
    // 5. CONTROLLER
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
          ],
        ),

        ProductFieldData(
          key: 'remote',
          label: 'Remote',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'mountedOnGreaser',
          label: 'Mounted on Greaser',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'controlsOtherUnits',
          label: 'Controls other units (list):',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'timer',
          label: 'Timer',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Not Required',
            '12 Hour',
            '1000 Hour',
          ],
        ),

        ProductFieldData(
          key: 'electricOnOff',
          label: 'Electric On/Off',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'On',
            'Off',
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
          key: 'preMountingRequirements',
          label: 'Pre-Mounting Requirements',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'OPCO Truck',
            'Customer Provided Track',
            'Other',
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
      ],
    ),

    // =======================================================
    // 6. INVERTED P&F: MEASUREMENTS
    // =======================================================

    ProductConfigurationSection(
      id: 'invertedPowerAndFreeMeasurements',
      title: 'Inverted P&F: Measurements',
      fields: [
        ProductFieldData(
          key: 'measurementUnit',
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
          key: 'invertedPowerTrolleyWheelB',
          label: 'Inverted Power and Free Power Trolley Wheel (B)',
          hintText: 'Diameter',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.PFO_CCS_314_B,
        ),

        ProductFieldData(
          key: 'invertedZerkFittingVerticalLocationE',
          label: 'Inverted Power and Free Zerk Fitting Vertical Location (E)',
          hintText: 'Bottom of Rail to Zerk Fitting',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.PFO_CCS_314_E,
        ),

        ProductFieldData(
          key: 'invertedRailG',
          label: 'Inverted Power and Free Rail (G)',
          hintText: 'Width',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.PFO_CCS_314_G,
        ),

        ProductFieldData(
          key: 'invertedRailH',
          label: 'Inverted Power and Free Rail (H)',
          hintText: 'Height',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.PFO_CCS_314_H,
        ),

        ProductFieldData(
          key: 'invertedTrolleyWheelPitchK',
          label: 'Inverted Power and Free Trolley Wheel Pitch (K)',
          hintText: 'Center of Trolley Wheel to Center of Trolley Wheel',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.PFO_CCS_314_K,
        ),

        ProductFieldData(
          key: 'invertedCarrierTrolleyPitchT',
          label: 'Inverted Power and Free Free Rail Carrier Trolley Pitch (T)',
          hintText: 'Lead to Load',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.PFO_CCS_314_T,
        ),

        ProductFieldData(
          key: 'invertedCarrierTrolleyPitchU',
          label: 'Inverted Power and Free Free Rail Carrier Trolley Pitch (U)',
          hintText: 'Load to Load',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.PFO_CCS_314_U,
        ),

        ProductFieldData(
          key: 'invertedCarrierTrolleyPitchV',
          label: 'Inverted Power and Free Free Rail Carrier Trolley Pitch (V)',
          hintText: 'Load to Trailing',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.PFO_CCS_314_V,
        ),

        ProductFieldData(
          key: 'invertedFreeTrolleyWheelOffsetW',
          label: 'Inverted Power and Free Free Trolley Wheel Offset (W)',
          hintText: 'Outside to Outside of Free Trolley Wheels',
          type: ProductFieldType.text,
          required: true,
          imagePath: AppAssets.PFO_CCS_314_W,
        ),
      ],
    ),

    // =======================================================
    // 7. TECHNICIAN NOTE
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
          required: false,
        ),
      ],
    ),
  ],
);