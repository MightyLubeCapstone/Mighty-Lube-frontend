import '../../../../../core/constants/app_assets.dart';
import '../../../models/product_detail_data.dart';

const ProductDetailData overheadMultiLinePermanentMonitoringLubricationData =
ProductDetailData(
  id: 'OHP_MLP',
  title: 'Multi Line (Permanent) ALL IN ONE Monitoring + Lubrication',
  imagePath: AppAssets.ohprlbCmsMlaio,
  description: 'The Next Generation Permanent Conveyor Monitoring System is connected to the network and provides chain wear data and projections for up to 100 conveyor lines measuring wear in Link by Link and 10’ sections. This system monitors drive amps, chain speed, take-up pressure and drive hours. It also provides data on lube cycles, reservoir levels, head voltage and pump cycles when combined with Mighty Lube or OPCO lubrication systems. ',
  configurationSections: [

    // ============================================================
    // GENERAL INFORMATION
    // ============================================================

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
          key: 'otherConveyorChainSize',
          label: 'Other – Conveyor Chain Size',
          type: ProductFieldType.text,
          required: true,
          visibleWhenFieldKey: 'conveyorChainSize',
          visibleWhenValue: 'Other',
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
          key: 'otherChainManufacturer',
          label: 'Other – Chain Manufacturer',
          type: ProductFieldType.text,
          required: true,
          visibleWhenFieldKey: 'chainManufacturer',
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
            'Meter',
            'Millimeter',
          ],
        ),

        ProductFieldData(
            key: 'conveyorSpeed',
            label: 'Conveyor Speed (Min/Max)',
            type: ProductFieldType.text,
            required: true
        ),

        ProductFieldData(
          key: 'conveyorSpeedUnit',
          label: 'Conveyor Speed Unit',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Feet',
            'Inches',
            'm Meter',
            'mm Millimeter'
          ],
        ),

        ProductFieldData(
            key: 'indexingOrVariableSpeedConditions',
            label: 'Indexing or Variable Speed Conditions',
            type: ProductFieldType.text,
            required: true
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
          key: 'otherApplicationEnvironment',
          label: 'Other – Application Environment',
          type: ProductFieldType.text,
          required: true,
          visibleWhenFieldKey: 'applicationEnvironment',
          visibleWhenValue: 'Other',
        ),

        ProductFieldData(
          key: 'surroundingTemp',
          label: 'Is the temperature at the planned lubrication system location below 30°F or above 120°F?',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),


        ProductFieldData(
          key: 'conveyorLoadedOrUnloaded',
          label: 'Is the Conveyor Loaded or Unloaded at Planned Install Location? *',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'conveyorMovement',
          label: 'Does Conveyor Swing, Sway, Surge, or Move Side-to-Side *',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),
      ],
    ),

    // ============================================================
    // CUSTOMER POWER UTILITIES
    // ============================================================

    ProductConfigurationSection(
      id: 'customerPowerUtilities',
      title: 'Customer Power Utilities',
      fields: [
        ProductFieldData(
          key: 'operatingVoltageSinglePhase',
          label: 'Operating Voltage - Single Phase: (Volts/hz) *',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'controlVoltage',
          label: 'Control Voltage (Volts/hz) *',
          type: ProductFieldType.text,
          required: true,
        ),

      ],
    ),

    // ============================================================
    // NEW MONITORING SYSTEM OR ADDING TO EXISTING MONITORING SYSTEM
    // ============================================================

    ProductConfigurationSection(
      id: 'monitoringSystem',
      title: 'New Monitoring System or Adding to Existing Monitoring System',
      fields: [
        ProductFieldData(
          key: 'connectingToExistingMonitoring',
          label: 'Connecting to Existing Monitoring',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No'
          ]
        ),

        ProductFieldData(
          key: 'addNewMonitoringSystem',
          label: 'Add New Monitoring System',
            type: ProductFieldType.dropdown,
            required: true,
            options: [
              'Yes',
              'No'
            ]

        ),
      ],
    ),

    // ============================================================
    // CONVEYOR SPECIFICATIONS
    // ============================================================

    ProductConfigurationSection(
      id: 'conveyor',
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
            'Open Outside',
          ],
        ),

        ProductFieldData(
          key: 'wheelClosedType',
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
          key: 'catDriveStatus',
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
          key: 'railLubeStatus',
          label: 'Rail Lubrication',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'externalLubeStatus',
          label: 'External Lubrication',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'lubeBrand',
          label: 'Current Lubrication Equipment Brand',
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
          label: 'Current Lubricant Viscosity / Grade',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'lubricationSideChain',
          label: 'Lubrication from the Side of Chain',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
        ),

        // Existing useful OP-40E field retained.
        ProductFieldData(
          key: 'lubricationTopChain',
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
            '65 Gallon'
          ]
        ),

        ProductFieldData(
          key: 'reservoirSizeQuantity',
          label: 'Reservoir Size Quantity',
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

    // ============================================================
    // CONTROLLER
    // ============================================================

    ProductConfigurationSection(
      id: 'controller',
      title: 'Controller',
      fields: [
        ProductFieldData(
          key: 'specialControllerOptions',
          label: 'Special Options to Add on to Controller, I/O Link, Plug and Play, Dry Contacts (please specify)',
          type: ProductFieldType.text,
          required: true,
        ),
        ProductFieldData(
          key: 'controllerSpecify',
          label: 'Please Specify',
          type: ProductFieldType.text,
          multiline: true,
        ),
      ],
    ),


    // ============================================================
    // Overhead Power Rail: Measurements
    // ============================================================

    ProductConfigurationSection(
      id: 'measurements',
      title: 'Overhead Power Rail: Measurements',
      fields: [
        // Website only visibly confirmed "Feet".
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
          hintText: 'Feet',
        ),

        ProductFieldData(
          key: 'overheadPowerMonoRailPowerTrolleyWheelB',
          label: 'Overhead Power MonoRail Power Trolley Wheel (B)',
          hintText: 'Diameter',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'overheadPowerMonoRailPowerRailG',
          label: 'Overhead Power MonoRail Power Rail (G)',
          hintText: 'Width',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'overheadPowerMonoRailPowerRailH',
          label: 'Overhead Power MonoRail Power Rail (H)',
          hintText: 'Height',
          type: ProductFieldType.text,
          required: true,
        ),

        // Two additional dropdowns were visible in the website
        // recording, but their labels/options were not readable.
        // They are intentionally not invented here.
      ],
    ),


    // ============================================================
    // TECHNICIAN NOTE
    // ============================================================

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