class AdminConfigurationSummary {
  const AdminConfigurationSummary({
    this.total = 0,

    // Existing configuration lifecycle summary fields.
    this.draft = 0,
    this.cart = 0,
    this.submitted = 0,
    this.completed = 0,
    this.archived = 0,

    // Admin workflow summary fields.
    this.requested = 0,
    this.pending = 0,
    this.done = 0,
  });

  final int total;


  // =========================================================
  // CONFIGURATION LIFECYCLE SUMMARY
  //
  // draft
  // cart
  // submitted
  // completed
  // archived
  //
  // Kept for backward compatibility with existing data.
  // =========================================================

  final int draft;

  final int cart;

  final int submitted;

  final int completed;

  final int archived;


  // =========================================================
  // ADMIN WORKFLOW SUMMARY
  //
  // requested:
  // Newly submitted configuration waiting for admin processing.
  //
  // pending:
  // Admin/business team is processing the configuration.
  //
  // done:
  // Admin/business processing is complete.
  // =========================================================

  final int requested;

  final int pending;

  final int done;


  factory AdminConfigurationSummary.fromJson(
      Map<String, dynamic> json,
      ) {
    return AdminConfigurationSummary(
      total:
      _asInt(
        json['total'],
      ),

      draft:
      _asInt(
        json['draft'],
      ),

      cart:
      _asInt(
        json['cart'],
      ),

      submitted:
      _asInt(
        json['submitted'],
      ),

      completed:
      _asInt(
        json['completed'],
      ),

      archived:
      _asInt(
        json['archived'],
      ),

      requested:
      _asInt(
        json['requested'],
      ),

      pending:
      _asInt(
        json['pending'],
      ),

      done:
      _asInt(
        json['done'],
      ),
    );
  }
}


// =========================================================
// ADMIN CONFIGURATION LIST RESPONSE
// =========================================================

class AdminConfigurationListResponse {
  const AdminConfigurationListResponse({
    required this.summary,
    required this.data,
  });

  final AdminConfigurationSummary summary;

  final List<AdminConfiguration> data;
}


// =========================================================
// ADMIN CONFIGURATION FILTERS
// =========================================================

class AdminConfigurationFilters {
  const AdminConfigurationFilters({
    this.sortBy = 'createdAt',
    this.sortOrder = 'asc',
    this.dateField = 'createdAt',
    this.dateFilter = 'all',
    this.startDate,
    this.endDate,
    this.adminWorkflowStatus,
  });

  final String sortBy;

  final String sortOrder;

  final String dateField;

  final String dateFilter;

  final DateTime? startDate;

  final DateTime? endDate;


  // =========================================================
  // ADMIN WORKFLOW STATUS FILTER
  //
  // Supported values:
  //
  // all
  // requested
  // pending
  // done
  //
  // Backend also supports comma-separated values.
  //
  // Example:
  //
  // requested,pending
  //
  // Flutter/domain naming:
  //
  // adminWorkflowStatus
  //
  // Backend query naming:
  //
  // adminStatus
  // =========================================================

  final String? adminWorkflowStatus;


  Map<String, String> toQueryParameters() {
    final normalizedAdminWorkflowStatus = adminWorkflowStatus?.trim();

    return {
      'sortBy': sortBy,
      'sortOrder': sortOrder.toLowerCase() == 'desc' ? 'desc' : 'asc',
      'dateField': dateField,
      'dateFilter': dateFilter,
      if (normalizedAdminWorkflowStatus != null &&
          normalizedAdminWorkflowStatus.isNotEmpty &&
          normalizedAdminWorkflowStatus != 'all')
        'adminStatus': normalizedAdminWorkflowStatus,
      if (dateFilter == 'custom' && startDate != null)
        'startDate': _dateOnly(
          startDate!,
        ),
      if (dateFilter == 'custom' && endDate != null)
        'endDate': _dateOnly(
          endDate!,
        ),
    };
  }


