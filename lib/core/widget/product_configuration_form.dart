import 'package:flutter/material.dart';

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
  final Map<String, String?> _dropdownValues = {};
  final Map<String, String?> _errors = {};

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
        }

        _errors[field.key] = null;
      }
    }
  }

  // =========================================================
  // CONDITIONAL VISIBILITY
  // =========================================================

  bool _isFieldVisible(
      ProductFieldData field,
      ) {
    final controllingKey = field.visibleWhenFieldKey;
    final requiredValue = field.visibleWhenValue;

    // No condition = always visible.
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
        }

        _errors[field.key] = null;

        // Also clear fields that may depend
        // on this field.
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
        // Hidden field should not be validated.
        if (!_isFieldVisible(field)) {
          _errors[field.key] = null;
          continue;
        }

        if (!field.required) {
          _errors[field.key] = null;
          continue;
        }

        // -----------------------------------------------------
        // TEXT
        // -----------------------------------------------------

        if (field.type == ProductFieldType.text) {
          final value = _textControllers[field.key]?.text.trim();

          if (value == null || value.isEmpty) {
            _errors[field.key] =
            '${field.label} is required';

            valid = false;
          } else {
            _errors[field.key] = null;
          }
        }

        // -----------------------------------------------------
        // DROPDOWN
        // -----------------------------------------------------

        if (field.type == ProductFieldType.dropdown) {
          final value = _dropdownValues[field.key];

          if (value == null || value.trim().isEmpty) {
            _errors[field.key] =
            'Please select ${field.label}';

            valid = false;
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
        // Hidden conditional fields should not
        // be sent to API.
        if (!_isFieldVisible(field)) {
          continue;
        }

        // -----------------------------------------------------
        // TEXT
        // -----------------------------------------------------

        if (field.type == ProductFieldType.text) {
          data[field.key] =
              _textControllers[field.key]?.text.trim() ?? '';
        }

        // -----------------------------------------------------
        // DROPDOWN
        // -----------------------------------------------------

        if (field.type == ProductFieldType.dropdown) {
          data[field.key] =
              _dropdownValues[field.key] ?? '';
        }
      }
    }

    return data;
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        // =====================================================
        // CONFIGURATION SECTIONS
        // =====================================================

        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount:
            widget.product.configurationSections.length,
            itemBuilder: (context, sectionIndex,) {
              final section = widget.product.configurationSections[sectionIndex];
              return _buildSection(section);
            },
          ),
        ),

        // =====================================================
        // BOTTOM ACTION AREA
        // =====================================================

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
    _isSectionComplete(section);

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

        trailing: complete ? const Icon(Icons.check_circle, color: Colors.green,) : const Icon(Icons.keyboard_arrow_down,),

        children: section.fields.where(_isFieldVisible).map((field) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(
              16,
              8,
              16,
              12,
            ),
            child: _buildField(field),
          );
        }).toList(),
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
        return _buildTextField(field);

      case ProductFieldType.dropdown:
        return _buildDropdown(field);
    }
  }

  // =========================================================
  // TEXT FIELD
  // =========================================================

  Widget _buildTextField(
      ProductFieldData field,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // -----------------------------------------------------
        // OPTIONAL MEASUREMENT IMAGE
        // -----------------------------------------------------

        if (field.imagePath != null) ...[
          Center(
            child: Image.asset(
              field.imagePath!,
              height: 180,
              fit: BoxFit.contain,
              errorBuilder: (
                  context,
                  error,
                  stackTrace,
                  ) {
                return const SizedBox(
                  height: 100,
                  child: Center(
                    child: Text(
                      'Image not found',
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 12),
        ],

        // -----------------------------------------------------
        // TEXT INPUT
        // -----------------------------------------------------

        TextField(
          controller:
          _textControllers[field.key],

          minLines:
          field.multiline ? 4 : 1,

          maxLines:
          field.multiline ? 6 : 1,

          keyboardType:
          field.multiline
              ? TextInputType.multiline
              : TextInputType.text,

          textInputAction:
          field.multiline
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

            errorText:
            _errors[field.key],

            alignLabelWithHint:
            field.multiline,

            border:
            const OutlineInputBorder(),
          ),
        ),
      ],
    );
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

        errorText:
        _errors[field.key],

        border:
        const OutlineInputBorder(),
      ),

      items: field.options.map((option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(
            option,
            overflow:
            TextOverflow.ellipsis,
          ),
        );
      }).toList(),

      onChanged: (value) {
        setState(() {
          _dropdownValues[field.key] =
              value;

          _errors[field.key] = null;

          // If controlling dropdown changed,
          // clear values from fields that have
          // now become hidden.
          _clearHiddenDependentFields(
            field.key,
          );
        });
      },
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
              color: Color(0x22000000),
              offset: Offset(0, -2),
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
                    Icons.remove_circle_outline,
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
                    Icons.add_circle_outline,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // =================================================
            // API ACTION BUTTON
            // =================================================

            ApiActionButton<Map<String, dynamic>>(title: 'Add to Configurator', onCall: () async {
                if (!_validateForm()) {
                  return ApiResponse<Map<String, dynamic>>.failure(
                    message: 'Please fill all required fields.',
                  );
                }

                final configuration = _collectFormData();
                return ProductRepository.addToConfigurator(productId: widget.product.id, configuration: configuration, quantity: _quantity,);
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
    for (final controller
    in _textControllers.values) {
      controller.dispose();
    }

    super.dispose();
  }
}