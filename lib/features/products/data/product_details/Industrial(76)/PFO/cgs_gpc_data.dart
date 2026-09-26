import '../../../../../../core/constants/app_assets.dart';
import '../../../../models/product_detail_data.dart';

const ProductDetailData pfoGreaserPowerChainData = ProductDetailData(
  // =========================================================
  // PRODUCT INFORMATION
  // =========================================================

  id: 'PFO_CGS_GPC',
  title: 'Greaser Power Chain',
  imagePath: AppAssets.PFO_CGS_GPC,
  description: 'Greaser Power Chain configuration.',

  configurationSections: [
    // =======================================================
    // 1. GENERAL INFORMATION
    // =======================================================

    ProductConfigurationSection(
      id: 'generalInformation',
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
          options: const [
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
          options: const [
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
          options: const [
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
          options: const [
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
          options: const [
            'Feet / minute',
            'Meters /minute',
          ],
        ),

        ProductFieldData(
          key: 'indexingOrVariableSpeedConditions',
          label: 'Indexing or Variable Speed Conditions',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'directionOfTravel',
          label: 'Direction of Travel',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Right to Left',
            'Left to Right',
          ],
        ),

        ProductFieldData(
          key: 'applicationEnvironment',
          label: 'Application Environment',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
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
          options: const [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'conveyorLoadedOrUnloaded',
          label: 'Is the Conveyor Loaded or Unloaded at Planned Install Location?',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Loaded',
            'Unloaded',
          ],
        ),

        ProductFieldData(
          key: 'conveyorMovement',
          label: 'Does Conveyor Swing, Sway, Surge, or Move Side-to-Side',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'plantLayout',
          label: 'I Have A Plant Layout To Attach',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Yes - Will Attach',
            'No - Do Not Have',
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
          key: 'operatingVoltageSinglePhase',
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
          options: const [
            'PSI',
            'KPI',
            'Bar',
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
          key: 'connectingToExistingMonitoring',
          label: 'Connecting to Existing Monitoring',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'addNewMonitoringSystem',
          label: 'Add New Monitoring System',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
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
          options: const [
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
          options: const [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'controlsOtherUnits',
          label: 'Controls other units (list):',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'timer',
          label: 'Timer',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
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
          options: const [
            'On',
            'Off',
          ],
        ),

        ProductFieldData(
          key: 'mightyLubeMonitoring',
          label: 'Mighty Lube Monitoring',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'preMountingRequirements',
          label: 'Pre-Mounting Requirements',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'OPCO Track',
            'Customer Provided Track',
            'Other',
          ],
        ),

        ProductFieldData(
          key: 'otherDescribe',
          label: 'Other Describe',
          type: ProductFieldType.text,
          multiline: true,
        ),
      ],
    ),

    // =======================================================
    // 6. GREASER - POWER CHAIN: MEASUREMENTS
    // =======================================================

    ProductConfigurationSection(
      id: 'greaserPowerChainMeasurements',
      title: 'Greaser - Power Chain: Measurements',
      fields: [
        ProductFieldData(
          key: 'measurementUnit',
          label: 'Measurement Unit',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Feet',
            'Inches',
            'm Meter',
            'mm Millimeter',
          ],
        ),

        ProductFieldData(
          key: 'chainDropA',
          label: 'Greaser - Power Chain Chain Drop (A)',
          type: ProductFieldType.text,
          hintText: 'Top of Rail to Center of Chain',
          required: true,
          imagePath: AppAssets.OHP_CGS_A,
        ),

        ProductFieldData(
          key: 'powerTrolleyWheelB',
          label: 'Greaser - Power Chain Power Trolley Wheel (B)',
          type: ProductFieldType.text,
          hintText: 'Diameter',
          required: true,
          imagePath: AppAssets.OHP_CGS_B,
        ),

        ProductFieldData(
          key: 'trolleyWheelBracketWidthC',
          label:
          'Greaser - Power Chain Trolley Wheel Bracket Width @ Trolley Wheel (C)',
          type: ProductFieldType.text,
          hintText:
          'Outside of Left Bracket to Outside of Right Bracket',
          required: true,
          imagePath: AppAssets.OHP_CGS_C,
        ),

        ProductFieldData(
          key: 'trolleyWheelSpacerD',
          label: 'Greaser - Power Chain Trolley Wheel Spacer (D)',
          type: ProductFieldType.text,
          hintText:
          'Inside of Left Wheel to Inside of Right Wheel',
          required: true,
          imagePath: AppAssets.OHP_CGS_D,
        ),

        ProductFieldData(
          key: 'zerkFittingVerticalLocationE',
          label:
          'Greaser - Power Chain Zerk Fitting Vertical Location (E)',
          type: ProductFieldType.text,
          hintText:
          'Bottom of Rail to Center of Zerk Fitting',
          required: true,
          imagePath: AppAssets.OHP_CGS_E,
        ),

        ProductFieldData(
          key: 'zerkFittingHorizontalLocationF',
          label:
          'Greaser - Power Chain Zerk Fitting Horizontal Location (F)',
          type: ProductFieldType.text,
          hintText:
          'Outside of Left Zerk ftg. to Outside of Right Zerk ftg.',
          required: true,
          imagePath: AppAssets.OHP_CGS_F,
        ),

        ProductFieldData(
          key: 'railG',
          label: 'Greaser - Power Chain Rail (G)',
          type: ProductFieldType.text,
          hintText: 'Width',
          required: true,
          imagePath: AppAssets.OHP_CGS_G,
        ),

        ProductFieldData(
          key: 'railH',
          label: 'Greaser - Power Chain Rail (H)',
          type: ProductFieldType.text,
          hintText: 'Height',
          required: true,
          imagePath: AppAssets.OHP_CGS_H,
        ),

        ProductFieldData(
          key: 'trolleyPitchS',
          label: 'Greaser - Power Chain Trolley Pitch (Minimum - For variable pitch chain, Provide the Minimum Pitch Dimension) (S)',
          type: ProductFieldType.text,
          hintText: 'Center of Power Wheel to Center of Power Wheel',
          required: true,
          imagePath: AppAssets.OHP_CGS_S,
        ),

      ],
    ),

    // =======================================================
    // 7. TECHNICIAN NOTE
    // Existing application-specific field.
    // =======================================================

    ProductConfigurationSection(
      id: 'technicianNote',
      title: 'Technician Note',
      fields: [
        ProductFieldData(
          key: 'technicianNote',
          label: 'Technician Note',
          type: ProductFieldType.text,
          required: false,
          multiline: true,
        ),
      ],
    ),
  ],
);