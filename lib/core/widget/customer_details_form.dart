import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:mighty_lube/core/network/api_response.dart';
import 'package:mighty_lube/core/utils/customer_detail_options.dart';
import 'package:mighty_lube/features/configurations/models/customer_details.dart';

// =========================================================
// CUSTOMER DETAILS FORM
//
// Customer / Final Customer / Contact / Additional
// information. Used by the Finalize dialog and the
// Edit project details dialogs (user + admin).
//
// final formKey = GlobalKey<CustomerDetailsFormState>();
// CustomerDetailsForm(key: formKey, initial: details)
// formKey.currentState?.validate() -> CustomerDetails or
// null when a required field is missing.
// =========================================================

const _labelColor = Color(0xFF555555);

const _optionalColor = Color(0xFF1E7BC0);

final _emailPattern = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

final _dateFormat = DateFormat('yyyy-MM-dd');

class CustomerDetailsForm extends StatefulWidget {
  const CustomerDetailsForm({
    super.key,
    this.initial,
  });

  final CustomerDetails? initial;

  @override
  State<CustomerDetailsForm> createState() => CustomerDetailsFormState();
}

class CustomerDetailsFormState extends State<CustomerDetailsForm> {
  final _formKey = GlobalKey<FormState>();

  // 'customer.city' -> controller
  final Map<String, TextEditingController> _controllers = {};

  // Dropdowns with "Other": 'contact.type' -> selected option
  final Map<String, String?> _choices = {};

  @override
  void initState() {
    super.initState();

    final initial = widget.initial;

    if (initial == null) {
      _controller('customer', 'country').text = defaultCountry;
    } else {
      _fill('customer', initial.customer);
      _fill('finalCustomer', initial.finalCustomer);
      _fill('contact', initial.contact);
      _fill('additionalInfo', initial.additionalInfo);
    }

    _initChoice('contact', 'type', contactTypeOptions);
    _initChoice('additionalInfo', 'consultation', consultationOptions);
    _initChoice('additionalInfo', 'projectStatus', projectStatusOptions);
    _initChoice('additionalInfo', 'install', installOptions);
    _initChoice('additionalInfo', 'shipping', shippingOptions);
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }

