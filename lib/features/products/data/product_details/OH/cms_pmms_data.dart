import '../../../../../core/constants/app_assets.dart';
import '../../../models/product_detail_data.dart';

const ProductDetailData overheadPaintMarkerMonitoringSystemData =
ProductDetailData(
  id: 'OHP_PMM',
  title: 'Paint Marker for Monitoring System (Optional)',
  imagePath: AppAssets.ohprlbCmsPmms,
  description:
  'Paint Marker for Mighty Lube® Monitoring System configuration.',
  configurationSections: [

    // ============================================================
    // GENERAL INFORMATION
    // ============================================================

    ProductConfigurationSection(
      id: 'generalInformation',
      title: 'General Information',
      fields: [
        ProductFieldData(
          key: 'conveyorChainSize',
          label: 'Conveyor Chain Size',
          type: ProductFieldType.dropdown,
          options: [
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
          options: [
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
      ],
    ),

    // ============================================================
    // NEW OR EXISTING MONITORING SYSTEM
    // ============================================================

    ProductConfigurationSection(
      id: 'monitoringSystem',
      title:
      'New Monitoring System or Adding to Existing Monitoring System',
      fields: [
        ProductFieldData(
          key: 'connectingToExistingMonitoring',
          label: 'Connecting to Existing Monitoring',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
        ),

        ProductFieldData(
          key: 'addNewMonitoringSystem',
          label: 'Add New Monitoring System',
          type: ProductFieldType.dropdown,
          options: [
            'Yes',
            'No',
          ],
        ),
      ],
    ),

    // ============================================================
    // CONFIGURATION
    // ============================================================

    ProductConfigurationSection(
      id: 'configuration',
      title: 'Configuration',
      fields: [
        ProductFieldData(
          key: 'dcuQuantity',
          label: 'DCU Quantity',
          type: ProductFieldType.text,
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
          required: true,
        ),
      ],
    ),
  ],
);