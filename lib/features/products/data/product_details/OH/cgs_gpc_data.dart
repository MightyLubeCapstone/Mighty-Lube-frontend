import '../../../../../core/constants/app_assets.dart';
import '../../../models/product_detail_data.dart';

const ProductDetailData overheadGreaserPowerChainData = ProductDetailData(
  id: 'OHP_GPC',
  title: 'Greaser Power Chain',
  imagePath: AppAssets.ohprlbGreaserPowerChain,
  description: 'Greaser Power Chain configuration.',
  configurationSections: [
    ProductConfigurationSection(
      id: 'generalInformation',
      title: 'General Information',
      fields: [
        ProductFieldData(
          key: 'conveyorName',
          label: 'Name of Conveyor System',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'conveyorChainSize',
          label: 'Conveyor Chain Size',
          type: ProductFieldType.dropdown,
          options: const [
            'X348 Chain (3")',
            'X458 Chain (4")',
            'X678 Chain (6")',
            '3/8" Log Chain',
            'Other',
          ],
        ),

        ProductFieldData(
          key: 'otherConveyorChainSize',
          label: 'Other – Conveyor Chain Size',
          type: ProductFieldType.text,
          visibleWhenFieldKey: 'conveyorChainSize',
          visibleWhenValue: 'Other',
        ),

        ProductFieldData(
          key: 'chainManufacturer',
          label: 'Chain Manufacturer',
          type: ProductFieldType.dropdown,
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
          key: 'otherChainManufacturer',
          label: 'Other – Chain Manufacturer',
          type: ProductFieldType.text,
          visibleWhenFieldKey: 'chainManufacturer',
          visibleWhenValue: 'Other',
        ),

        ProductFieldData(
          key: 'wheelManufacturer',
          label: 'Wheel Manufacturer',
          type: ProductFieldType.dropdown,
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
          key: 'otherWheelManufacturer',
          label: 'Other – Wheel Manufacturer',
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
          options: const [
            'Feet',
          ],
        ),

        ProductFieldData(
          key: 'conveyorSpeed',
          label: 'Conveyor Speed (Min/Max)',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'conveyorSpeedUnit',
          label: 'Conveyor Speed Unit',
          type: ProductFieldType.dropdown,
          options: const [
            'Feet / minute',
          ],
        ),

        ProductFieldData(
          key: 'indexingOrVariableSpeedConditions',
          label: 'Indexing or Variable Speed Conditions',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'directionOfTravel',
          label: 'Direction of Travel',
          type: ProductFieldType.dropdown,
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
          label:
          'Temperature of Surrounding Area at Planned Location of Lubrication System if below 30°F or above 120°F?',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'conveyorLoadedOrUnloaded',
          label:
          'Is the Conveyor Loaded or Unloaded at Planned Install Location?',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'conveyorMovement',
          label:
          'Does Conveyor Swing, Sway, Surge, or Move Side-to-Side',
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
          type: ProductFieldType.text,
          hintText:
          'Plant layout attachment information',
        ),
      ],
    ),

    ProductConfigurationSection(
      id: 'customerPowerUtilities',
      title: 'Customer Power Utilities',
      fields: [
        ProductFieldData(
          key: 'operatingVoltageSinglePhase',
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

        ProductFieldData(
          key: 'compressedAirSupplyUnit',
          label: 'Compressed Air Supply Unit',
          type: ProductFieldType.dropdown,
          options: const [
            'PSI',
            'KPI',
            'Bar',
          ],
        ),
      ],
    ),

    ProductConfigurationSection(
      id: 'monitoringSystem',
      title:
      'New Monitoring System or Adding to Existing Monitoring System',
      fields: [
        ProductFieldData(
          key: 'connectingToExistingMonitoring',
          label: 'Connecting to Existing Monitoring',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'addNewMonitoringSystem',
          label: 'Add New Monitoring System',
          type: ProductFieldType.dropdown,
          options: const [
            'Yes',
            'No',
          ],
        ),
      ],
    ),

    ProductConfigurationSection(
      id: 'conveyorSpecifications',
      title: 'Conveyor Specifications',
      fields: [
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
      ],
    ),

    ProductConfigurationSection(
      id: 'controller',
      title: 'Controller',
      fields: [
        ProductFieldData(
          key: 'chainMasterController',
          label: 'ChainMaster Controller',
          type: ProductFieldType.dropdown,
          options: const [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'remote',
          label: 'Remote',
          type: ProductFieldType.dropdown,
          options: const [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'mountedOnGreaser',
          label: 'Mounted on Greaser',
          type: ProductFieldType.dropdown,
          options: const [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'controlsOtherUnits',
          label: 'Controls other units (list):',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'timer',
          label: 'Timer',
          type: ProductFieldType.dropdown,
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
          options: const [
            'On',
            'Off',
          ],
        ),

        ProductFieldData(
          key: 'mightyLubeMonitoring',
          label: 'Mighty Lube Monitoring',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'preMountingRequirements',
          label: 'Pre-Mounting Requirements',
          type: ProductFieldType.dropdown,
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

    ProductConfigurationSection(
      id: 'greaserPowerChainMeasurements',
      title: 'Greaser - Power Chain: Measurements',
      fields: [
        ProductFieldData(
          key: 'measurementUnit',
          label: 'Measurement Unit',
          type: ProductFieldType.dropdown,
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
        ),

        ProductFieldData(
          key: 'powerTrolleyWheelB',
          label: 'Greaser - Power Chain Power Trolley Wheel (B)',
          type: ProductFieldType.text,
          hintText: 'Diameter',
        ),

        ProductFieldData(
          key: 'trolleyWheelBracketWidthC',
          label:
          'Greaser - Power Chain Trolley Wheel Bracket Width @ Trolley Wheel (C)',
          type: ProductFieldType.text,
          hintText:
          'Outside of Left Bracket to Outside of Right Bracket',
        ),

        ProductFieldData(
          key: 'trolleyWheelSpacerD',
          label: 'Greaser - Power Chain Trolley Wheel Spacer (D)',
          type: ProductFieldType.text,
          hintText:
          'Inside of Left Wheel to Inside of Right Wheel',
        ),

        ProductFieldData(
          key: 'zerkFittingVerticalLocationE',
          label:
          'Greaser - Power Chain Zerk Fitting Vertical Location (E)',
          type: ProductFieldType.text,
          hintText:
          'Bottom of Rail to Center of Zerk Fitting',
        ),

        ProductFieldData(
          key: 'zerkFittingHorizontalLocationF',
          label:
          'Greaser - Power Chain Zerk Fitting Horizontal Location (F)',
          type: ProductFieldType.text,
          hintText:
          'Outside of Left Zerk ftg. to Outside of Right Zerk ftg.',
        ),

        ProductFieldData(
          key: 'railG',
          label: 'Greaser - Power Chain Rail (G)',
          type: ProductFieldType.text,
          hintText: 'Width',
        ),

        ProductFieldData(
          key: 'railH',
          label: 'Greaser - Power Chain Rail (H)',
          type: ProductFieldType.text,
          hintText: 'Height',
        ),

        ProductFieldData(
          key: 'trolleyPitchS',
          label:
          'Greaser - Power Chain Trolley Pitch (Minimum - For variable pitch chain, Provide the Minimum Pitch Dimension) (S)',
          type: ProductFieldType.text,
          hintText:
          'Center of Power Wheel to Center of Power Wheel',
        ),
      ],
    ),

    ProductConfigurationSection(
      id: 'technicianNote',
      title: 'Technician Note',
      fields: [
        ProductFieldData(
          key: 'technicianNote',
          label: 'Technician Note',
          type: ProductFieldType.text,
          required: true,
          multiline: true,
        ),
      ],
    ),
  ],
);