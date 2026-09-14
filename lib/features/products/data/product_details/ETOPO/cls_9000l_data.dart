import '../../../../../core/constants/app_assets.dart';
import '../../../models/product_detail_data.dart';

const ProductDetailData etopo9000LData = ProductDetailData(
  id: 'ETO_9000E',
  title: '9000L Series Enclosed Track Conveyor Lubricators',
  imagePath: AppAssets.etopo9000L,
  description: '9000L Series Enclosed Track Conveyor Lubricators for overhead enclosed track conveyor systems.',
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
          required: false,
        ),

        ProductFieldData(
          key: 'chainSize',
          label: 'Conveyor Chain Size',
          type: ProductFieldType.dropdown,
          required: false,
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
          required: false,
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
          label: 'Conveyor Length',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'conveyorLengthUnit',
          label: 'Conveyor Length Unit',
          type: ProductFieldType.dropdown,
          required: false,
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
          required: false,
        ),

        ProductFieldData(
          key: 'conveyorSpeedUnit',
          label: 'Conveyor Speed Unit',
          type: ProductFieldType.dropdown,
          required: false,
          options: const [
            'Feet / minute',
            'Meters / minute',
          ],
        ),

        ProductFieldData(
          key: 'conveyorIndex',
          label: 'Indexing or Variable Speed Conditions',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'travelDirection',
          label: 'Direction of Travel',
          type: ProductFieldType.dropdown,
          required: false,
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
          label:
          'Temperature of Surrounding Area at Planned Location of Lubrication System it below 30°F or above 120°F?',
          type: ProductFieldType.dropdown,
          required: false,
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
    // MONITORING
    // =========================================================

    ProductConfigurationSection(
      id: 'monitoring',
      title: 'New Monitoring System or Adding to Existing Monitoring System',
      fields: [
        ProductFieldData(
          key: 'existingMonitoring',
          label: 'Connecting to Existing Monitoring',
          type: ProductFieldType.dropdown,
          required: false,
          options: const [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'newMonitoringSystem',
          label: 'Add New Monitoring System',
          type: ProductFieldType.dropdown,
          required: false,
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
          required: false,
          options: const [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'wheelClosedType',
          label: 'Wheel: Sealed Style',
          type: ProductFieldType.dropdown,
          required: false,
          options: const [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'powerChain',
          label: 'Power Chain',
          type: ProductFieldType.dropdown,
          required: false,
          options: const [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'chainPins',
          label: 'Chain Pins',
          type: ProductFieldType.dropdown,
          required: false,
          options: const [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'catDriveStatus',
          label: 'Caterpillar Drive',
          type: ProductFieldType.dropdown,
          required: false,
          options: const [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'catDriveNum',
          label: 'Caterpillar Drive Quantity',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'railLubeStatus',
          label: 'Rail Lubrication',
          type: ProductFieldType.dropdown,
          required: false,
          options: const [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'externalLubeStatus',
          label: 'External Lubrication',
          type: ProductFieldType.dropdown,
          required: false,
          options: const [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'lubeBrand',
          label: 'Current Lubrication Equipment (Brand)',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'lubeType',
          label: 'Current Lubricant Type',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'lubeViscosity',
          label: 'Current Lubricant Viscosity/Grade',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'sideLubeStatus',
          label: 'Lubrication from the Side of Chain',
          type: ProductFieldType.dropdown,
          required: false,
          options: const [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'topLubeStatus',
          label: 'Lubrication from the Top of Chain',
          type: ProductFieldType.dropdown,
          required: false,
          options: const [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'reservoirSize',
          label: 'Reservoir Size',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'reservoirSizeQuantity',
          label: 'Reservoir Size Quantity',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'chainCleanStatus',
          label: 'Is the Conveyor Chain Clean?',
          type: ProductFieldType.dropdown,
          required: false,
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
          label:
          'Special Options to Add on to Controller, I/O Link, Plug and Play, Dry Contacts (please specify)',
          type: ProductFieldType.dropdown,
          required: false,
          options: const [
            'Yes',
            'No',
          ],
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

    // =========================================================
    // WIRE
    // =========================================================

    ProductConfigurationSection(
      id: 'wire',
      title: 'Wire',
      fields: [
        ProductFieldData(
          key: 'wireMeasurementUnit',
          label: 'Measurement Unit',
          type: ProductFieldType.dropdown,
          required: false,
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
          required: false,
        ),

        ProductFieldData(
          key: 'conductor4',
          label: '4 Conductor',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'conductor7',
          label: '7 Conductor',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'conductor12',
          label: '12 Conductor',
          type: ProductFieldType.text,
          required: false,
        ),

        ProductFieldData(
          key: 'junctionBoxNum',
          label: 'Junction Box Quantities',
          type: ProductFieldType.text,
          required: false,
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
          key: 'enclosedUnitType',
          label: 'Measurement Unit',
          type: ProductFieldType.dropdown,
          required: false,
          options: const [
            'Feet',
            'Inches',
            'm Meter',
            'mm Millimeter',
          ],
        ),

        ProductFieldData(
          key: 'enclosedTrackB',
          label: 'Enclosed Track (Overhead) Power Trolley Wheel (B)',
          type: ProductFieldType.text,
          required: false,
          hintText: '(Diameter)',
          imagePath: 'assets/Measurements/4/CMS/B.png',
        ),

        ProductFieldData(
          key: 'enclosedTrackG',
          label: 'Enclosed Track (Overhead) Power Rail (G)',
          type: ProductFieldType.text,
          required: false,
          hintText: '(Width)',
          imagePath: 'assets/Measurements/4/CMS/G.png',
        ),

        ProductFieldData(
          key: 'enclosedTrackH',
          label: 'Enclosed Track (Overhead) Power Rail (H)',
          type: ProductFieldType.text,
          required: false,
          hintText: '(Height)',
          imagePath: 'assets/Measurements/4/CMS/H.png',
        ),

        ProductFieldData(
          key: 'enclosedTrackS',
          label:
          'Enclosed Track (Overhead) Trolley Pitch [Spacing] Minimum - For variable pitch chain, Provide the Minimum Pitch Dimension (S)',
          type: ProductFieldType.text,
          required: false,
          hintText: '(Center of Power Wheel to Center of Power Wheel)',
          imagePath: 'assets/Measurements/4/CMS/S.png',
        ),

        ProductFieldData(
          key: 'enclosedTrackK2',
          label: 'Enclosed Track (Overhead) Free Trolley Wheel (K2)',
          type: ProductFieldType.text,
          required: false,
          hintText: '(Diameter)',
          imagePath: 'assets/Measurements/4/CMS/K2.png',
        ),

        ProductFieldData(
          key: 'enclosedTrackL2',
          label: 'Enclosed Track (Overhead) Free Rail (L2)',
          type: ProductFieldType.text,
          required: false,
          hintText: '(Width)',
          imagePath: 'assets/Measurements/4/CMS/L2.png',
        ),

        ProductFieldData(
          key: 'enclosedTrackM2',
          label: 'Enclosed Track (Overhead) Free Rail (M2)',
          type: ProductFieldType.text,
          required: false,
          hintText: '(Height)',
          imagePath: 'assets/Measurements/4/CMS/M2.png',
        ),

        ProductFieldData(
          key: 'enclosedTrackN2',
          label:
          'Enclosed Track (Overhead) Free Rail Vertical Position (Height) (N2)',
          type: ProductFieldType.text,
          required: false,
          hintText: '(Top of Power Rail to Bottom of Free Rail)',
          imagePath: 'assets/Measurements/4/CMS/N2.png',
        ),

        ProductFieldData(
          key: 'enclosedTrackS2',
          label:
          'Enclosed Track (Overhead) Power Trolley Wheel Pitch (S2)',
          type: ProductFieldType.text,
          required: false,
          hintText:
          '(Center of Trolley Wheel to Center of Trolley Wheel)',
          imagePath: 'assets/Measurements/4/CMS/S2.png',
        ),
      ],
    ),
  ],
);