
import '../../../../../../core/constants/app_assets.dart';
import '../../../../models/product_detail_data.dart';

const ProductDetailData overheadOp13SanitaryHookCleanerData =
ProductDetailData(
  // =========================================================
  // PRODUCT INFORMATION
  // =========================================================

  id: 'OH_CCS_OP13',
  title: 'OP-13 Sanitary Hook Cleaner',
  imagePath: AppAssets.OHP_CSS_OP13,
  description: 'OP-13 Sanitary Hook Cleaner configuration for overhead conveyor systems.',

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
            required: true
        ),

        ProductFieldData(
          key: 'conveyorChainSize',
          label: 'Conveyor Chain Size',
          type: ProductFieldType.dropdown,
          options: [
            'X348 Chain (3")',
            'X458 Chain (4")',
            'X678 Chain (6")',
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
          key: 'applicationEnvironment',
          label: 'Application Environment',
          type: ProductFieldType.dropdown,
          options: [
            'Ambient',
            'Caustic (i.e. Washdown / High pH)',
            'Dusty',
            'Food Grade',
            'Humid',
            'Other',
          ],
          required: true,
        ),

        ProductFieldData(
          key: 'conveyorLoadStatus',
          label: 'Is the Conveyor Loaded or Unloaded at Planned Install Location?',
          type: ProductFieldType.dropdown,
          required: true,
          options: [
            'Loaded',
            'Unloaded',
          ],
        ),

        ProductFieldData(
          key: 'hasPlantLayout',
          label: 'I Have A Plant Layout To Attach',
          required: true,
          type: ProductFieldType.dropdown,
          options: [
            'Yes - Will Attach',
            'No - Do Not Have',
          ],
        ),


        ProductFieldData(
          key: 'hasRequiredPictures',
          label: 'I Have The Required Pictures Of Each Chain To Attach',
          required: true,
          type: ProductFieldType.dropdown,
          options: [
            'Yes - Will Attach',
            'No - Do Not Have',
          ],
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
          label: 'Operating Voltage - 3 Phase (Volts/hz)',
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

    // =======================================================
    // SANITARY MEASUREMENTS
    // =======================================================

    ProductConfigurationSection(
      id: 'sanitaryMeasurements',
      title: 'Sanitary Measurements',
      fields: [
        ProductFieldData(
          key: 'sanitaryMeasurementUnit',
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
          key: 'sanitaryChainDropA',
          label: 'Sanitary Chain Drop (A)',
          type: ProductFieldType.text,
          hintText: 'Top of Rail to Center of Chain',
          required: true,
          imagePath: AppAssets.OHP_CSS_M_A,
        ),

        ProductFieldData(
          key: 'sanitaryTrolleyWheelBracketWidthC',
          label: 'Sanitary Trolley Wheel Bracket Width @ Trolley Wheel (C)',
          type: ProductFieldType.text,
          hintText: 'Outside of Left Bracket to Outside of Right Bracket',
          required: true,
          imagePath: AppAssets.OHP_CSS_M_C,
        ),

        ProductFieldData(
          key: 'sanitaryCHookDropA2',
          label: 'Sanitary C-Hook Drop (A2)',
          type: ProductFieldType.text,
          hintText: 'Center of Chain to Top of C-Hook',
          required: true,
          imagePath: AppAssets.OHP_CSS_M_A2,
        ),

        ProductFieldData(
          key: 'sanitaryCHookB2',
          label: 'Sanitary C-Hook (B2)',
          type: ProductFieldType.text,
          hintText: 'Height',
          required: true,
          imagePath: AppAssets.OHP_CSS_M_B2,
        ),

        ProductFieldData(
          key: 'sanitaryTrolleyWheelBracketMaxWidthC2',
          label: 'Sanitary Trolley Wheel Bracket Max. Width (C2)',
          type: ProductFieldType.text,
          hintText: 'Outside of Left Bracket to Outside of Right Bracket',
          required: true,
          imagePath: AppAssets.OHP_CSS_M_C2,
        ),

        ProductFieldData(
          key: 'sanitaryCHookOffsetD2',
          label: 'Sanitary C-Hook Offset (D2)',
          type: ProductFieldType.text,
          hintText: 'Center of Conveyor to Outside Edge of C-Hook',
          required: true,
          imagePath: AppAssets.OHP_CSS_M_D2,
        ),

        ProductFieldData(
          key: 'sanitaryCHookDropE2',
          label: 'Sanitary C-Hook Drop (E2)',
          type: ProductFieldType.text,
          hintText: 'Thickness',
          required: true,
          imagePath: AppAssets.OHP_CSS_M_E2,
        ),

        ProductFieldData(
          key: 'sanitaryCHookSupportPinF2',
          label: 'Sanitary C-Hook Support Pin (F2)',
          type: ProductFieldType.text,
          hintText: 'Diameter / Thickness',
          required: true,
          imagePath: AppAssets.OHP_CSS_M_F2,
        ),

        ProductFieldData(
          key: 'sanitaryCarrierSupportBracketG2',
          label: 'Sanitary Carrier Support Bracket (G2)',
          type: ProductFieldType.text,
          hintText: 'Width',
          required: true,
          imagePath: AppAssets.OHP_CSS_M_G2,
        ),

        ProductFieldData(
          key: 'sanitaryCarrierSupportBracketH2',
          label: 'Sanitary Carrier Support Bracket (H2)',
          type: ProductFieldType.text,
          hintText: 'Height',
          required: true,
          imagePath: AppAssets.OHP_CSS_M_H2,
        ),

        ProductFieldData(
          key: 'sanitaryCarrierSupportBracketJ2',
          label: 'Sanitary Carrier Support Bracket (J2)',
          type: ProductFieldType.text,
          hintText: 'C-Hook to Bottom of Carrier Support Bracket',
          required: true,
          imagePath: AppAssets.OHP_CSS_M_J2,
        ),

        ProductFieldData(
          key: 'sanitaryFreeRailL2',
          label: 'Sanitary Free Rail (L2)',
          type: ProductFieldType.text,
          hintText: 'Width',
          required: true,
          imagePath: AppAssets.OHP_CSS_M_L2,
        ),

        ProductFieldData(
          key: 'sanitaryFreeRailM2',
          label: 'Sanitary Free Rail (M2)',
          type: ProductFieldType.text,
          hintText: 'Height',
          required: true,
          imagePath: AppAssets.OHP_CSS_M_M2,
        ),
      ],
    ),

    // =======================================================
    // TECHNICIAN NOTE
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