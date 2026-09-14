
import '../../../../../core/constants/app_assets.dart';
import '../../../models/product_detail_data.dart';

const ProductDetailData overheadOp13SanitaryHookCleanerData =
ProductDetailData(
  // =========================================================
  // PRODUCT INFORMATION
  // =========================================================

  id: 'OH_CCS_OP13',
  title: 'OP-13 Sanitary Hook Cleaner',
  imagePath: AppAssets.ohprlbCcsOp13,
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
          key: 'otherConveyorChainSize',
          label: 'Conveyor Chain Size - Other',
          type: ProductFieldType.text,
          visibleWhenFieldKey: 'conveyorChainSize',
          visibleWhenValue: 'Other',
        ),

        ProductFieldData(
          key: 'chainManufacturer',
          label: 'Chain Manufacturer',
          type: ProductFieldType.dropdown,
          options: [
            'Other',
          ],
        ),

        ProductFieldData(
          key: 'otherChainManufacturer',
          label: 'Chain Manufacturer - Other',
          type: ProductFieldType.text,
          visibleWhenFieldKey: 'chainManufacturer',
          visibleWhenValue: 'Other',
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
          key: 'otherApplicationEnvironment',
          label: 'Application Environment - Other',
          type: ProductFieldType.text,
          visibleWhenFieldKey: 'applicationEnvironment',
          visibleWhenValue: 'Other',
        ),

        ProductFieldData(
          key: 'conveyorLoadStatus',
          label:
          'Is the Conveyor Loaded or Unloaded at Planned Install Location?',
          type: ProductFieldType.dropdown,
          options: [
            'Unloaded',
          ],
          required: true,
        ),

        ProductFieldData(
          key: 'hasPlantLayout',
          label: 'I Have A Plant Layout To Attach',
          type: ProductFieldType.dropdown,
          options: [
            'Yes - Will Attach',
            'No - Do Not Have',
          ],
        ),

        // TODO:
        // Replace this temporary dropdown with file/image upload
        // support when ProductFieldType supports attachments.
        ProductFieldData(
          key: 'plantLayoutAttachment',
          label: 'Plant Layout Attachment',
          type: ProductFieldType.dropdown,
          options: [
            'Attach Later',
          ],
          visibleWhenFieldKey: 'hasPlantLayout',
          visibleWhenValue: 'Yes - Will Attach',
        ),

        ProductFieldData(
          key: 'hasRequiredPictures',
          label: 'I Have The Required Pictures Of Each Chain To Attach',
          type: ProductFieldType.dropdown,
          options: [
            'Yes - Will Attach',
            'No - Do Not Have',
          ],
        ),

        // TODO:
        // Replace this temporary dropdown with file/image upload
        // support when ProductFieldType supports attachments.
        ProductFieldData(
          key: 'requiredPicturesAttachment',
          label: 'Required Pictures Attachment',
          type: ProductFieldType.dropdown,
          options: [
            'Attach Later',
          ],
          visibleWhenFieldKey: 'hasRequiredPictures',
          visibleWhenValue: 'Yes - Will Attach',
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
          key: 'measurementUnit',
          label: 'Measurement Unit',
          type: ProductFieldType.dropdown,
          options: [
            'Feet',
          ],
        ),

        ProductFieldData(
          key: 'sanitaryChainDropA',
          label: 'Sanitary Chain Drop (A)',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'sanitaryTrolleyWheelDiameterB',
          label: 'Sanitary Trolley Wheel Diameter (B)',
          type: ProductFieldType.text,
          hintText: 'Diameter',
        ),

        ProductFieldData(
          key: 'sanitaryWheelDropD',
          label: 'Sanitary Wheel Drop (D)',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'sanitaryTrolleyWheelBottomWidthE',
          label: 'Sanitary Trolley Wheel Bottom Width (E)',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'sanitaryTrolleyWheelTopWidthF',
          label: 'Sanitary Trolley Wheel Top Width (F)',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'sanitaryCenterSupportWidthG',
          label: 'Sanitary Center Support Width (G)',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'sanitaryCenterSupportHeightH',
          label: 'Sanitary Center Support Height (H)',
          type: ProductFieldType.text,
        ),

        ProductFieldData(
          key: 'sanitaryHookRadiusL1',
          label: 'Sanitary Hook Radius (L1)',
          type: ProductFieldType.text,
          hintText: 'Radius',
        ),

        ProductFieldData(
          key: 'sanitaryHookRadiusL2',
          label: 'Sanitary Hook Radius (L2)',
          type: ProductFieldType.text,
          hintText: 'Radius',
        ),

        ProductFieldData(
          key: 'sanitaryCHookSupportDiameterL3',
          label: 'Sanitary C-Hook Support Diameter (L3)',
          type: ProductFieldType.text,
          hintText: 'Diameter',
        ),

        ProductFieldData(
          key: 'sanitaryCHookSupportHeightL4',
          label: 'Sanitary C-Hook Support Height (L4)',
          type: ProductFieldType.text,
          hintText: 'Height',
        ),

        ProductFieldData(
          key: 'sanitaryHookRadiusL5',
          label: 'Sanitary Hook Radius (L5)',
          type: ProductFieldType.text,
          hintText: 'Radius',
        ),

        ProductFieldData(
          key: 'sanitaryHookRadiusL6',
          label: 'Sanitary Hook Radius (L6)',
          type: ProductFieldType.text,
          hintText: 'Radius',
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
          required: true,
        ),
      ],
    ),
  ],
);