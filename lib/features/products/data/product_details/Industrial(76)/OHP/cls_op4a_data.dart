import '../../../../../../core/constants/app_assets.dart';
import '../../../../models/product_detail_data.dart';

const ProductDetailData overheadOp4AData = ProductDetailData(
  id: 'OHP_OP4A',
  title: 'OP-4A',
  imagePath: AppAssets.OHP_CLS_OP4A,
  description: 'The OP-4A air operated oilers are pneumatically powered and electrically timed. A caterpillar chain assembly engages the conveyor chain, engaging the oil dispensing nozzle plate, moving it over the chain pin links. An air operated pump meters a precise amount of oil through each nozzle, lubricating chain pins and links simultaneously. ',
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
          key: 'controlVoltage',
          label: 'Control Voltage (Volts/hz) *',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'compressedAirSupply',
          label: 'Compressed Air Supply *',
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
            'KPI',
            'Bar'
          ],
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
      ],
    ),

    // ============================================================
    // CONVEYOR SPECIFICATIONS
    // ============================================================

    ProductConfigurationSection(
      id: 'conveyorSpecifications',
      title: 'Conveyor Specifications',
      fields: [

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
          key: 'optionalFiveGallonReservoir',
          label: 'Optional 5 Gallon Reservoir',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Yes',
            'No',
          ],
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

    // ============================================================
    // CONTROLLER
    // ============================================================

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
          key: 'controlsOtherUnits',
          label: 'Controls other units',
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
            '1000 Hour'
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
          key: 'pneumaticOnOff',
          label: 'Pneumatic On/Off',
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
          label: 'Pre-Mounting Requirements:',
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
          key: 'otherControllerDescribe',
          label: 'Other Describe',
          type: ProductFieldType.text,
          multiline: true,
        ),

        ProductFieldData(
          key: 'controllerSpecialOptions',
          label:
          'Special Options to Add on to Controller, I/O Link, Plug and Play, Dry Contacts (please specify)',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'controllerPleaseSpecify',
          label: 'Please Specify',
          type: ProductFieldType.text,
          multiline: true,
        ),
      ],
    ),

    // ============================================================
    // OVERHEAD POWER RAIL: MEASUREMENTS
    // ============================================================

    ProductConfigurationSection(
      id: 'overheadPowerRailMeasurements',
      title: 'Overhead Power Rail: Measurements',
      fields: [

        ProductFieldData(
          key: 'measurementUnit',
          label: 'Measurement Unit',
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
          key: 'chainDropA',
          label: 'Chain Drop (A)',
          type: ProductFieldType.text,
          required: true,
          hintText: 'Rail to Center of Chain',
        ),

        ProductFieldData(
          key: 'overheadPowerMonoRailPowerRailG',
          label: 'Overhead Power MonoRail Power Rail (G)',
          type: ProductFieldType.text,
          required: true,
          hintText: 'Width',
        ),

        ProductFieldData(
          key: 'overheadPowerMonoRailPowerRailH',
          label: 'Overhead Power MonoRail Power Rail (H)',
          type: ProductFieldType.text,
          required: true,
          hintText: 'Height',
        ),

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
          required: false,
        ),
      ],
    ),
  ],
);