  AdminConfigurationFilters copyWith({
    String? sortBy,
    String? sortOrder,
    String? dateField,
    String? dateFilter,
    DateTime? startDate,
    DateTime? endDate,
    String? adminWorkflowStatus,
    bool clearDates = false,
    bool clearAdminWorkflowStatus = false,
  }) {
    return AdminConfigurationFilters(
      sortBy:
      sortBy ??
          this.sortBy,

      sortOrder:
      sortOrder ??
          this.sortOrder,

      dateField:
      dateField ??
          this.dateField,

      dateFilter:
      dateFilter ??
          this.dateFilter,

      startDate:
      clearDates
          ? null
          : startDate ??
          this.startDate,

      endDate:
      clearDates
          ? null
          : endDate ??
          this.endDate,

      adminWorkflowStatus:
      clearAdminWorkflowStatus
          ? null
          : adminWorkflowStatus ??
          this.adminWorkflowStatus,
    );
  }


  // =========================================================
  // BACKWARD COMPATIBILITY
  //
  // Existing UI may still read filters.status.
  //
  // New code should use:
  //
  // adminWorkflowStatus
  // =========================================================

  String? get status {
    return adminWorkflowStatus;
  }
}


// =========================================================
// ADMIN CONFIGURATION
//
// ProductConfiguration has TWO independent status concepts.
//
// CONFIGURATION STATUS:
//
// draft
// cart
// submitted
// completed
// archived
//
// ADMIN WORKFLOW STATUS:
//
// requested
// pending
// done
//
// Example:
//
// configurationStatus = submitted
// adminWorkflowStatus = pending
//
// Backend JSON:
//
// status = submitted
// adminStatus = pending
// =========================================================

class AdminConfiguration {
  AdminConfiguration({
    required this.configurationID,
    required this.userID,
    required this.configurationName,
    required this.productType,
    required this.productName,
    required this.configurationStatus,
    required this.adminWorkflowStatus,
    required this.isComplete,
    required this.numRequested,
    required this.configurationData,
    required this.draftID,
    required this.draftTitle,
    required this.createdBy,
    required this.updatedBy,
    required this.submittedAt,
    required this.completedAt,
    required this.adminRequestedAt,
    required this.adminStartedAt,
    required this.adminCompletedAt,
    required this.createdAt,
    required this.updatedAt,
  });


  final String configurationID;

  final String userID;

  final String configurationName;

  final String productType;

  final String productName;


  // =========================================================
  // CONFIGURATION LIFECYCLE STATUS
  //
  // Backend field:
  //
  // status
  //
  // Flutter/domain field:
  //
  // configurationStatus
  //
  // Values:
  //
  // draft
  // cart
  // submitted
  // completed
  // archived
  // =========================================================

  String configurationStatus;


  // =========================================================
  // ADMIN WORKFLOW STATUS
  //
  // Backend field:
  //
  // adminStatus
  //
  // Flutter/domain field:
  //
  // adminWorkflowStatus
  //
  // Values:
  //
  // requested
  // pending
  // done
  //
  // null is valid for configurations that have not entered
  // the admin workflow.
  // =========================================================

  String? adminWorkflowStatus;


  final bool isComplete;

  final int numRequested;

  final Map<String, dynamic> configurationData;

  final String? draftID;

  final String? draftTitle;

  final Map<String, dynamic>? createdBy;

  final Map<String, dynamic>? updatedBy;

  final DateTime? submittedAt;

  final DateTime? completedAt;


  // =========================================================
  // ADMIN WORKFLOW TIMESTAMPS
  // =========================================================

  final DateTime? adminRequestedAt;

  final DateTime? adminStartedAt;

  final DateTime? adminCompletedAt;


  final DateTime? createdAt;

  final DateTime? updatedAt;