    super.dispose();
  }

  TextEditingController _controller(
      String section,
      String field,
      ) {
    return _controllers.putIfAbsent(
      '$section.$field',
          () => TextEditingController(),
    );
  }

  String _value(
      String section,
      String field,
      ) {
    return _controller(section, field).text.trim();
  }

  void _fill(
      String section,
      Map<String, String> values,
      ) {
    values.forEach((field, value) {
      _controller(section, field).text = value;
    });
  }

  // Saved "Collect" -> Collect. Saved "Own truck" -> Other
  // with "Own truck" in the text box.
  void _initChoice(
      String section,
      String field,
      List<String> options,
      ) {
    final saved = _value(section, field);

    if (saved.isEmpty) {
      _choices['$section.$field'] = null;
    } else if (options.contains(saved) && saved != otherOption) {
      _choices['$section.$field'] = saved;
    } else {
      _choices['$section.$field'] = otherOption;
    }
  }

  // =========================================================
  // VALIDATE
  //
  // null when a required field is missing (errors are shown
  // under the fields).
  // =========================================================

  CustomerDetails? validate() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return null;
    }

    Map<String, String> section(
        String name,
        List<String> fields,
        ) {
      return {
        for (final field in fields) field: _value(name, field),
      };
    }

    return CustomerDetails(
      customer: section('customer', [
        'name',
        'country',
        'address1',
        'address2',
        'city',
        'state',
        'postalCode',
        'phone',
        'email',
      ]),
      finalCustomer: section('finalCustomer', [
        'name',
        'address1',
        'address2',
        'city',
        'state',
        'postalCode',
        'country',
      ]),
      contact: section('contact', [
        'type',
        'name',
        'email',
        'phone',
      ]),
      additionalInfo: section('additionalInfo', [
        'orderNotes',
        'consultation',
        'projectStatus',
        'install',
        'shipping',
        'preferredShippingDate',
      ]),
    );
  }

  // =========================================================
  // FIELDS
  // =========================================================

  Widget _label(
      String text, {
        required bool required,
      }) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 6,
      ),
      child: Text.rich(
        TextSpan(
          text: text,
          style: const TextStyle(
            color: _labelColor,
            fontSize: 14,
          ),
          children: [
            TextSpan(
              text: required ? ' *' : ' (optional)',
              style: const TextStyle(
                color: _optionalColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _decoration({
    String? hint,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      isDense: true,
      suffixIcon: suffixIcon,
      border: const OutlineInputBorder(),
    );
  }

  Widget _field(
      Widget label,
      Widget input,
      ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 14,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label,
          input,
        ],
      ),
    );
  }

  Widget _textField(
      String section,
      String field,
      String label, {
        bool required = false,
        bool email = false,
        String? hint,
        int maxLines = 1,
        TextInputType? keyboardType,
      }) {
    return _field(
      _label(label, required: required),
      TextFormField(
        controller: _controller(section, field),
        maxLines: maxLines,
        keyboardType: email ? TextInputType.emailAddress : keyboardType,
        decoration: _decoration(hint: hint),
        validator: (value) {
          final text = value?.trim() ?? '';

          if (required && text.isEmpty) {
            return '$label is required.';
          }

          if (email && text.isNotEmpty && !_emailPattern.hasMatch(text)) {
            return 'Enter a valid email address.';
          }

          return null;
        },
      ),
    );
  }

  Widget _countryField(
      String section, {
        required bool required,
      }) {
    final controller = _controller(section, 'country');
    final current = controller.text.trim();

    return _field(
      _label('Country / Region', required: required),
      DropdownButtonFormField<String>(
        initialValue: current.isEmpty ? null : current,
        isExpanded: true,
        menuMaxHeight: 320,
        decoration: _decoration(),
        items: [
          // Saved country that is not in the list.
          if (current.isNotEmpty && !countryOptions.contains(current))
            DropdownMenuItem(
              value: current,
              child: Text(current),
            ),
          for (final country in countryOptions)
            DropdownMenuItem(
              value: country,
              child: Text(country),
            ),
        ],
        onChanged: (country) {
          setState(() {
            controller.text = country ?? '';

            // Keep the state only if it belongs to the new
            // country's list (or the new country has none).
            final stateController = _controller(section, 'state');
            final states = statesByCountry[country];

            if (states != null &&
                !states.contains(stateController.text.trim())) {
              stateController.clear();
            }
          });
        },
        validator: (value) {
          if (required && (value ?? '').trim().isEmpty) {
            return 'Country / Region is required.';
          }

          return null;
        },
      ),
    );
  }

  Widget _stateField(
      String section, {
        required bool required,
      }) {
    final country = _value(section, 'country');
    final states = statesByCountry[country];

    if (states == null) {
      return _textField(
        section,
        'state',
        country == 'Canada' ? 'Province' : 'State',
        required: required,
      );
    }

    final controller = _controller(section, 'state');
    final current = controller.text.trim();

    return _field(
      _label(country == 'Canada' ? 'Province' : 'State', required: required),
      DropdownButtonFormField<String>(
        // New list when the country changes.
        key: ValueKey('$section.state.$country'),
        initialValue: states.contains(current) ? current : null,
        isExpanded: true,
        menuMaxHeight: 320,
        decoration: _decoration(),
        items: [
          for (final state in states)
            DropdownMenuItem(
              value: state,
              child: Text(state),
            ),
        ],
        onChanged: (state) {
          controller.text = state ?? '';
        },
        validator: (value) {
          if (required && (value ?? '').trim().isEmpty) {
            return '${country == 'Canada' ? 'Province' : 'State'} is required.';
          }

          return null;
        },
      ),
    );
  }

  // Dropdown + "Other" text box. The saved value is the
  // chosen option, or the typed text when Other is chosen.
  Widget _choiceField(
      String section,
      String field,
      String label,
      List<String> options,
      ) {
    final key = '$section.$field';
    final controller = _controller(section, field);
    final choice = _choices[key];

    return _field(
      _label(label, required: false),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<String>(
            initialValue: choice,
            isExpanded: true,
            decoration: _decoration(hint: 'Select'),
            items: [
              for (final option in options)
                DropdownMenuItem(
                  value: option,
                  child: Text(option),
                ),
            ],
            onChanged: (value) {
              setState(() {
                _choices[key] = value;

                controller.text =
                value == otherOption ? '' : (value ?? '');
              });
            },
          ),
          if (choice == otherOption)
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
              ),
              child: TextFormField(
                controller: controller,
                decoration: _decoration(hint: 'Please specify'),
                validator: (value) {
                  if ((value ?? '').trim().isEmpty) {
                    return 'Please specify $label, or pick another option.';
                  }

                  return null;
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _dateField(
      String section,
      String field,
      String label,
      ) {
    final controller = _controller(section, field);

    return _field(
      _label(label, required: false),
      TextFormField(
        controller: controller,
        readOnly: true,
        decoration: _decoration(
          hint: 'Select a date',
          suffixIcon: controller.text.isEmpty
              ? const Icon(Icons.calendar_today, size: 18)
              : IconButton(
            tooltip: 'Clear date',
            icon: const Icon(Icons.clear, size: 18),
            onPressed: () {
              setState(controller.clear);
            },
          ),
        ),
        onTap: () async {
          final now = DateTime.now();
          final saved = DateTime.tryParse(controller.text);

          final picked = await showDatePicker(
            context: context,
            initialDate: saved ?? now,
            firstDate: DateTime(now.year - 1),
            lastDate: DateTime(now.year + 5),
          );

          if (picked != null) {
            setState(() {
              controller.text = _dateFormat.format(picked);
            });
          }
        },
      ),
    );
  }

  Widget _sectionTitle(
      String text,
      ) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 12,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(0xFF333333),
        ),
      ),
    );
  }

  Widget _shippingNotes(
      String title,
      List<List<String>> notes,
      ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 14,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF1E5BB8),
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          for (final note in notes)
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: note[0],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (note[1].isNotEmpty) TextSpan(text: ' ${note[1]}'),
                ],
              ),
              style: const TextStyle(
                fontSize: 13,
                color: _labelColor,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ---------------- CUSTOMER ----------------
          _sectionTitle('Customer'),
          _textField('customer', 'name', 'Customer'),
          _countryField('customer', required: true),
          _textField('customer', 'address1', 'Street address',
              required: true, hint: 'House number and street name'),
          _textField('customer', 'address2', 'Apartment, suite, unit, etc.'),
          _textField('customer', 'city', 'Town / City', required: true),
          _stateField('customer', required: true),
          _textField('customer', 'postalCode', 'ZIP Code', required: true),
          _textField('customer', 'phone', 'Phone',
              required: true, keyboardType: TextInputType.phone),
          _textField('customer', 'email', 'Email address',
              required: true, email: true),

          // ------------- FINAL CUSTOMER -------------
          _sectionTitle('Final Customer'),
          _textField('finalCustomer', 'name', 'Name'),
          _textField('finalCustomer', 'address1', 'Address 1'),
          _textField('finalCustomer', 'address2', 'Address 2'),
          _textField('finalCustomer', 'city', 'City'),
          _stateField('finalCustomer', required: false),
          _textField('finalCustomer', 'postalCode', 'Postal'),
          _countryField('finalCustomer', required: false),

          // ----------------- CONTACT ----------------
          _sectionTitle('Contact'),
          _choiceField('contact', 'type', 'Type', contactTypeOptions),
          _textField('contact', 'name', 'Name'),
          _textField('contact', 'email', 'Email', email: true),
          _textField('contact', 'phone', 'Phone',
              keyboardType: TextInputType.phone),

          // --------- ADDITIONAL INFORMATION ---------
          _sectionTitle('Additional information'),
          _textField('additionalInfo', 'orderNotes', 'Order notes',
              maxLines: 3,
              hint: 'Notes about your order, e.g. special notes for delivery.'),
          _choiceField('additionalInfo', 'consultation', 'Consultation',
              consultationOptions),
          _choiceField('additionalInfo', 'projectStatus', 'Project Status',
              projectStatusOptions),
          _choiceField('additionalInfo', 'install', 'Install', installOptions),
          _choiceField(
              'additionalInfo', 'shipping', 'Shipping', shippingOptions),
          _dateField('additionalInfo', 'preferredShippingDate',
              'Preferred Shipping Date'),
          _shippingNotes(domesticShippingTitle, domesticShippingNotes),
          _shippingNotes(
              internationalShippingTitle, internationalShippingNotes),
        ],
      ),
    );
  }
}

