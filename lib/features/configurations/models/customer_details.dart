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
