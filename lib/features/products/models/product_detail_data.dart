enum ProductFieldType {
  text,
  dropdown,
}

/// One field inside configuration.
///
/// Example:
/// - Name of Conveyor System -> text
/// - Conveyor Chain Size -> dropdown
class ProductFieldData {
  /// Key sent to API.
  ///
  /// Example:
  /// conveyorName
  /// cc5ChainSize
  final String key;

  /// Text displayed to user.
  final String label;

  final ProductFieldType type;

  /// Used only for dropdown.
  final List<String> options;

  /// Whether user must fill/select this field.
  final bool required;

  /// Optional hint for TextField.
  final String? hintText;

  /// Optional image.
  ///
  /// Useful for measurement fields like:
  /// G, H, A1 etc.
  final String? imagePath;

  /// Whether text field should support multiple lines.
  ///
  /// Example:
  /// Technician Note -> true
  ///
  /// Normal text fields remain single-line by default.
  final bool multiline;

  // =========================================================
  // DROPDOWN OTHER VALUE
  // =========================================================

  /// Shows a custom text field below a dropdown when
  /// the selected option is "Other" or any configured value.
  ///
  /// Example:
  ///
  /// showOtherTextField: true
  ///
  /// If user selects "Other", they can type their own value.
  /// The typed value will be sent to API instead of "Other".
  final bool showOtherTextField;

  /// Dropdown option value that should show the custom
  /// "Other" text field.
  ///
  /// Default is "Other".
  final String otherOptionValue;

  /// Optional hint for the custom "Other" text field.
  ///
  /// Example:
  /// Enter chain manufacturer
  final String? otherHintText;

  // =========================================================
  // IMAGE PICKER SUPPORT
  // =========================================================

  /// Shows an image picker next to this dropdown when
  /// the selected value matches [imagePickerWhenValue].
  ///
  /// Example:
  ///
  /// showImagePicker: true
  /// imagePickerWhenValue: 'Yes - Will Attach'
  final bool showImagePicker;

  /// Dropdown value that should show image picker.
  ///
  /// Example:
  /// Yes - Will Attach
  final String? imagePickerWhenValue;

  /// Key used for selected/uploaded image data.
  ///
  /// Example:
  /// plantLayoutImage
  ///
  /// If null, UI can generate one from field key.
  final String? imagePickerKey;

  // =========================================================
  // CONDITIONAL VISIBILITY
  // =========================================================

  /// Key of another field that controls visibility
  /// of this field.
  ///
  /// Example:
  ///
  /// visibleWhenFieldKey: 'chainSize'
  ///
  /// means this field depends on the value selected
  /// in the "chainSize" field.
  final String? visibleWhenFieldKey;

  /// Value that the controlling field must contain
  /// for this field to become visible.
  ///
  /// Example:
  ///
  /// visibleWhenValue: 'Other'
  ///
  /// Combined with:
  ///
  /// visibleWhenFieldKey: 'chainSize'
  ///
  /// this field will only be displayed when:
  ///
  /// chainSize == 'Other'
  final String? visibleWhenValue;

  const ProductFieldData({
    required this.key,
    required this.label,
    required this.type,
    this.options = const [],
    this.required = false,
    this.hintText,
    this.imagePath,
    this.multiline = false,
    this.showOtherTextField = false,
    this.otherOptionValue = 'Other',
    this.otherHintText,
    this.showImagePicker = false,
    this.imagePickerWhenValue,
    this.imagePickerKey,
    this.visibleWhenFieldKey,
    this.visibleWhenValue,
  });
}

/// One expandable section inside Configuration.
///
/// Example:
/// General Information
/// Customer Power Utilities
/// Conveyor Specifications
class ProductConfigurationSection {
  final String id;

  final String title;

  final List<ProductFieldData> fields;

  const ProductConfigurationSection({
    required this.id,
    required this.title,
    required this.fields,
  });
}

/// Complete data definition of one FINAL product.
///
/// Important:
/// This class contains NO HTTP/API code.
///
/// Networking will be handled separately through:
///
/// ProductRepository
///        ↓
/// ProductApiService
///        ↓
/// ApiClient
class ProductDetailData {
  /// Product identifier expected by backend.
  ///
  /// Example:
  /// CC5_CL
  final String id;

  /// Product name shown in Details page.
  final String title;

  /// Main product image.
  final String imagePath;

  /// Product description shown in Details tab.
  final String description;

  /// Configuration sections for this product.
  final List<ProductConfigurationSection> configurationSections;

  const ProductDetailData({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.description,
    required this.configurationSections,
  });
}