  factory AdminConfiguration.fromJson(
      Map<String, dynamic> json,
      ) {
    return AdminConfiguration(
      configurationID:
      json['configurationID']
          ?.toString() ??
          '',

      userID:
      json['userID']
          ?.toString() ??
          '',

      configurationName:
      json['configurationName']
          ?.toString() ??
          'Unnamed configuration',

      productType:
      json['productType']
          ?.toString() ??
          '',

      productName:
      json['productName']
          ?.toString() ??
          '',

      configurationStatus:
      _normalizedConfigurationStatus(
        json['status'],
      ),

      adminWorkflowStatus:
      _normalizedAdminWorkflowStatus(
        json['adminStatus'],
      ),

      isComplete:
      _asBool(
        json['isComplete'],
      ),

      numRequested:
      _asInt(
        json['numRequested'],
      ),

      configurationData:
      json['configurationData'] is Map
          ? Map<String, dynamic>.from(
        json['configurationData'],
      )
          : <String, dynamic>{},

      draftID:
      json['draftID']
          ?.toString(),

      draftTitle:
      json['draftTitle']
          ?.toString(),

      createdBy:
      json['createdBy'] is Map
          ? Map<String, dynamic>.from(
        json['createdBy'],
      )
          : null,

      updatedBy:
      json['updatedBy'] is Map
          ? Map<String, dynamic>.from(
        json['updatedBy'],
      )
          : null,

      submittedAt:
      _asDateTime(
        json['submittedAt'],
      ),

      completedAt:
      _asDateTime(
        json['completedAt'],
      ),

      adminRequestedAt:
      _asDateTime(
        json['adminRequestedAt'],
      ),

      adminStartedAt:
      _asDateTime(
        json['adminStartedAt'],
      ),

      adminCompletedAt:
      _asDateTime(
        json['adminCompletedAt'],
      ),

      createdAt:
      _asDateTime(
        json['createdAt'],
      ),

      updatedAt:
      _asDateTime(
        json['updatedAt'],
      ),
    );
  }


  // =========================================================
  // BASIC UI HELPERS
  // =========================================================

  String get id {
    return configurationID;
  }


  String get name {
    return configurationName;
  }


  // =========================================================
  // CONFIGURATION STATUS HELPERS
  // =========================================================

  bool get isDraft {
    return configurationStatus == 'draft';
  }


  bool get isCart {
    return configurationStatus == 'cart';
  }


  bool get isSubmitted {
    return configurationStatus == 'submitted';
  }


  bool get isCompleted {
    return configurationStatus == 'completed';
  }


  bool get isArchived {
    return configurationStatus == 'archived';
  }


  // =========================================================
  // ADMIN WORKFLOW STATUS HELPERS
  // =========================================================

  bool get isRequested {
    return adminWorkflowStatus == 'requested';
  }


  bool get isPending {
    return adminWorkflowStatus == 'pending';
  }


  bool get isDone {
    return adminWorkflowStatus == 'done';
  }


  bool get hasAdminWorkflow {
    return adminWorkflowStatus != null;
  }


  // =========================================================
  // BACKWARD COMPATIBILITY
  //
  // Existing UI/repository code may still use:
  //
  // configuration.status
  // configuration.adminStatus
  //
  // New code should use:
  //
  // configuration.configurationStatus
  // configuration.adminWorkflowStatus
  // =========================================================

  String get status {
    return configurationStatus;
  }


  set status(
      String value,
      ) {
    configurationStatus =
        value;
  }


  String? get adminStatus {
    return adminWorkflowStatus;
  }


  set adminStatus(
      String? value,
      ) {
    adminWorkflowStatus =
        value;
  }
}


// =========================================================
// ADMIN USER
// =========================================================

class AdminUser {
  AdminUser({
    required this.id,
    required this.userID,
    required this.username,
    required this.role,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.company,
    required this.country,
    required this.createdAt,
    required this.updatedAt,
  });


  final String id;

  final String userID;

  final String username;

  String role;

  final String firstName;

  final String lastName;

  final String email;

  final String phone;

  final String company;

  final String country;

  final DateTime? createdAt;

