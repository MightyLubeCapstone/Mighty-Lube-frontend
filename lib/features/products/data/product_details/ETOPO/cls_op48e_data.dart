import 'package:mighty_lube/core/constants/app_assets.dart';
import 'package:mighty_lube/features/products/models/product_detail_data.dart';

const ProductDetailData etopoOp48eData = ProductDetailData(
  id: 'ETO_OP48E',
  title: 'OP-48E Conveyor Lubricators',
  imagePath: AppAssets.etopoOp48e,
  description: 'OP-48E Conveyor Lubricators for enclosed track overhead conveyor systems.',
  configurationSections: [
    // =========================================================
    // GENERAL INFORMATION
    // =========================================================

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
          key: 'chainSize',
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
          key: 'otherIndustrialChainManufacturer',
          label: 'Other Chain Manufacturer',
          type: ProductFieldType.text,
          required: true,
          visibleWhenFieldKey: 'industrialChainManufacturer',
          visibleWhenValue: 'Other',
        ),

        ProductFieldData(
          key: 'conveyorLength',
          label: 'Conveyor Length (Ft/m)',
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
          required: true,
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'conveyorSpeedUnit',
          label: 'Conveyor Speed Unit',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Feet / minute',
            'Meters / minute',
          ],
        ),

        ProductFieldData(
          key: 'conveyorIndex',
          label: 'Indexing or Variable Speed Conditions',
          required: true,
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'travelDirection',
          label: 'Direction of Travel',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Right to Left',
            'Left to Right',
          ],
        ),

        ProductFieldData(
          key: 'appEnviroment',
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
          key: 'otherAppEnviroment',
          label: 'Other Application Environment',
          type: ProductFieldType.text,
          required: true,
          visibleWhenFieldKey: 'appEnviroment',
          visibleWhenValue: 'Other',
        ),

        ProductFieldData(
          key: 'surroundingTemp',
          label: 'Temperature of Surrounding Area at Planned Location of Lubrication System it below 30°F or above 120°F?',
          type: ProductFieldType.text,
          required: true,
        ),
      ],
    ),

    // =========================================================
    // CUSTOMER POWER UTILITIES
    // =========================================================

    ProductConfigurationSection(
      id: 'powerUtilities',
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
      ],
    ),

    // =========================================================
    // MONITORING SYSTEM
    // =========================================================

    ProductConfigurationSection(
      id: 'monitoring',
      title:
      'New Monitoring System or Adding to Existing Monitoring System',
      fields: [
        ProductFieldData(
          key: 'existingMonitoring',
          label: 'Connecting to Existing Monitoring',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'newMonitoringSystem',
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

    // =========================================================
    // CONVEYOR SPECIFICATIONS
    // =========================================================

    ProductConfigurationSection(
      id: 'conveyorSpecifications',
      title: 'Conveyor Specifications',
      fields: [
        ProductFieldData(
          key: 'wheelOpenType',
          label: 'Wheel: Open Race Style',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'wheelClosedType',
          label: 'Wheel: Sealed Style',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'powerChain',
          label: 'Power Chain',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'chainPins',
          label: 'Chain Pins',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'catDriveStatus',
          label: 'Caterpillar Drive',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'catDriveNum',
          label: 'Caterpillar Drive Quantity',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'railLubeStatus',
          label: 'Rail Lubrication',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'externalLubeStatus',
          label: 'External Lubrication',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
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
          key: 'lubeType',
          label: 'Current Lubricant Type',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'lubeViscosity',
          label: 'Current Lubricant Viscosity/Grade',
          type: ProductFieldType.text,
          required: true,
        ),

        ProductFieldData(
          key: 'sideLubeStatus',
          label: 'Lubrication from the Side of Chain',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'topLubeStatus',
          label: 'Lubrication from the Top of Chain',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'chainCleanStatus',
          label: 'Is the Conveyor Chain Clean?',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Yes',
            'No',
          ],
        ),
      ],
    ),

    // =========================================================
    // CONTROLLER
    // =========================================================

    ProductConfigurationSection(
      id: 'controller',
      title: 'Controller',
      fields: [
        ProductFieldData(
          key: 'specialControllerOptions',
          label: 'Special Options to Add on to Controller, I/O Link, Plug and Play, Dry Contacts (please specify)',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'controllerPleaseSpecify',
          label: 'Please Specify',
          type: ProductFieldType.text,
          required: true,
          multiline: true,
        ),
      ],
    ),

    // =========================================================
    // ENCLOSED TRACK OVERHEAD MEASUREMENTS
    // =========================================================

    ProductConfigurationSection(
      id: 'measurements',
      title: 'Enclosed Track Overhead: Measurements',
      fields: [
        ProductFieldData(
          key: 'etUnitType',
          label: 'Measurement Unit',
          required: true,
          type: ProductFieldType.dropdown,
          options: const [
            'Feet',
            'Inches',
            'm Meter',
            'mm Millimeter',
          ],
        ),

        ProductFieldData(
          key: 'etOverheadB',
          label: 'Enclosed Track (Overhead) Power Trolley Wheel (B)',
          type: ProductFieldType.text,
          required: true,
          hintText: '(Diameter)',
          imagePath: AppAssets.etioB,
        ),

        ProductFieldData(
          key: 'etOverheadG',
          label: 'Enclosed Track (Overhead) Power Rail (G)',
          type: ProductFieldType.text,
          required: true,
          hintText: '(Width)',
          imagePath: AppAssets.etioG,
        ),

        ProductFieldData(
          key: 'etOverheadH',
          label: 'Enclosed Track (Overhead) Power Rail (H)',
          type: ProductFieldType.text,
          required: true,
          hintText: '(Height)',
          imagePath: AppAssets.etioH,
        ),

        ProductFieldData(
          key: 'etOverheadS',
          label: 'Enclosed Track (Overhead) Trolley Pitch [Spacing] Minimum - For variable pitch chain, Provide the Minimum Pitch Dimension (S)',
          type: ProductFieldType.text,
          required: true,
          hintText: '(Center of Power Wheel to Center of Power Wheel)',
          imagePath: AppAssets.etioS,
        ),

        ProductFieldData(
          key: 'etOverheadK2',
          label: 'Enclosed Track (Overhead) Free Trolley Wheel (K2)',
          type: ProductFieldType.text,
          required: true,
          hintText: '(Diameter)',
          imagePath: AppAssets.etioK2,
        ),

        ProductFieldData(
          key: 'etOverheadL2',
          label: 'Enclosed Track (Overhead) Free Rail (L2)',
          type: ProductFieldType.text,
          required: true,
          hintText: '(Width)',
          imagePath: AppAssets.etioL2,
        ),

        ProductFieldData(
          key: 'etOverheadM2',
          label: 'Enclosed Track (Overhead) Free Rail (M2)',
          type: ProductFieldType.text,
          required: true,
          hintText: '(Height)',
          imagePath: AppAssets.etioM2,
        ),

        ProductFieldData(
          key: 'etOverheadN2',
          label: 'Enclosed Track (Overhead) Free Rail Vertical Position (Height) (N2)',
          type: ProductFieldType.text,
          required: true,
          hintText: '(Top of Power Rail to Bottom of Free Rail)',
          imagePath: AppAssets.etioN2,
        ),

        ProductFieldData(
          key: 'etOverheadS2',
          label: 'Enclosed Track (Overhead) Power Trolley Wheel Pitch (S2)',
          type: ProductFieldType.text,
          required: true,
          hintText: '(Center of Trolley Wheel to Center of Trolley Wheel)',
          imagePath: AppAssets.etioS2,
        ),
      ],
    ),

    // =======================================================
    // TECHNICIAN NOTE
    //
    // Existing app-specific field.
    // Kept optional.
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