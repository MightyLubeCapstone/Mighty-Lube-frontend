import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../features/products/models/product_detail_data.dart';
import '../../features/products/repositories/product_repository.dart';
import '../network/api_response.dart';
import 'api_action_button.dart';

class ProductConfigurationForm extends StatefulWidget {
  final ProductDetailData product;

  const ProductConfigurationForm({
    super.key,
    required this.product,
  });

  @override
  State<ProductConfigurationForm> createState() =>
      _ProductConfigurationFormState();
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

    _prepareFields();
  }

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
  // AUTOMATIC FIELD RULES
  // =========================================================

  bool _hasOtherOption(
    ProductFieldData field,
  ) {
    if (field.type != ProductFieldType.dropdown) {
      return false;
    }

    return field.options.any(
      (option) => option.trim().toLowerCase() == 'other',
    );
  }

  bool _isOtherSelected(
    ProductFieldData field,
  ) {
    final selectedValue = _dropdownValues[field.key];

    return selectedValue?.trim().toLowerCase() == 'other';
  }

  bool _shouldShowImagePicker(
    ProductFieldData field,
  ) {
    if (field.type != ProductFieldType.dropdown) {
      return false;
    }

    final value = _dropdownValues[field.key]?.trim().toLowerCase();

    if (value == null || value.isEmpty) {
      return false;
    }

    final hasYes = value.contains('yes');
    final hasAttachOrUpload =
        value.contains('attach') || value.contains('upload');

    return hasYes && hasAttachOrUpload;
  }

  String _imagePickerKeyFor(
    ProductFieldData field,
  ) {
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
          _selectedImages[_imagePickerKeyFor(field)] = null;
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
        final value = _textControllers[field.key]?.text.trim();

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
          final otherValue = _otherControllers[field.key]?.text.trim();

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
          final value = _textControllers[field.key]?.text.trim();

          if (field.required && (value == null || value.isEmpty)) {
            _errors[field.key] = '${field.label} is required';
            valid = false;
          } else {
            _errors[field.key] = null;
          }
        }

        if (field.type == ProductFieldType.dropdown) {
          final value = _dropdownValues[field.key];

          if (field.required && (value == null || value.trim().isEmpty)) {
            _errors[field.key] = 'Please select ${field.label}';
            valid = false;
          } else if (_isOtherSelected(field)) {
            final otherValue = _otherControllers[field.key]?.text.trim();

            if (otherValue == null || otherValue.isEmpty) {
              _errors[field.key] = 'Please specify ${field.label}';
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
  // COLLECT API DATA
  // =========================================================

  Map<String, dynamic> _collectFormData() {
    final Map<String, dynamic> data = {};

    for (final section in widget.product.configurationSections) {
      for (final field in section.fields) {
        if (!_isFieldVisible(field)) {
          continue;
        }

        if (field.type == ProductFieldType.text) {
          data[field.key] = _textControllers[field.key]?.text.trim() ?? '';
        }

        if (field.type == ProductFieldType.dropdown) {
          if (_isOtherSelected(field)) {
            data[field.key] = _otherControllers[field.key]?.text.trim() ?? '';
          } else {
            data[field.key] = _dropdownValues[field.key] ?? '';
          }

          if (_shouldShowImagePicker(field)) {
            final imageKey = _imagePickerKeyFor(
              field,
            );

            final image = _selectedImages[imageKey];

            if (image != null) {
              data[imageKey] = image.path;
            }
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

    setState(() {
      _selectedImages[_imagePickerKeyFor(field)] = image;
    });
  }

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
            itemCount: widget.product.configurationSections.length,
            itemBuilder: (
              context,
              sectionIndex,
            ) {
              final section =
                  widget.product.configurationSections[sectionIndex];

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
    final bool complete = _isSectionComplete(
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
        children: section.fields.where(_isFieldVisible).map(
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
      crossAxisAlignment: CrossAxisAlignment.start,
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
      controller: _textControllers[field.key],
      minLines: field.multiline ? 4 : 1,
      maxLines: field.multiline ? 6 : 1,
      keyboardType:
          field.multiline ? TextInputType.multiline : TextInputType.text,
      textInputAction:
          field.multiline ? TextInputAction.newline : TextInputAction.next,
      onChanged: (_) {
        setState(() {
          _errors[field.key] = null;

          _clearHiddenDependentFields(
            field.key,
          );
        });
      },
      decoration: InputDecoration(
        labelText: field.required ? '${field.label} *' : field.label,
        hintText: field.hintText,
        errorText: _errors[field.key],
        alignLabelWithHint: field.multiline,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildMeasurementImage(
    String imagePath,
  ) {
    return InkWell(
      onTap: () {
        _showAssetImagePreview(
          imagePath,
        );
      },
      borderRadius: BorderRadius.circular(
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
          borderRadius: BorderRadius.circular(
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
  // DROPDOWN
  // =========================================================

  Widget _buildDropdownField(
    ProductFieldData field,
  ) {
    final dropdown = _buildDropdown(
      field,
    );

    final otherTextField = _buildOtherTextField(
      field,
    );

    final showOther = _isOtherSelected(
      field,
    );

    final showPicker = _shouldShowImagePicker(
      field,
    );

    if (showOther) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
        crossAxisAlignment: CrossAxisAlignment.start,
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

  Widget _buildDropdown(
    ProductFieldData field,
  ) {
    return DropdownButtonFormField<String>(
      value: _dropdownValues[field.key],
      isExpanded: true,
      decoration: InputDecoration(
        labelText: field.required ? '${field.label} *' : field.label,
        errorText: _errors[field.key],
        border: const OutlineInputBorder(),
      ),
      items: field.options.map(
        (option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(
              option,
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
      ).toList(),
      onChanged: (value) {
        setState(() {
          _dropdownValues[field.key] = value;
          _errors[field.key] = null;

          if (!_isOtherSelected(field)) {
            _otherControllers[field.key]?.clear();
          }

          if (!_shouldShowImagePicker(field)) {
            _selectedImages[_imagePickerKeyFor(field)] = null;
          }

          _clearHiddenDependentFields(
            field.key,
          );
        });
      },
    );
  }

  Widget _buildOtherTextField(
    ProductFieldData field,
  ) {
    return TextField(
      controller: _otherControllers[field.key],
      textInputAction: TextInputAction.next,
      onChanged: (_) {
        setState(() {
          _errors[field.key] = null;
        });
      },
      decoration: InputDecoration(
        labelText: 'Please specify ${field.label}',
        hintText: 'Type custom ${field.label.toLowerCase()}',
        errorText: _errors[field.key],
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildImagePickerBox(
    ProductFieldData field,
  ) {
    final imageKey = _imagePickerKeyFor(
      field,
    );

    final selectedImage = _selectedImages[imageKey];

    return InkWell(
      onTap: () {
        if (selectedImage == null) {
          _pickImage(
            field,
          );
        } else {
          _showFileImagePreview(
            selectedImage,
          );
        }
      },
      borderRadius: BorderRadius.circular(
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
          borderRadius: BorderRadius.circular(
            8,
          ),
        ),
        child: selectedImage == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    'Tap to upload image',
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              )
            : Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
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
                    child: IconButton.filled(
                      onPressed: () {
                        setState(() {
                          _selectedImages[imageKey] = null;
                        });
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

  // =========================================================
  // BOTTOM ACTION AREA
  // =========================================================

  Widget _buildBottomActionArea() {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          16,
          10,
          16,
          12,
        ),
        decoration: const BoxDecoration(
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _decreaseQuantity,
                  icon: const Icon(
                    Icons.remove_circle_outline,
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(
                    minWidth: 50,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    _quantity.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _increaseQuantity,
                  icon: const Icon(
                    Icons.add_circle_outline,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            ApiActionButton<Map<String, dynamic>>(
              title: 'Add to Configurator',
              onCall: () async {
                if (!_validateForm()) {
                  return ApiResponse<Map<String, dynamic>>.failure(
                    message: 'Please fill all required fields.',
                  );
                }

                final configuration = _collectFormData();

                return ProductRepository.addToConfigurator(
                  productId: widget.product.id,
                  configuration: configuration,
                  quantity: _quantity,
                );
              },
              successMessage: 'Successfully added to configurator!',
              onSuccess: (data) {
                /*
                 * Later:
                 * - refresh cart
                 * - navigate
                 * - update badge
                 */
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
    for (final controller in _textControllers.values) {
      controller.dispose();
    }

    for (final controller in _otherControllers.values) {
      controller.dispose();
    }

    super.dispose();
  }
}
