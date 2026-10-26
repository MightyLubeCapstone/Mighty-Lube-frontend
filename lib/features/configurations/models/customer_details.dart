// =========================================================
// CUSTOMER DETAILS
//
// Who the RFQs are for. Entered at Finalize:
//
// Project RFQs    -> saved once on the project, shared by
//                    every RFQ in it (owner/admin can edit).
// Standalone RFQs -> saved on each RFQ.
//
// Four sections, all plain text. Same field names as the
// backend (models/customer_details.js).
// =========================================================

class CustomerDetails {
  const CustomerDetails({
    this.customer = const {},
    this.finalCustomer = const {},
    this.contact = const {},
    this.additionalInfo = const {},
  });

  // name, country, address1, address2, city, state,
  // postalCode, phone, email
  final Map<String, String> customer;

  // name, address1, address2, city, state, postalCode,
  // country
  final Map<String, String> finalCustomer;

  // type, name, email, phone
  final Map<String, String> contact;

  // orderNotes, consultation, projectStatus, install,
  // shipping, preferredShippingDate (yyyy-MM-dd)
  final Map<String, String> additionalInfo;

  // null when the backend has no details (old projects).
  static CustomerDetails? fromJson(
      dynamic json,
      ) {
    if (json is! Map) {
      return null;
    }

    final details = CustomerDetails(
      customer: _section(json['customer']),
      finalCustomer: _section(json['finalCustomer']),
      contact: _section(json['contact']),
      additionalInfo: _section(json['additionalInfo']),
    );

    return details.isComplete ? details : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'customer': customer,
      'finalCustomer': finalCustomer,
      'contact': contact,
      'additionalInfo': additionalInfo,
    };
  }

  // Filled sections with readable labels, in display order.
  // Empty fields and empty sections are left out. Used by
  // the summary widget and the admin PDF.
  //
  // Customer
  //   Customer: Fresaders
  //   City: Fremont
  List<CustomerDetailsSection> get filledSections {
    CustomerDetailsSection section(
        String title,
        Map<String, String> values,
        Map<String, String> labels,
        ) {
      return CustomerDetailsSection(
        title: title,
        rows: [
          for (final entry in labels.entries)
            if ((values[entry.key] ?? '').isNotEmpty)
              MapEntry(entry.value, values[entry.key]!),
        ],
      );
    }

    return [
      section('Customer', customer, _customerLabels),
      section('Final Customer', finalCustomer, _finalCustomerLabels),
      section('Contact', contact, _contactLabels),
      section('Additional information', additionalInfo, _additionalLabels),
    ].where((section) => section.rows.isNotEmpty).toList();
  }

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

  // Same check as the backend's hasCustomerDetails.
  bool get isComplete {
    return (customer['email'] ?? '').isNotEmpty;
  }

  static Map<String, String> _section(
      dynamic value,
      ) {
    if (value is! Map) {
      return const {};
    }

    final result = <String, String>{};

    value.forEach((key, fieldValue) {
      final text = fieldValue?.toString().trim() ?? '';

      if (text.isNotEmpty && text != 'null') {
        result[key.toString()] = text;
      }
    });

    return result;
  }
}

class CustomerDetailsSection {
  const CustomerDetailsSection({
    required this.title,
    required this.rows,
  });

  final String title;

  // label -> value
  final List<MapEntry<String, String>> rows;
}
