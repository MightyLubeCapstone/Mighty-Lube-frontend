import '../../../../../../core/constants/app_assets.dart';
import '../../../../models/product_detail_data.dart';

const ProductDetailData pfo9000LCCLData = ProductDetailData(
  id: '9000LCCL',
  title: '9000L Series Central System Power and Free C-Channel Conveyor Lubricators',
  imagePath: AppAssets.PFO_CLS_9000LCCL,
  description: '9000L Series Central System Power and Free C-Channel Conveyor Lubricators configuration.',
  configurationSections: [
    // ========================================================
    // GENERAL INFORMATION
    // ========================================================

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
            'Meters /minute',
          ],
        ),
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
          label:
          'Temperature of Surrounding Area at Planned Location of Lubrication System it below 30°F or above 120°F?',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'conveyorLoadedOrUnloaded',
          label:
          'Is the Conveyor Loaded or Unloaded at Planned Install Location?',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Loaded',
            'Unloaded',
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

    // ========================================================
    // CUSTOMER POWER UTILITIES
    // ========================================================

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
      ],
    ),

    // ========================================================
    // NEW MONITORING SYSTEM OR ADDING TO EXISTING MONITORING
    // ========================================================

    ProductConfigurationSection(
      id: 'monitoringSystem',
      title: 'New Monitoring System or Adding to Existing Monitoring System',
      fields: [
        // First 3 - keep as Yes / No dropdowns
        ProductFieldData(
          key: 'connectingToExistingMonitoring',
          label: 'Connecting to Existing Monitoring',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'addNewMonitoringSystem',
          label: 'Add New Monitoring System',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'addDcu',
          label: 'Add DCU',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'dcuQuantity',
          label: 'Number of DCU',
          type: ProductFieldType.text,
          required: true,
          visibleWhenFieldKey: 'addDcu',
          visibleWhenValue: 'Yes'
        ),
      ],
    ),

    // ========================================================
    // IT INFORMATION
    // ========================================================

    ProductConfigurationSection(
      id: 'itInformation',
      title: 'IT Information (PLC does not need IP Address)',
      fields: [
        // IT INFORMATION - 1
        ProductFieldData(
          key: 'itName1',
          label: 'Name',
          type: ProductFieldType.text,
          required: true,
        ),
        ProductFieldData(
          key: 'itIpAddress1',
          label: 'IP Address',
          type: ProductFieldType.text,
          required: true,
        ),
        ProductFieldData(
          key: 'itGateway1',
          label: 'Gateway',
          type: ProductFieldType.text,
          required: true,
        ),
        ProductFieldData(
          key: 'itSubnet1',
          label: 'Subnet',
          type: ProductFieldType.text,
          required: true,
        ),
        ProductFieldData(
          key: 'itDns1',
          label: 'DNS',
          type: ProductFieldType.text,
          required: true,
        ),
        ProductFieldData(
          key: 'itSmtp1',
          label: 'SMTP',
          type: ProductFieldType.text,
          required: true,
        ),

        // IT INFORMATION - 2
        ProductFieldData(
          key: 'itName2',
          label: 'Name',
          type: ProductFieldType.text,
          required: false,
        ),
        ProductFieldData(
          key: 'itIpAddress2',
          label: 'IP Address',
          type: ProductFieldType.text,
          required: false,
        ),
        ProductFieldData(
          key: 'itGateway2',
          label: 'Gateway',
          type: ProductFieldType.text,
          required: false,
        ),
        ProductFieldData(
          key: 'itSubnet2',
          label: 'Subnet',
          type: ProductFieldType.text,
          required: false,
        ),
        ProductFieldData(
          key: 'itDns2',
          label: 'DNS',
          type: ProductFieldType.text,
          required: false,
        ),
        ProductFieldData(
          key: 'itSmtp2',
          label: 'SMTP',
          type: ProductFieldType.text,
          required: false,
        ),

        // IT INFORMATION - 3
        ProductFieldData(
          key: 'itName3',
          label: 'Name',
          type: ProductFieldType.text,
          required: false,
        ),
        ProductFieldData(
          key: 'itIpAddress3',
          label: 'IP Address',
          type: ProductFieldType.text,
          required: false,
        ),
        ProductFieldData(
          key: 'itGateway3',
          label: 'Gateway',
          type: ProductFieldType.text,
          required: false,
        ),
        ProductFieldData(
          key: 'itSubnet3',
          label: 'Subnet',
          type: ProductFieldType.text,
          required: false,
        ),
        ProductFieldData(
          key: 'itDns3',
          label: 'DNS',
          type: ProductFieldType.text,
          required: false,
        ),
        ProductFieldData(
          key: 'itSmtp3',
          label: 'SMTP',
          type: ProductFieldType.text,
          required: false,
        ),
        ProductFieldData(
          key: 'itNotes',
          label: 'Notes',
          type: ProductFieldType.text,
          required: false,
          hintText: 'Provide additional IT information in the notes',
          multiline: true,
        ),
      ],
    ),

    // ========================================================
    // CONVEYOR SPECIFICATIONS
    // ========================================================

    ProductConfigurationSection(
      id: 'conveyorSpecifications',
      title: 'Conveyor Specifications',
      fields: [
        ProductFieldData(
          key: 'wheelOpenRaceStyle',
          label: 'Wheel: Open Race Style',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'No Applicable',
            'Open Inside',
            'Open Outside',
          ],
        ),
        ProductFieldData(
          key: 'wheelSealedStyle',
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
          key: 'powerChain',
          label: 'Power Chain',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'chainPins',
          label: 'Chain Pins',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'caterpillarDrive',
          label: 'Caterpillar Drive',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'caterpillarDriveQuantity',
          label: 'Caterpillar Drive Quantity',
          type: ProductFieldType.text,
          required: true,
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
          key: 'externalLubrication',
          label: 'External Lubrication',
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
        ProductFieldData(
          key: 'reservoirSize',
          label: 'Reservoir Size',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            '10 Gallon',
            '65 Gallon',
          ],
        ),
        ProductFieldData(
          key: 'reservoirSizeQuantity',
          label: 'Reservoir Size Quantity',
          type: ProductFieldType.text,
          required: true,
        ),
        ProductFieldData(
          key: 'conveyorChainClean',
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

    // ========================================================
    // CONTROLLER
    // ========================================================

    ProductConfigurationSection(
      id: 'controller',
      title: 'Controller',
      fields: [
        ProductFieldData(
          key: 'controllerSpecialOptions',
          label:
          'Special Options to Add on to Controller, I/O Link, Plug and Play, Dry Contacts (please specify)',
          type: ProductFieldType.text,
          required: true,
        ),
        ProductFieldData(
          key: 'controllerPleaseSpecify',
          label: 'Please Specify',
          type: ProductFieldType.text,
          required: false,
          multiline: true,
        ),
      ],
    ),

    // ========================================================
    // WIRE
    // ========================================================

    ProductConfigurationSection(
      id: 'wire',
      title: 'Wire',
      fields: [
        ProductFieldData(
          key: 'wireMeasurementUnit',
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
          key: 'twoConductor',
          label: '2 Conductor',
          type: ProductFieldType.text,
          required: true,
        ),
        ProductFieldData(
          key: 'fourConductor',
          label: '4 Conductor',
          type: ProductFieldType.text,
          required: true,
        ),
        ProductFieldData(
          key: 'sevenConductor',
          label: '7 Conductor',
          type: ProductFieldType.text,
          required: true,
        ),
        ProductFieldData(
          key: 'twelveConductor',
          label: '12 Conductor',
          type: ProductFieldType.text,
          required: true,
        ),
        ProductFieldData(
          key: 'junctionBoxQuantities',
          label: 'Junction Box Quantities',
          type: ProductFieldType.text,
          required: true,
        ),
      ],
    ),

    // ========================================================
    // P&F: MEASUREMENTS
    // ========================================================

    ProductConfigurationSection(
      id: 'powerAndFreeMeasurements',
      title: 'P&F: Measurements',
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
          key: 'freeTrolleyWheelPositionVerticalL',
          label: 'Overhead P&F Free Rail Free Trolley Wheel Position (Vertical) (L)',
          type: ProductFieldType.text,
          required: true,
          hintText: 'Center of Free Trolley Wheel to Bottom of Rail',
          imagePath: AppAssets.PFO_CLS_9000l_L,
        ),
        ProductFieldData(
          key: 'overheadFreeRailG',
          label: 'Overhead P&F Free Rail Rail (G)',
          type: ProductFieldType.text,
          required: true,
          hintText: 'Width',
          imagePath: AppAssets.PFO_CLS_9000l_G,
        ),
        ProductFieldData(
          key: 'overheadFreeRailH',
          label: 'Overhead P&F Free Rail Rail (H)',
          type: ProductFieldType.text,
          required: true,
          hintText: 'Height',
          imagePath: AppAssets.PFO_CLS_9000l_H,
        ),
        ProductFieldData(
          key: 'invertedPowerAndFreeChainDropA',
          label: 'Inverted Power and Free Chain Drop (A)',
          type: ProductFieldType.text,
          required: true,
          hintText: 'Center of Chain to Opposite Edge of Rail',
          imagePath: AppAssets.PFO_CLS_9000l_A,
        ),
        ProductFieldData(
          key: 'invertedPowerTrolleyWheelB',
          label: 'Inverted Power and Free Power Trolley Wheel (B)',
          type: ProductFieldType.text,
          required: true,
          hintText: 'Diameter',
          imagePath: AppAssets.PFO_CLS_9000l_B,
        ),
        ProductFieldData(
          key: 'invertedPowerAndFreeRailG',
          label: 'Inverted Power and Free Rail (G)',
          type: ProductFieldType.text,
          required: true,
          hintText: 'Width',
          imagePath: AppAssets.PFO_CLS_9000l_G2,
        ),
        ProductFieldData(
          key: 'invertedPowerAndFreeRailH',
          label: 'Inverted Power and Free Rail (H)',
          type: ProductFieldType.text,
          required: true,
          hintText: 'Height',
          imagePath: AppAssets.PFO_CLS_9000l_H,
        ),
        ProductFieldData(
          key: 'invertedPowerAndFreeTrolleyPitchK2',
          label: 'Inverted Power and Free Trolley Pitch [Spacing] Minimum - For variable pitch chain, Provide the Minimum Pitch Dimension (K2)',
          type: ProductFieldType.text,
          required: true,
          hintText: 'Center of Power Wheel to Center of Power Wheel',
          imagePath: AppAssets.PFO_CLS_9000l_K2,
        ),
        ProductFieldData(
          key: 'invertedPowerAndFreeTrolleyPitchL2',
          label: 'Inverted Power and Free Trolley Pitch [Spacing] Minimum - For variable pitch chain, Provide the Minimum Pitch Dimension (L2)',
          type: ProductFieldType.text,
          required: true,
          hintText: 'Center of Power Wheel to Center of Power Wheel',
          imagePath: AppAssets.PFO_CLS_9000l_L2,
        ),
        ProductFieldData(
          key: 'invertedPowerAndFreeTrolleyPitchM2',
          label: 'Inverted Power and Free Trolley Pitch [Spacing] Minimum - For variable pitch chain, Provide the Minimum Pitch Dimension (M2)',
          type: ProductFieldType.text,
          required: true,
          hintText: 'Center of Power Wheel to Center of Power Wheel',
          imagePath: AppAssets.PFO_CLS_9000l_M2,
        ),
        ProductFieldData(
          key: 'invertedPowerAndFreeTrolleyPitchN2',
          label: 'Inverted Power and Free Trolley Pitch [Spacing] Minimum - For variable pitch chain, Provide the Minimum Pitch Dimension (N2)',
          type: ProductFieldType.text,
          required: true,
          hintText: 'Center of Power Wheel to Center of Power Wheel',
          imagePath: AppAssets.PFO_CLS_9000l_N2,
        ),
      ],
    ),

    // ========================================================
    // TECHNICIAN NOTE
    // ========================================================

    ProductConfigurationSection(
      id: 'technician',
      title: 'Technician',
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