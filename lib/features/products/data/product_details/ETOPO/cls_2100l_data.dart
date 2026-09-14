import 'package:mighty_lube/core/constants/app_assets.dart';
import 'package:mighty_lube/features/products/models/product_detail_data.dart';

const ProductDetailData etopo2100LData = ProductDetailData(
  id: 'ETO_2100',
  title: '2100L Series Self-Contained Conveyor Lubricators',
  imagePath: AppAssets.etopo2100L,
  description:
  '2100L Series Self-Contained Conveyor Lubricators for Enclosed Track Overhead conveyor systems.',
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
        ),

        // -----------------------------------------------------
        // CONVEYOR CHAIN SIZE
        // Website confirmed dropdown options
        // -----------------------------------------------------
        ProductFieldData(
          key: 'chainSize',
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

        // Website shows additional field when Other is selected.
        ProductFieldData(
          key: 'otherChainSize',
          label: 'Other Conveyor Chain Size',
          type: ProductFieldType.text,
          visibleWhenFieldKey: 'chainSize',
          visibleWhenValue: 'Other',
        ),

        // -----------------------------------------------------
        // CHAIN MANUFACTURER
        // Website confirmed dropdown options
        // -----------------------------------------------------
        ProductFieldData(
          key: 'industrialChainManufacturer',
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
          key: 'otherIndustrialChainManufacturer',
          label: 'Other Chain Manufacturer',
          type: ProductFieldType.text,
          visibleWhenFieldKey: 'industrialChainManufacturer',
          visibleWhenValue: 'Other',
        ),

        ProductFieldData(
          key: 'conveyorLength',
          label: 'Conveyor Length',
          type: ProductFieldType.text,
        ),

        // Website confirmed exact options.
        ProductFieldData(
          key: 'conveyorLengthUnit',
          label: 'Conveyor Length Unit',
          type: ProductFieldType.dropdown,
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
        ),

        // Website confirmed exact options.
        ProductFieldData(
          key: 'conveyorSpeedUnit',
          label: 'Conveyor Speed',
          type: ProductFieldType.dropdown,
          options: const [
            'Feet / minute',
            'Meters / minute',
          ],
        ),

        ProductFieldData(
          key: 'conveyorIndex',
          label: 'Indexing or Variable Speed Conditions',
          type: ProductFieldType.text,
        ),

        // Website confirmed exact options.
        ProductFieldData(
          key: 'travelDirection',
          label: 'Direction of Travel',
          type: ProductFieldType.dropdown,
          options: const [
            'Right to Left',
            'Left to Right',
          ],
        ),

        // -----------------------------------------------------
        // APPLICATION ENVIRONMENT
        // Website marks this field required.
        // Website confirmed exact dropdown options.
        // -----------------------------------------------------
        ProductFieldData(
          key: 'appEnviroment',
          label: 'Application Environment *',
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
          visibleWhenFieldKey: 'appEnviroment',
          visibleWhenValue: 'Other',
        ),

        ProductFieldData(
          key: 'surroundingTemp',
          label:
          'Temperature of Surrounding Area at Planned Location of Lubrication System it below 30°F or above 120°F?',
          type: ProductFieldType.dropdown,
          options: const [
            'Yes',
            'No',
          ],
        ),

        // Website confirmed exact options + required marker.
        ProductFieldData(
          key: 'conveyorLoaded',
          label:
          'Is the Conveyor Loaded or Unloaded at Planned Install Location? *',
          type: ProductFieldType.dropdown,
          required: true,
          options: const [
            'Loaded',
            'Unloaded',
          ],
        ),

        ProductFieldData(
          key: 'conveyorSwing',
          label:
          'Does Conveyor Swing, Sway, Surge, or Move Side-to-Side *',
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
    // CUSTOMER POWER UTILITIES
    // =========================================================
    ProductConfigurationSection(
      id: 'powerUtilities',
      title: 'Customer Power Utilities',
      fields: [
        ProductFieldData(
          key: 'operatingVoltage',
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

    // =========================================================
    // MONITORING
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
          options: const [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'newMonitoringSystem',
          label: 'Add New Monitoring System',
          type: ProductFieldType.dropdown,
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
          type: ProductFieldType.text,
        ),
        ProductFieldData(
          key: 'wheelClosedType',
          label: 'Wheel: Sealed Style',
          type: ProductFieldType.text,
        ),
        ProductFieldData(
          key: 'powerChain',
          label: 'Power Chain',
          type: ProductFieldType.text,
        ),
        ProductFieldData(
          key: 'chainPins',
          label: 'Chain Pins',
          type: ProductFieldType.dropdown,
          options: const [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'catDriveStatus',
          label: 'Caterpillar Drive',
          type: ProductFieldType.text,
        ),
        ProductFieldData(
          key: 'catDriveNum',
          label: 'Caterpillar Drive Quantity',
          type: ProductFieldType.text,
        ),
        ProductFieldData(
          key: 'railLubeStatus',
          label: 'Rail Lubrication',
          type: ProductFieldType.text,
        ),
        ProductFieldData(
          key: 'externalLubeStatus',
          label: 'External Lubrication',
          type: ProductFieldType.text,
        ),
        ProductFieldData(
          key: 'lubeBrand',
          label: 'Current Lubrication Equipment (Brand)',
          type: ProductFieldType.text,
        ),
        ProductFieldData(
          key: 'lubeType',
          label: 'Current Lubricant Type',
          type: ProductFieldType.text,
        ),
        ProductFieldData(
          key: 'lubeViscosity',
          label: 'Current Lubricant Viscosity/Grade',
          type: ProductFieldType.text,
        ),
        ProductFieldData(
          key: 'sideLubeStatus',
          label: 'Lubrication from the Side of Chain',
          type: ProductFieldType.dropdown,
          options: const [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'topLubeStatus',
          label: 'Lubrication from the Top of Chain',
          type: ProductFieldType.dropdown,
          options: const [
            'Yes',
            'No',
          ],
        ),
        ProductFieldData(
          key: 'chainCleanStatus',
          label: 'Is the Conveyor Chain Clean?',
          type: ProductFieldType.dropdown,
          options: const [
            'Yes',
            'No',
          ],
        ),
      ],
    ),

    // =========================================================
    // WIRE
    // Current website has Wire.
    // Old duplicate Controller section is intentionally removed.
    // =========================================================
    ProductConfigurationSection(
      id: 'wire',
      title: 'Wire',
      fields: [
        ProductFieldData(
          key: 'wireMeasurementUnit',
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
          key: 'conductor2',
          label: '2 Conductor',
          type: ProductFieldType.text,
        ),
        ProductFieldData(
          key: 'conductor4',
          label: '4 Conductor',
          type: ProductFieldType.text,
        ),
        ProductFieldData(
          key: 'conductor7',
          label: '7 Conductor',
          type: ProductFieldType.text,
        ),
        ProductFieldData(
          key: 'conductor12',
          label: '12 Conductor',
          type: ProductFieldType.text,
        ),
        ProductFieldData(
          key: 'junctionBoxNum',
          label: 'Junction Box Quantities',
          type: ProductFieldType.text,
        ),
      ],
    ),

    // =========================================================
    // ENCLOSED TRACK OVERHEAD: MEASUREMENTS
    // =========================================================
    ProductConfigurationSection(
      id: 'measurements',
      title: 'Enclosed Track Overhead: Measurements',
      fields: [
        ProductFieldData(
          key: 'etUnitType',
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
          key: 'etOverheadB',
          label: 'Enclosed Track (Overhead) Power Trolley Wheel (B)',
          type: ProductFieldType.text,
          hintText: '(Diameter)',
          imagePath: 'assets/Measurements/4/CMS/B.png',
        ),

        ProductFieldData(
          key: 'etOverheadG',
          label: 'Enclosed Track (Overhead) Power Rail (G)',
          type: ProductFieldType.text,
          hintText: '(Width)',
          imagePath: 'assets/Measurements/4/CMS/G.png',
        ),

        ProductFieldData(
          key: 'etOverheadH',
          label: 'Enclosed Track (Overhead) Power Rail (H)',
          type: ProductFieldType.text,
          hintText: '(Height)',
          imagePath: 'assets/Measurements/4/CMS/H.png',
        ),

        ProductFieldData(
          key: 'etOverheadS',
          label:
          'Enclosed Track (Overhead) Trolley Pitch [Spacing] Minimum - For variable pitch chain, Provide the Minimum Pitch Dimension (S)',
          type: ProductFieldType.text,
          hintText: '(Center of Power Wheel to Center of Power Wheel)',
          imagePath: 'assets/Measurements/4/CMS/S.png',
        ),

        ProductFieldData(
          key: 'etOverheadK2',
          label: 'Enclosed Track (Overhead) Free Trolley Wheel (K2)',
          type: ProductFieldType.text,
          hintText: '(Diameter)',
          imagePath: 'assets/Measurements/4/CMS/K2.png',
        ),

        ProductFieldData(
          key: 'etOverheadL2',
          label: 'Enclosed Track (Overhead) Free Rail (L2)',
          type: ProductFieldType.text,
          hintText: '(Width)',
          imagePath: 'assets/Measurements/4/CMS/L2.png',
        ),

        // Website explicitly shows Height here.
        ProductFieldData(
          key: 'etOverheadM2',
          label: 'Enclosed Track (Overhead) Free Rail (M2)',
          type: ProductFieldType.text,
          hintText: '(Height)',
          imagePath: 'assets/Measurements/4/CMS/M2.png',
        ),

        // Current website itself shows this oddly named field.
        // Kept because website is our source of truth.
        ProductFieldData(
          key: 'measurementDropdown',
          label: 'Dropdown',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'etOverheadN2',
          label:
          'Enclosed Track (Overhead) Free Rail Vertical Position (Height) (N2)',
          type: ProductFieldType.text,
          hintText: '(Top of Power Rail to Bottom of Free Rail)',
          imagePath: 'assets/Measurements/4/CMS/N2.png',
        ),

        ProductFieldData(
          key: 'etOverheadS2',
          label: 'Enclosed Track (Overhead) Power Trolley Wheel Pitch (S2)',
          type: ProductFieldType.text,
          hintText: '(Center of Trolley Wheel to Center of Trolley Wheel)',
          imagePath: 'assets/Measurements/4/CMS/S2.png',
        ),
      ],
    ),
  ],
);