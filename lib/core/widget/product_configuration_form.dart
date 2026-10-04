import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../features/products/models/product_detail_data.dart';
import '../../features/products/repositories/product_repository.dart';
import '../network/api_response.dart';
import '../network/Services/image_upload_service.dart';
import 'api_action_button.dart';

// ===========================================================
// IMAGE UPLOAD FAILURE ACTION
// ===========================================================

enum _ImageUploadFailureAction {
  retry,
  continueWithoutImage,
}

class ProductConfigurationForm extends StatefulWidget {
  final ProductDetailData product;

  // =========================================================
  // EDIT MODE
  // =========================================================
  //
  // CREATE MODE:
  //
  // initialConfiguration == null
  // onUpdate == null
  //
  // EDIT MODE:
  //
  // initialConfiguration != null
  // onUpdate != null
  //
  // =========================================================

  final Map<String, dynamic>? initialConfiguration;
  final int initialQuantity;

  final Future<ApiResponse<bool>> Function(Map<String, dynamic> configuration, int quantity, )? onUpdate;
  final VoidCallback? onUpdateSuccess;

  const ProductConfigurationForm({
    super.key,
    required this.product,
    this.initialConfiguration,
    this.initialQuantity = 1,
    this.onUpdate,
    this.onUpdateSuccess,
  });

  bool get isEditMode => onUpdate != null;

  @override
  State<ProductConfigurationForm> createState() => _ProductConfigurationFormState();
}

class _ProductConfigurationFormState extends State<ProductConfigurationForm> {
  // =========================================================
  // FIELD VALUES
  // =========================================================

  final Map<String, TextEditingController> _textControllers = {};
  final Map<String, TextEditingController> _otherControllers = {};
  final Map<String, String?> _dropdownValues = {};
  final Map<String, XFile?> _selectedImages = {};
  final Map<String, String?> _errors = {};

  // =========================================================
  // EXISTING IMAGE METADATA
  // =========================================================
  //
  // Existing uploaded images cannot be represented by XFile.
  //
  // Therefore:
  //
  // _selectedImages
  //     → newly selected local images
  //
  // _existingImages
  //     → already uploaded object-storage metadata
  //
  // =========================================================

  final Map<String, Map<String, dynamic>> _existingImages = {};

  // =========================================================
  // IMAGE REMOVAL
  // =========================================================
  //
  // Backend cart update performs a top-level merge.
  //
  // Therefore, if an existing image needs to be removed,
  // simply omitting the key would leave the old image intact.
  //
  // We explicitly send null for image keys that must be cleared.
  // =========================================================

  final Set<String> _removedImageKeys = {};
  final ImagePicker _imagePicker = ImagePicker();

  // =========================================================
  // QUANTITY
  // =========================================================

  int _quantity = 1;