// =========================================================
// CUSTOMER DETAILS SUMMARY
//
// Read-only view of saved details. Empty fields and empty
// sections are hidden.
// =========================================================

class CustomerDetailsSummary extends StatelessWidget {
  const CustomerDetailsSummary({
    super.key,
    required this.details,
  });

  final CustomerDetails details;

  static const _customerLabels = {
    'name': 'Customer',
    'address1': 'Street address',
    'address2': 'Apt / Suite',
    'city': 'City',
    'state': 'State',
    'postalCode': 'ZIP Code',
    'country': 'Country',
    'phone': 'Phone',
    'email': 'Email',
  };

  static const _finalCustomerLabels = {
    'name': 'Name',
    'address1': 'Address 1',
    'address2': 'Address 2',
    'city': 'City',
    'state': 'State',
    'postalCode': 'Postal',
    'country': 'Country',
  };

  static const _contactLabels = {
    'type': 'Type',
    'name': 'Name',
    'email': 'Email',
    'phone': 'Phone',
  };

  static const _additionalLabels = {
    'orderNotes': 'Order notes',
    'consultation': 'Consultation',
    'projectStatus': 'Project Status',
    'install': 'Install',
    'shipping': 'Shipping',
    'preferredShippingDate': 'Preferred Shipping Date',
  };

