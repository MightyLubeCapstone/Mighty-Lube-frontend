import '../../../core/utils/rfq_format.dart';

// =========================================================
// SUBMITTED RFQ (user side)
//
// One finalized configuration = one RFQ.
//
// Backend fields (all optional until the backend sends
// them; missing values are simply hidden in the UI):
//
// rfqNumber      -> RFQ-10001
// projectID
// projectNumber  -> P-10001
// projectName
// =========================================================

class SubmittedRfq {
  const SubmittedRfq({
    required this.configurationID,
    required this.configurationName,
    required this.productName,
    required this.quantity,
    required this.configurationData,
    this.status,
    this.rfqNumber,
    this.projectID,
    this.projectNumber,
    this.projectName,
    this.submittedAt,
  });

  final String configurationID;

  final String configurationName;

  final String productName;

  final int quantity;

  final Map<String, dynamic> configurationData;

  // draft / cart / submitted / completed / archived
  final String? status;

  final String? rfqNumber;

  final String? projectID;

  final String? projectNumber;

  final String? projectName;

  final DateTime? submittedAt;

  factory SubmittedRfq.fromJson(
      Map<String, dynamic> json,
      ) {
    final project = json['project'] is Map
        ? Map<String, dynamic>.from(json['project'] as Map)
        : const <String, dynamic>{};

    return SubmittedRfq(
      configurationID: _text(json['configurationID']) ?? '',
      configurationName:
      _text(json['configurationName']) ?? 'Unnamed configuration',
      productName: _text(json['productName']) ??
          _text(json['productType']) ??
          'Configured product',
      quantity: _int(json['numRequested'] ?? json['quantity']),
      configurationData: json['configurationData'] is Map
          ? Map<String, dynamic>.from(json['configurationData'] as Map)
          : const <String, dynamic>{},
      status: _text(json['status'])?.toLowerCase(),
      rfqNumber: _text(json['rfqNumber']),
      projectID: _text(json['projectID'] ?? project['projectID']),
      projectNumber:
      _text(json['projectNumber'] ?? project['projectNumber']),
      projectName: _text(
        json['projectName'] ?? project['projectName'] ?? project['name'],
      ),
      submittedAt: _date(
        json['submittedAt'] ?? json['dateOrdered'] ?? json['updatedAt'],
      ),
    );
  }

  String? get rfqLabel {
    return formatRfqNumber(rfqNumber);
  }

  String? get projectNumberLabel {
    return formatProjectNumber(projectNumber);
  }

  // Draft/cart items are not RFQs yet.
  bool get isSubmitted {
    return status == null ||
        status == 'submitted' ||
        status == 'completed';
  }

  // Key used to keep RFQs of the same project together.
  String? get projectKey {
    final id = projectID ?? '';

    if (id.isNotEmpty) {
      return id;
    }

    final number = projectNumber ?? '';

    if (number.isNotEmpty) {
      return 'number:$number';
    }

    final name = projectName ?? '';

    if (name.isNotEmpty) {
      return 'name:${name.toLowerCase()}';
    }

    return null;
  }
}

// =========================================================
// USER PROJECT
//
// One of the user's existing projects, shown in the
// Finalize dialog's "Add to existing project" dropdown.
// =========================================================

class UserProject {
  const UserProject({
    required this.projectID,
    required this.projectName,
    this.projectNumber,
  });

  final String projectID;

  final String projectName;

  final String? projectNumber;

  factory UserProject.fromJson(
      Map<String, dynamic> json,
      ) {
    return UserProject(
      projectID: _text(json['projectID']) ?? '',
      projectName: _text(json['projectName'] ?? json['name']) ?? '',
      projectNumber: _text(json['projectNumber']),
    );
  }

  // P-10001 – Ford Plant Line 2
  String get label {
    return [formatProjectNumber(projectNumber), projectName]
        .whereType<String>()
        .join(' – ');
  }
}

// =========================================================
// FINALIZE RESULT
//
// What the backend returns after Finalize. Used by the
// success popup:
//
// Project: P-10001 – Ford Plant Line 2
// RFQ-10002 – CC5 Chain Lubricator
// =========================================================

class FinalizeResult {
  const FinalizeResult({
    this.rfqs = const [],
    this.projectNumber,
    this.projectName,
  });

  final List<SubmittedRfq> rfqs;

  final String? projectNumber;

  final String? projectName;

  // Backend response shapes accepted:
  //
  // { "configurations": [...], "project": {...} }
  // { "rfqs": [...], "project": {...} }
  // [ ... ]
  factory FinalizeResult.fromResponse(
      dynamic data,
      ) {
    List<dynamic> items = const [];
    Map<String, dynamic> project = const {};

    if (data is List) {
      items = data;
    } else if (data is Map) {
      final rawItems = data['configurations'] ?? data['rfqs'];

      if (rawItems is List) {
        items = rawItems;
      }

      if (data['project'] is Map) {
        project = Map<String, dynamic>.from(data['project'] as Map);
      }
    }

    final rfqs = items
        .whereType<Map>()
        .map((item) => SubmittedRfq.fromJson(
      Map<String, dynamic>.from(item),
    ))
        .toList();

    return FinalizeResult(
      rfqs: rfqs,
      projectNumber: _text(project['projectNumber']) ??
          (rfqs.isEmpty ? null : rfqs.first.projectNumber),
      projectName: _text(project['projectName'] ?? project['name']) ??
          (rfqs.isEmpty ? null : rfqs.first.projectName),
    );
  }

  String? get projectNumberLabel {
    return formatProjectNumber(projectNumber);
  }

  bool get hasRfqNumbers {
    return rfqs.any((rfq) => rfq.rfqLabel != null);
  }
}

String? _text(
    dynamic value,
    ) {
  final text = value?.toString().trim() ?? '';

  return text.isEmpty || text == 'null'
      ? null
      : text;
}

int _int(
    dynamic value,
    ) {
  if (value is num) {
    return value.toInt();
  }

  return int.tryParse(value?.toString() ?? '') ?? 0;
}

DateTime? _date(
    dynamic value,
    ) {
  final text = _text(value);

  return text == null
      ? null
      : DateTime.tryParse(text);
}