  // =========================================================
  // INIT
  // =========================================================

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialQuantity < 1 ? 1 : widget.initialQuantity;
    _prepareFields();
    _applyInitialConfiguration();
  }

  // =========================================================
  // PREPARE FIELDS
  // =========================================================

  void _prepareFields() {
    for (final section in widget.product.configurationSections) {
      for (final field in section.fields) {
        if (field.type == ProductFieldType.text) {
          _textControllers[field.key] = TextEditingController();
        }

        if (field.type == ProductFieldType.dropdown) {
          _dropdownValues[field.key] = null;
          if (_hasOtherOption(field)) {
            _otherControllers[field.key] = TextEditingController();
          }
          _selectedImages[_imagePickerKeyFor(field)] = null;
        }
        _errors[field.key] = null;
      }
    }
  }

  // =========================================================
  // APPLY INITIAL CONFIGURATION
  // =========================================================

  void _applyInitialConfiguration() {
    final initialConfiguration = widget.initialConfiguration;

    if (initialConfiguration == null) {
      return;
    }

    for (final section in widget.product.configurationSections) {
      for (final field in section.fields) {
        final savedValue = initialConfiguration[field.key];

        // -----------------------------------------------------
        // TEXT
        // -----------------------------------------------------

        if (field.type == ProductFieldType.text) {
          if (savedValue != null) {
            _textControllers[field.key]?.text = savedValue.toString();
          }
          continue;
        }

        // -----------------------------------------------------
        // DROPDOWN
        // -----------------------------------------------------

        if (field.type == ProductFieldType.dropdown) {
          if (savedValue != null) {
            final savedString = savedValue.toString();
            final matchingOption = _findMatchingOption(field, savedString,);

            if (matchingOption != null) {
              _dropdownValues[field.key] = matchingOption;
            } else if (_hasOtherOption(field) &&
                savedString.trim().isNotEmpty) {
              // ------------------------------------------------
              // IMPORTANT:
              //
              // CREATE MODE saves custom "Other" value directly
              // into the SAME field key.
              //
              // Example:
              //
              // manufacturer = "Custom Manufacturer"
              //
              // Therefore on edit:
              //
              // dropdown = Other
              // other text = Custom Manufacturer
              // ------------------------------------------------

              final otherOption = _getOtherOption(field);
              _dropdownValues[field.key] = otherOption;
              _otherControllers[field.key]?.text = savedString;
            }
          }

          // ---------------------------------------------------
          // EXISTING IMAGE METADATA
          // ---------------------------------------------------

          final imageKey = _imagePickerKeyFor(field);
          final existingImage = initialConfiguration[imageKey];

          if (existingImage is Map) {
            final imageData = Map<String, dynamic>.from(existingImage);
            final objectKey = imageData['objectKey'];

            if (objectKey is String && objectKey.trim().isNotEmpty) {
              _existingImages[imageKey] = imageData;
            }
          }
        }
      }
    }
  }

  // =========================================================
  // DROPDOWN HELPERS
  // =========================================================

  String? _findMatchingOption(ProductFieldData field, String savedValue,) {
    for (final option in field.options) {
      if (option == savedValue) {
        return option;
      }
    }
    return null;
  }

  String? _getOtherOption(ProductFieldData field,) {
    for (final option in field.options) {
      if (option.trim().toLowerCase() == 'other') {
        return option;
      }
    }
    return null;
  }

  // =========================================================
  // AUTOMATIC FIELD RULES
  // =========================================================

  bool _hasOtherOption(ProductFieldData field,) {
    if (field.type != ProductFieldType.dropdown) {
      return false;
    }
    return field.options.any((option) => option.trim().toLowerCase() == 'other',
    );
  }

  bool _isOtherSelected(ProductFieldData field,) {
    final selectedValue = _dropdownValues[field.key];
    return selectedValue?.trim().toLowerCase() == 'other';
  }

  bool _shouldShowImagePicker(ProductFieldData field,) {
    if (field.type != ProductFieldType.dropdown) {
      return false;
    }

    final value = _dropdownValues[field.key]?.trim().toLowerCase();

    if (value == null || value.isEmpty) {
      return false;
    }

    final hasYes = value.contains('yes');
    final hasAttachOrUpload = value.contains('attach') || value.contains('upload');
    return hasYes && hasAttachOrUpload;
  }

  String _imagePickerKeyFor(ProductFieldData field,) {
    // Current ProductConfigurationForm behavior.
    //
    // ProductFieldData also supports imagePickerKey, but the
    // current production form uses field.key + "Image".
    //
    // Keeping the existing behavior prevents changing API keys.

    return '${field.key}Image';
  }

  // =========================================================
  // CONDITIONAL VISIBILITY
  // =========================================================

  bool _isFieldVisible(
      ProductFieldData field,
      ) {
    final controllingKey = field.visibleWhenFieldKey;
    final requiredValue = field.visibleWhenValue;

    if (controllingKey == null || requiredValue == null) {
      return true;
    }

    final controllingValue = _getFieldValue(
      controllingKey,
    );

    return controllingValue == requiredValue;
  }

  String? _getFieldValue(
      String key,
      ) {
    if (_dropdownValues.containsKey(key)) {
      return _dropdownValues[key];
    }

    if (_textControllers.containsKey(key)) {
      return _textControllers[key]?.text.trim();
    }

    return null;
  }

  // =========================================================
  // CLEAR IMAGE DATA
  // =========================================================

  void _clearImageForField(
      ProductFieldData field,
      ) {
    final imageKey = _imagePickerKeyFor(field);

    _selectedImages[imageKey] = null;

    if (_existingImages.containsKey(imageKey)) {
      _existingImages.remove(imageKey);
      _removedImageKeys.add(imageKey);
    }
  }

  // =========================================================
  // CLEAR HIDDEN FIELD VALUE
  // =========================================================

  void _clearHiddenDependentFields(
      String changedFieldKey,
      ) {
    for (final section in widget.product.configurationSections) {
      for (final field in section.fields) {
        if (field.visibleWhenFieldKey != changedFieldKey) {
          continue;
        }

        if (_isFieldVisible(field)) {
          continue;
        }

        if (field.type == ProductFieldType.text) {
          _textControllers[field.key]?.clear();
        }

        if (field.type == ProductFieldType.dropdown) {
          _dropdownValues[field.key] = null;

          _otherControllers[field.key]?.clear();

          _clearImageForField(field);
        }

        _errors[field.key] = null;

        _clearHiddenDependentFields(
          field.key,
        );
      }
    }
  }

  // =========================================================
  // SECTION COMPLETE CHECK
  // =========================================================

  bool _isSectionComplete(
      ProductConfigurationSection section,
      ) {
    for (final field in section.fields) {
      if (!_isFieldVisible(field)) {
        continue;
      }

      if (!field.required) {
        continue;
      }

      if (field.type == ProductFieldType.text) {
        final value =
        _textControllers[field.key]?.text.trim();

        if (value == null || value.isEmpty) {
          return false;
        }
      }

      if (field.type == ProductFieldType.dropdown) {
        final value = _dropdownValues[field.key];

        if (value == null || value.trim().isEmpty) {
          return false;
        }

        if (_isOtherSelected(field)) {
          final otherValue =
          _otherControllers[field.key]?.text.trim();

          if (otherValue == null || otherValue.isEmpty) {
            return false;
          }
        }
      }
    }

    return true;
  }

  // =========================================================
  // FORM VALIDATION
  // =========================================================

  bool _validateForm() {
    bool valid = true;

    for (final section in widget.product.configurationSections) {
      for (final field in section.fields) {
        if (!_isFieldVisible(field)) {
          _errors[field.key] = null;
          continue;
        }

        if (field.type == ProductFieldType.text) {
          final value =
          _textControllers[field.key]?.text.trim();

          if (field.required &&
              (value == null || value.isEmpty)) {
            _errors[field.key] =
            '${field.label} is required';

            valid = false;
          } else {
            _errors[field.key] = null;
          }
        }

        if (field.type == ProductFieldType.dropdown) {
          final value = _dropdownValues[field.key];

          if (field.required &&
              (value == null || value.trim().isEmpty)) {
            _errors[field.key] =
            'Please select ${field.label}';

            valid = false;
          } else if (_isOtherSelected(field)) {
            final otherValue =
            _otherControllers[field.key]?.text.trim();

            if (otherValue == null ||
                otherValue.isEmpty) {
              _errors[field.key] =
              'Please specify ${field.label}';

              valid = false;
            } else {
              _errors[field.key] = null;
            }
          } else {
            _errors[field.key] = null;
          }
        }
      }
    }

    setState(() {});

    return valid;
  }

  // =========================================================
  // IMAGE UPLOAD
  // =========================================================

  Future<Map<String, dynamic>>
  _uploadSelectedImagesWithRetry() async {
    final Map<String, dynamic> uploadedImages = {};

    for (final section in widget.product.configurationSections) {
      for (final field in section.fields) {
        if (field.type != ProductFieldType.dropdown) {
          continue;
        }

        if (!_isFieldVisible(field)) {
          continue;
        }

        if (!_shouldShowImagePicker(field)) {
          continue;
        }

        final imageKey = _imagePickerKeyFor(
          field,
        );

        final image = _selectedImages[imageKey];

        // No NEW image selected.
        //
        // In edit mode the existing uploaded image, if any,
        // will be preserved by _collectFormData().

        if (image == null) {
          continue;
        }

        bool currentImageFinished = false;

        while (!currentImageFinished) {
          final response =
          await ImageUploadService.uploadImage(
            image,
            projectKey: widget.product.id,
          );

          if (response.success) {
            final responseData = response.data;

            if (responseData != null) {
              final fileData = responseData['file'];

              if (fileData is Map) {
                final uploadedFile =
                Map<String, dynamic>.from(
                  fileData,
                );

                final objectKey =
                uploadedFile['objectKey'];

                if (objectKey is String &&
                    objectKey.trim().isNotEmpty) {
                  uploadedImages[imageKey] =
                      uploadedFile;

                  currentImageFinished = true;

                  continue;
                }
              }
            }
          }

          if (!mounted) {
            return uploadedImages;
          }

          String failureMessage =
              response.message ??
                  'The selected image could not be uploaded.';

          if (response.success) {
            failureMessage =
            'The image was uploaded but the server returned an invalid response.';
          }

          final action =
          await _showImageUploadFailureDialog(
            imageName: image.name,
            message: failureMessage,
          );

          if (action ==
              _ImageUploadFailureAction.retry) {
            continue;
          }

          currentImageFinished = true;
        }
      }
    }

    return uploadedImages;
  }

  // =========================================================
  // IMAGE UPLOAD FAILURE DIALOG
  // =========================================================

  Future<_ImageUploadFailureAction>
  _showImageUploadFailureDialog({
    required String imageName,
    required String message,
  }) async {
    final result =
    await showDialog<_ImageUploadFailureAction>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Image Upload Failed',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                'We could not upload "$imageName".',
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                message,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                widget.isEditMode
                    ? 'Would you like to try uploading the image again '
                    'or keep the configuration without this new image?'
                    : 'Would you like to try uploading the image again '
                    'or add the configuration without this image?',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(
                  _ImageUploadFailureAction
                      .continueWithoutImage,
                );
              },
              child: Text(
                widget.isEditMode
                    ? 'Continue Without New Image'
                    : 'Add Without Image',
              ),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(
                  _ImageUploadFailureAction.retry,
                );
              },
              child: const Text(
                'Try Again',
              ),
            ),
          ],
        );
      },
    );

    return result ??
        _ImageUploadFailureAction
            .continueWithoutImage;
  }

  // =========================================================
  // COLLECT API DATA
  // =========================================================

  Map<String, dynamic> _collectFormData({
    Map<String, dynamic> uploadedImages = const {},
  }) {
    final Map<String, dynamic> data = {};

    for (final section in widget.product.configurationSections) {
      for (final field in section.fields) {
        if (!_isFieldVisible(field)) {
          continue;
        }

        // -----------------------------------------------------
        // TEXT
        // -----------------------------------------------------

        if (field.type == ProductFieldType.text) {
          data[field.key] =
              _textControllers[field.key]?.text.trim() ??
                  '';
        }

        // -----------------------------------------------------
        // DROPDOWN
        // -----------------------------------------------------

        if (field.type == ProductFieldType.dropdown) {
          if (_isOtherSelected(field)) {
            data[field.key] =
                _otherControllers[field.key]
                    ?.text
                    .trim() ??
                    '';
          } else {
            data[field.key] =
                _dropdownValues[field.key] ?? '';
          }

          final imageKey =
          _imagePickerKeyFor(field);

          // ---------------------------------------------------
          // IMAGE NO LONGER APPLIES
          // ---------------------------------------------------
          //
          // Example:
          //
          // Existing:
          // Yes - Will Attach
          // + image metadata
          //
          // User changes to:
          // No
          //
          // Send null so backend merge clears old metadata.
          // ---------------------------------------------------

          if (!_shouldShowImagePicker(field)) {
            if (_removedImageKeys.contains(imageKey)) {
              data[imageKey] = null;
            }

            continue;
          }

          // ---------------------------------------------------
          // NEW IMAGE
          // ---------------------------------------------------

          final uploadedImage =
          uploadedImages[imageKey];

          if (uploadedImage != null) {
            data[imageKey] = uploadedImage;
            continue;
          }

          // ---------------------------------------------------
          // EXISTING IMAGE
          // ---------------------------------------------------

          final existingImage =
          _existingImages[imageKey];

          if (existingImage != null &&
              !_removedImageKeys.contains(imageKey)) {
            data[imageKey] = existingImage;
            continue;
          }

          // ---------------------------------------------------
          // EXPLICITLY REMOVED IMAGE
          // ---------------------------------------------------

          if (_removedImageKeys.contains(imageKey)) {
            data[imageKey] = null;
          }
        }
      }
    }

    return data;
  }

  // =========================================================
  // IMAGE PICKER
  // =========================================================

  Future<void> _pickImage(
      ProductFieldData field,
      ) async {
    final image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (image == null) {
      return;
    }

    if (!mounted) {
      return;
    }

    final imageKey = _imagePickerKeyFor(field);

    setState(() {
      _selectedImages[imageKey] = image;

      // New image replaces the old image logically.
      _existingImages.remove(imageKey);
      _removedImageKeys.remove(imageKey);
    });
  }

  // =========================================================
  // REMOVE IMAGE
  // =========================================================

  void _removeImage(
      ProductFieldData field,
      ) {
    final imageKey = _imagePickerKeyFor(field);

    setState(() {
      _selectedImages[imageKey] = null;
      _existingImages.remove(imageKey);
      _removedImageKeys.add(imageKey);
    });
  }

  // =========================================================
  // ASSET IMAGE PREVIEW
  // =========================================================

  void _showAssetImagePreview(
      String imagePath,
      ) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(
            16,
          ),
          child: InteractiveViewer(
            child: Padding(
              padding: const EdgeInsets.all(
                12,
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }

  // =========================================================
  // SELECTED FILE IMAGE PREVIEW
  // =========================================================

  void _showFileImagePreview(
      XFile image,
      ) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(
            16,
          ),
          child: InteractiveViewer(
            child: Padding(
              padding: const EdgeInsets.all(
                12,
              ),
              child: Image.file(
                File(
                  image.path,
                ),
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }

  // =========================================================
  // EXISTING IMAGE INFORMATION
  // =========================================================

  void _showExistingImageInfo(
      Map<String, dynamic> imageData,
      ) {
    final originalName =
    imageData['originalName']?.toString();

    final objectKey =
    imageData['objectKey']?.toString();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Existing Image',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              const Text(
                'This image is already uploaded and attached to this configuration.',
              ),
              if (originalName != null &&
                  originalName.trim().isNotEmpty) ...[
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'File: $originalName',
                ),
              ],
              if (objectKey != null &&
                  objectKey.trim().isNotEmpty) ...[
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Storage key: $objectKey',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text(
                'Close',
              ),
            ),
          ],
        );
      },
    );
  }

  // =========================================================
  // QUANTITY
  // =========================================================

  void _increaseQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decreaseQuantity() {
    if (_quantity <= 1) {
      return;
    }

    setState(() {
      _quantity--;
    });
  }

  // =========================================================
  // UI
  // =========================================================

  @override
  Widget build(
      BuildContext context,
      ) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(
              16,
            ),
            itemCount:
            widget.product.configurationSections.length,
            itemBuilder: (
                context,
                sectionIndex,
                ) {
              final section =
              widget.product
                  .configurationSections[sectionIndex];

              return _buildSection(
                section,
              );
            },
          ),
        ),
        _buildBottomActionArea(),
      ],
    );
  }

  // =========================================================
  // SECTION
  // =========================================================

  Widget _buildSection(
      ProductConfigurationSection section,
      ) {
    final bool complete =
    _isSectionComplete(
      section,
    );

    return Card(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      child: ExpansionTile(
        title: Text(
          section.title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        trailing: complete
            ? const Icon(
          Icons.check_circle,
          color: Colors.green,
        )
            : const Icon(
          Icons.keyboard_arrow_down,
        ),
        children:
        section.fields.where(_isFieldVisible).map(
              (field) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                8,
                16,
                12,
              ),
              child: _buildField(
                field,
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  // =========================================================
  // FIELD
  // =========================================================

  Widget _buildField(
      ProductFieldData field,
      ) {
    switch (field.type) {
      case ProductFieldType.text:
        return _buildTextField(
          field,
        );

      case ProductFieldType.dropdown:
        return _buildDropdownField(
          field,
        );
    }
  }

  // =========================================================
  // TEXT FIELD
  // =========================================================

  Widget _buildTextField(
      ProductFieldData field,
      ) {
    final textField = _buildTextInput(
      field,
    );

    if (field.imagePath == null) {
      return textField;
    }

    return Row(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Expanded(
          child: textField,
        ),
        const SizedBox(
          width: 2,
        ),
        Expanded(
          child: _buildMeasurementImage(
            field.imagePath!,
          ),
        ),
      ],
    );
  }

  Widget _buildTextInput(
      ProductFieldData field,
      ) {
    return TextField(
      controller:
      _textControllers[field.key],
      minLines:
      field.multiline ? 4 : 1,
      maxLines:
      field.multiline ? 6 : 1,
      keyboardType: field.multiline
          ? TextInputType.multiline
          : TextInputType.text,
      textInputAction: field.multiline
          ? TextInputAction.newline
          : TextInputAction.next,
      onChanged: (_) {
        setState(() {
          _errors[field.key] = null;

          _clearHiddenDependentFields(
            field.key,
          );
        });
      },
      decoration: InputDecoration(
        labelText: field.required
            ? '${field.label} *'
            : field.label,
        hintText: field.hintText,
        errorText: _errors[field.key],
        alignLabelWithHint:
        field.multiline,
        border:
        const OutlineInputBorder(),
      ),
    );
  }

  // =========================================================
  // MEASUREMENT IMAGE
  // =========================================================

  Widget _buildMeasurementImage(
      String imagePath,
      ) {
    return InkWell(
      onTap: () {
        _showAssetImagePreview(
          imagePath,
        );
      },
      borderRadius:
      BorderRadius.circular(
        8,
      ),
      child: Container(
        height: 180,
        width: double.infinity,
        padding: const EdgeInsets.all(
          8,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(
              0xFFE0E0E0,
            ),
          ),
          borderRadius:
          BorderRadius.circular(
            8,
          ),
        ),
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain,
          errorBuilder: (
              context,
              error,
              stackTrace,
              ) {
            return const Center(
              child: Text(
                'Image not found',
              ),
            );
          },
        ),
      ),
    );
  }

  // =========================================================
  // DROPDOWN FIELD
  // =========================================================

  Widget _buildDropdownField(
      ProductFieldData field,
      ) {
    final dropdown =
    _buildDropdown(
      field,
    );

    final otherTextField =
    _buildOtherTextField(
      field,
    );

    final showOther =
    _isOtherSelected(
      field,
    );

    final showPicker =
    _shouldShowImagePicker(
      field,
    );

    if (showOther) {
      return Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: dropdown,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            flex: 7,
            child: otherTextField,
          ),
        ],
      );
    }

    if (showPicker) {
      return Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Expanded(
            child: dropdown,
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: _buildImagePickerBox(
              field,
            ),
          ),
        ],
      );
    }

    return dropdown;
  }

  // =========================================================
  // DROPDOWN
  // =========================================================

  Widget _buildDropdown(
      ProductFieldData field,
      ) {
    return DropdownButtonFormField<String>(
      value:
      _dropdownValues[field.key],
      isExpanded: true,
      decoration: InputDecoration(
        labelText: field.required
            ? '${field.label} *'
            : field.label,
        errorText: _errors[field.key],
        border:
        const OutlineInputBorder(),
      ),
      items: field.options.map(
            (option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(
              option,
              overflow:
              TextOverflow.ellipsis,
            ),
          );
        },
      ).toList(),
      onChanged: (value) {
        setState(() {
          _dropdownValues[field.key] =
              value;

          _errors[field.key] = null;

          // ---------------------------------------------------
          // CLEAR OTHER VALUE
          // ---------------------------------------------------

          if (!_isOtherSelected(field)) {
            _otherControllers[field.key]
                ?.clear();
          }

          // ---------------------------------------------------
          // CLEAR IMAGE
          // ---------------------------------------------------

          if (!_shouldShowImagePicker(field)) {
            _clearImageForField(
              field,
            );
          }

          _clearHiddenDependentFields(
            field.key,
          );
        });
      },
    );
  }

  // =========================================================
  // OTHER TEXT FIELD
  // =========================================================

  Widget _buildOtherTextField(
      ProductFieldData field,
      ) {
    return TextField(
      controller:
      _otherControllers[field.key],
      textInputAction:
      TextInputAction.next,
      onChanged: (_) {
        setState(() {
          _errors[field.key] = null;
        });
      },
      decoration: InputDecoration(
        labelText:
        'Please specify ${field.label}',
        hintText:
        'Type custom ${field.label.toLowerCase()}',
        errorText:
        _errors[field.key],
        border:
        const OutlineInputBorder(),
      ),
    );
  }

  // =========================================================
  // IMAGE PICKER BOX
  // =========================================================

  Widget _buildImagePickerBox(
      ProductFieldData field,
      ) {
    final imageKey =
    _imagePickerKeyFor(
      field,
    );

    final selectedImage =
    _selectedImages[imageKey];

    final existingImage =
    _existingImages[imageKey];

    // ---------------------------------------------------------
    // NEW LOCAL IMAGE
    // ---------------------------------------------------------

    if (selectedImage != null) {
      return InkWell(
        onTap: () {
          _showFileImagePreview(
            selectedImage,
          );
        },
        borderRadius:
        BorderRadius.circular(
          8,
        ),
        child: Container(
          height: 140,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(
              0xFFF7F7F7,
            ),
            border: Border.all(
              color: const Color(
                0xFFD6D6D6,
              ),
            ),
            borderRadius:
            BorderRadius.circular(
              8,
            ),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius:
                BorderRadius.circular(
                  8,
                ),
                child: Image.file(
                  File(
                    selectedImage.path,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 6,
                right: 6,
                child:
                IconButton.filled(
                  onPressed: () {
                    _removeImage(
                      field,
                    );
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // ---------------------------------------------------------
    // EXISTING UPLOADED IMAGE
    // ---------------------------------------------------------
    //
    // We intentionally do NOT create a network URL here.
    //
    // The stored data contains permanent object metadata, not
    // a public URL. Signed URL generation belongs to the
    // authenticated backend/admin image flow.
    //
    // ---------------------------------------------------------

    if (existingImage != null) {
      final originalName =
      existingImage['originalName']
          ?.toString();

      return Container(
        height: 140,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(
            0xFFF7F7F7,
          ),
          border: Border.all(
            color: const Color(
              0xFFD6D6D6,
            ),
          ),
          borderRadius:
          BorderRadius.circular(
            8,
          ),
        ),
        child: Stack(
          children: [
            InkWell(
              onTap: () {
                _showExistingImageInfo(
                  existingImage,
                );
              },
              child: Center(
                child: Padding(
                  padding:
                  const EdgeInsets.all(
                    12,
                  ),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons
                            .image_outlined,
                        size: 32,
                        color:
                        Colors.black54,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      const Text(
                        'Existing image attached',
                        textAlign:
                        TextAlign.center,
                        style: TextStyle(
                          fontWeight:
                          FontWeight.w600,
                        ),
                      ),
                      if (originalName !=
                          null &&
                          originalName
                              .trim()
                              .isNotEmpty) ...[
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          originalName,
                          maxLines: 1,
                          overflow:
                          TextOverflow
                              .ellipsis,
                          textAlign:
                          TextAlign.center,
                          style:
                          const TextStyle(
                            fontSize: 12,
                            color:
                            Colors.black54,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),

            // Remove existing image.
            Positioned(
              top: 6,
              right: 6,
              child:
              IconButton.filled(
                onPressed: () {
                  _removeImage(
                    field,
                  );
                },
                icon: const Icon(
                  Icons.close,
                  size: 18,
                ),
              ),
            ),

            // Replace existing image.
            Positioned(
              left: 6,
              bottom: 6,
              child:
              FilledButton.tonalIcon(
                onPressed: () {
                  _pickImage(
                    field,
                  );
                },
                icon: const Icon(
                  Icons
                      .photo_library_outlined,
                  size: 18,
                ),
                label: const Text(
                  'Replace',
                ),
              ),
            ),
          ],
        ),
      );
    }

    // ---------------------------------------------------------
    // NO IMAGE
    // ---------------------------------------------------------

    return InkWell(
      onTap: () {
        _pickImage(
          field,
        );
      },
      borderRadius:
      BorderRadius.circular(
        8,
      ),
      child: Container(
        height: 140,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(
            0xFFF7F7F7,
          ),
          border: Border.all(
            color: const Color(
              0xFFD6D6D6,
            ),
          ),
          borderRadius:
          BorderRadius.circular(
            8,
          ),
        ),
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.cloud_upload_outlined,
              size: 32,
              color: Colors.black54,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              widget.isEditMode
                  ? 'Tap to upload image'
                  : 'Tap to upload image',
              style: TextStyle(
                color:
                Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // SAVE
  // =========================================================

  Future<ApiResponse<dynamic>> _saveConfiguration() async {
    // =========================================================
    // VALIDATE FORM
    // =========================================================

    if (!_validateForm()) {
      return ApiResponse<dynamic>.failure(
        message: 'Please fill all required fields.',
      );
    }

    // =========================================================
    // UPLOAD NEWLY SELECTED IMAGES
    // =========================================================

    final uploadedImages =
    await _uploadSelectedImagesWithRetry();

    // =========================================================
    // COLLECT COMPLETE CONFIGURATION
    // =========================================================

    final configuration = _collectFormData(
      uploadedImages: uploadedImages,
    );

    // =========================================================
    // EDIT MODE
    //
    // Existing cart configuration:
    //
    // ProductConfigurationForm
    //          ↓
    // onUpdate callback
    //          ↓
    // ShoppingPage
    //          ↓
    // CartRepository.updateOrder()
    //
    // Returns ApiResponse<bool>
    // =========================================================

    if (widget.isEditMode) {
      return widget.onUpdate!(
        configuration,
        _quantity,
      );
    }

    // =========================================================
    // CREATE MODE
    //
    // New configuration:
    //
    // ProductConfigurationForm
    //          ↓
    // ProductRepository.addToConfigurator()
    // =========================================================

    return ProductRepository.addToConfigurator(
      productId: widget.product.id,
      configuration: configuration,
      quantity: _quantity,
    );
  }

  // =========================================================
  // BOTTOM ACTION AREA
  // =========================================================

  Widget _buildBottomActionArea() {
    return SafeArea(
      top: false,
      child: Container(
        padding:
        const EdgeInsets.fromLTRB(
          16,
          10,
          16,
          12,
        ),
        decoration:
        const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: Color(
                0x22000000,
              ),
              offset: Offset(
                0,
                -2,
              ),
            ),
          ],
        ),
        child: Column(
          mainAxisSize:
          MainAxisSize.min,
          children: [
            // =================================================
            // QUANTITY
            // =================================================

            Row(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed:
                  _decreaseQuantity,
                  icon: const Icon(
                    Icons
                        .remove_circle_outline,
                  ),
                ),
                Container(
                  constraints:
                  const BoxConstraints(
                    minWidth: 50,
                  ),
                  alignment:
                  Alignment.center,
                  child: Text(
                    _quantity.toString(),
                    style:
                    const TextStyle(
                      fontSize: 18,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed:
                  _increaseQuantity,
                  icon: const Icon(
                    Icons
                        .add_circle_outline,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 8,
            ),

            // =================================================
            // CREATE / UPDATE BUTTON
            // =================================================

            ApiActionButton<dynamic>(
              title: widget.isEditMode ? 'Update Configuration' : 'Add to Configurator',
              onCall: _saveConfiguration,
              successMessage: widget.isEditMode ? 'Configuration updated successfully!' : 'Successfully added to configurator!',
              onSuccess: (data) {
                if (widget.isEditMode) {
                  widget.onUpdateSuccess?.call();
                }
              },
              onError: (message) {
                /*
                 * Error UI is handled
                 * by ApiActionButton.
                 */
              },
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void dispose() {
    for (final controller
    in _textControllers.values) {
      controller.dispose();
    }

    for (final controller
    in _otherControllers.values) {
      controller.dispose();
    }

    super.dispose();
  }
}