  Widget? _section(
      String title,
      Map<String, String> values,
      Map<String, String> labels,
      ) {
    final rows = [
      for (final entry in labels.entries)
        if ((values[entry.key] ?? '').isNotEmpty)
          MapEntry(entry.value, values[entry.key]!),
    ];

    if (rows.isEmpty) {
      return null;
    }

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          for (final row in rows)
            Padding(
              padding: const EdgeInsets.only(
                top: 2,
              ),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${row.key}: ',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(text: row.value),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sections = [
      _section('Customer', details.customer, _customerLabels),
      _section('Final Customer', details.finalCustomer, _finalCustomerLabels),
      _section('Contact', details.contact, _contactLabels),
      _section(
          'Additional information', details.additionalInfo, _additionalLabels),
    ].whereType<Widget>().toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: sections,
    );
  }
}

// =========================================================
// EDIT CUSTOMER DETAILS DIALOG
//
// Pre-filled form + Save. Used by the user's Configurations
// screen and the admin's Project details dialog; each passes
// its own save call.
//
// Returns the saved CustomerDetails, or null on Cancel.
// =========================================================

class EditCustomerDetailsDialog extends StatefulWidget {
  const EditCustomerDetailsDialog({
    super.key,
    required this.title,
    required this.initial,
    required this.onSave,
  });

  final String title;

  // null for old projects without details.
  final CustomerDetails? initial;

  final Future<ApiResponse<CustomerDetails>> Function(
      CustomerDetails details,
      ) onSave;

  @override
  State<EditCustomerDetailsDialog> createState() =>
      _EditCustomerDetailsDialogState();
}

class _EditCustomerDetailsDialogState
    extends State<EditCustomerDetailsDialog> {
  final _formKey = GlobalKey<CustomerDetailsFormState>();

  bool _saving = false;

  String? _error;

  Future<void> _save() async {
    final details = _formKey.currentState?.validate();

    if (details == null) {
      setState(() {
        _error = 'Please fill in the required fields.';
      });
      return;
    }

    setState(() {
      _saving = true;
      _error = null;
    });

    final response = await widget.onSave(details);

    if (!mounted) {
      return;
    }

    if (response.success) {
      Navigator.of(context).pop(response.data ?? details);
      return;
    }

    setState(() {
      _saving = false;
      _error = response.message ?? 'Unable to save the details.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.title,
      ),
      content: SizedBox(
        // Clamped to the screen width on phones.
        width: 640,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Changes show on every RFQ in this project.',
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              CustomerDetailsForm(
                key: _formKey,
                initial: widget.initial,
              ),
            ],
          ),
        ),
      ),
      actions: [
        if (_error != null)
          Padding(
            padding: const EdgeInsets.only(
              right: 8,
            ),
            child: Text(
              _error!,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        TextButton(
          onPressed: _saving ? null : () => Navigator.of(context).pop(),
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        TextButton(
          onPressed: _saving ? null : _save,
          child: _saving
              ? const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          )
              : const Text(
            'Save',
            style: TextStyle(
              color: Color(0xFF579AF6),
            ),
          ),
        ),
      ],
    );
  }
}