  final DateTime? updatedAt;


  String get name {
    final value =
    '$firstName $lastName'
        .trim();

    return value.isEmpty
        ? '—'
        : value;
  }


  bool get isAdmin {
    return role == 'admin';
  }


  factory AdminUser.fromJson(
      Map<String, dynamic> json,
      ) {
    return AdminUser(
      id:
      json['_id']
          ?.toString() ??
          '',

      userID:
      json['userID']
          ?.toString() ??
          '',

      username:
      json['username']
          ?.toString() ??
          '—',

      role:
      json['role']
          ?.toString()
          .trim()
          .toLowerCase() ??
          'user',

      firstName:
      json['firstName']
          ?.toString() ??
          '',

      lastName:
      json['lastName']
          ?.toString() ??
          '',

      email:
      json['email']
          ?.toString() ??
          '—',

      phone:
      json['phoneNumber']
          ?.toString() ??
          '—',

      company:
      json['companyName']
          ?.toString() ??
          '—',

      country:
      json['country']
          ?.toString() ??
          '—',

      createdAt:
      _asDateTime(
        json['createdAt'],
      ),

      updatedAt:
      _asDateTime(
        json['updatedAt'],
      ),
    );
  }
}


// =========================================================
// HELPERS
// =========================================================

int _asInt(
    dynamic value,
    ) {
  if (value is num) {
    return value.toInt();
  }

  return int.tryParse(
    value?.toString() ??
        '',
  ) ??
      0;
}


bool _asBool(
    dynamic value,
    ) {
  if (value is bool) {
    return value;
  }

  if (value is num) {
    return value != 0;
  }

  final text =
  value
      ?.toString()
      .trim()
      .toLowerCase();

  return (
      text == 'true' ||
          text == '1'
  );
}


DateTime? _asDateTime(
    dynamic value,
    ) {
  if (value == null) {
    return null;
  }

  final text =
  value
      .toString()
      .trim();

  if (text.isEmpty) {
    return null;
  }

  return DateTime.tryParse(
    text,
  );
}


String _dateOnly(
    DateTime value,
    ) {
  final local =
  value.toLocal();

  final month =
  local.month
      .toString()
      .padLeft(
    2,
    '0',
  );

  final day =
  local.day
      .toString()
      .padLeft(
    2,
    '0',
  );

  return '${local.year}-$month-$day';
}


// =========================================================
// CONFIGURATION STATUS NORMALIZER
// =========================================================

String _normalizedConfigurationStatus(
    dynamic value,
    ) {
  final status =
  value
      ?.toString()
      .trim()
      .toLowerCase();

  const allowedConfigurationStatuses = {
    'draft',
    'cart',
    'submitted',
    'completed',
    'archived',
  };

  if (
  status != null &&
      allowedConfigurationStatuses.contains(
        status,
      )) {
    return status;
  }

  return 'draft';
}


// =========================================================
// ADMIN WORKFLOW STATUS NORMALIZER
//
// null is valid.
//
// draft/cart records do not have an admin workflow status.
//
// Older submitted records may temporarily have null until
// migrated or normalized by the backend admin API.
// =========================================================

String? _normalizedAdminWorkflowStatus(
    dynamic value,
    ) {
  final status =
  value
      ?.toString()
      .trim()
      .toLowerCase();

  const allowedAdminWorkflowStatuses = {
    'requested',
    'pending',
    'done',
  };

  if (
  status != null &&
      allowedAdminWorkflowStatuses.contains(
        status,
      )) {
    return status;
  }

  return null;
}


// =========================================================
// BACKWARD-COMPATIBLE TYPE NAMES
//
// These aliases allow existing files to continue compiling
// while we migrate callers one by one.
//
// New code should use the new names above.
// =========================================================

typedef ConfigurationSummary =
AdminConfigurationSummary;

typedef AdminConfigurations =
AdminConfigurationListResponse;

typedef AdminListFilters =
AdminConfigurationFilters;