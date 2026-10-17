// =========================================================
// RFQ / PROJECT NUMBER FORMATTING
//
// Backend stores plain numbers:
//
// rfqNumber     = 10001
// projectNumber = 10001
//
// UI always shows them with a prefix:
//
// RFQ-10001
// P-10001
//
// Returns null when the backend has not sent a number yet,
// so callers can simply hide the label.
// =========================================================

String? formatRfqNumber(
    dynamic value,
    ) {
  return _withPrefix(
    value,
    'RFQ-',
  );
}

String? formatProjectNumber(
    dynamic value,
    ) {
  return _withPrefix(
    value,
    'P-',
  );
}

// Lets search match "10001", "RFQ-10001" and "rfq10001"
// against the same record.
String normalizeReferenceSearch(
    String value,
    ) {
  return value
      .toLowerCase()
      .replaceAll(
    RegExp(r'[\s\-#]'),
    '',
  );
}

String? _withPrefix(
    dynamic value,
    String prefix,
    ) {
  final text =
      value?.toString().trim() ?? '';

  if (text.isEmpty ||
      text == 'null') {
    return null;
  }

  if (text.toUpperCase().startsWith(
    prefix,
  )) {
    return text.toUpperCase();
  }

  return '$prefix$text';
}
