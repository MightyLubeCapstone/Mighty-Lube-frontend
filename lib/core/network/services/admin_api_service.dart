import '../../../features/admin/models/admin_models.dart';
import '../api_client.dart';
import '../api_endpoints.dart';
import '../api_response.dart';

class AdminApiService {
  AdminApiService._();

  // =========================================================
  // GET ADMIN CONFIGURATIONS
  // =========================================================

  static Future<ApiResponse<AdminConfigurationListResponse>>
  getConfigurations({
    AdminConfigurationFilters filters = const AdminConfigurationFilters(),
  }) {
    final uri = Uri.parse(
      '${ApiEndpoints.apiBaseUrl}/admin/configurations',
    ).replace(
      queryParameters: filters.toQueryParameters(),
    );

    return ApiClient.get<AdminConfigurationListResponse>(
      url: uri.toString(),
      parser: (data) {
        if (data is! Map) {
          return const AdminConfigurationListResponse(
            summary: AdminConfigurationSummary(),
            data: [],
          );
        }

        final map = Map<String, dynamic>.from(data);

        final rawSummary = map['summary'];
        final rawData = map['data'];

        return AdminConfigurationListResponse(
          summary: AdminConfigurationSummary.fromJson(
            rawSummary is Map
                ? Map<String, dynamic>.from(rawSummary)
                : <String, dynamic>{},
          ),
          data: rawData is List
              ? rawData
              .whereType<Map>()
              .map(
                (item) => AdminConfiguration.fromJson(
              Map<String, dynamic>.from(item),
            ),
          )
              .toList()
              : <AdminConfiguration>[],
        );
      },
    );
  }

  // =========================================================
  // GET SINGLE ADMIN CONFIGURATION
  // =========================================================

  static Future<ApiResponse<AdminConfiguration>> getConfiguration({
    required String configurationID,
  }) {
    return ApiClient.get<AdminConfiguration>(
      url:
      '${ApiEndpoints.apiBaseUrl}/admin/configurations/${Uri.encodeComponent(configurationID)}',
      parser: (data) {
        if (data is Map) {
          final map = Map<String, dynamic>.from(data);
          final configuration = map['configuration'];

          if (configuration is Map) {
            return AdminConfiguration.fromJson(
              Map<String, dynamic>.from(configuration),
            );
          }
        }

        return AdminConfiguration.fromJson(
          <String, dynamic>{},
        );
      },
    );
  }

  // =========================================================
  // UPDATE CONFIGURATION
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> updateConfiguration({
    required String configurationID,
    required Map<String, dynamic> changes,
  }) {
    return ApiClient.patch<Map<String, dynamic>>(
      url:
      '${ApiEndpoints.apiBaseUrl}/admin/configurations/${Uri.encodeComponent(configurationID)}',
      body: changes,
      parser: _mapParser,
    );
  }

  // =========================================================
  // UPDATE ADMIN WORKFLOW STATUS
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
  // This API updates adminStatus only.
  //
  // Flutter/domain name:
  //
  // adminWorkflowStatus
  //
  // Backend field:
  //
  // adminStatus
  // =========================================================

  static Future<ApiResponse<String>> updateAdminWorkflowStatus({
    required String configurationID,
    required String adminWorkflowStatus,
  }) {
    final normalized = adminWorkflowStatus.trim().toLowerCase();

    const allowedAdminWorkflowStatuses = {
      'requested',
      'pending',
      'done',
    };

    if (!allowedAdminWorkflowStatuses.contains(
      normalized,
    )) {
      return Future.value(
        ApiResponse<String>.failure(
          message: 'Invalid admin workflow status.',
          statusCode: 400,
        ),
      );
    }

    return ApiClient.patch<String>(
      url:
      '${ApiEndpoints.apiBaseUrl}/admin/configurations/${Uri.encodeComponent(configurationID)}/status',
      body: {
        'adminStatus': normalized,
      },
      parser: (data) {
        if (data is Map) {
          final map = Map<String, dynamic>.from(data);

          final configuration = map['configuration'];

          if (configuration is Map) {
            final returnedAdminWorkflowStatus = configuration['adminStatus']
                ?.toString()
                .trim()
                .toLowerCase();

            if (returnedAdminWorkflowStatus != null &&
                allowedAdminWorkflowStatuses.contains(
                  returnedAdminWorkflowStatus,
                )) {
              return returnedAdminWorkflowStatus;
            }
          }
        }

        return '';
      },
    );
  }

  // =========================================================
  // BACKWARD COMPATIBILITY
  //
  // Existing callers may still use:
  //
  // updateConfigurationStatus(
  //   configurationID: ...,
  //   status: ...,
  // )
  //
  // New code should use:
  //
  // updateAdminWorkflowStatus(
  //   configurationID: ...,
  //   adminWorkflowStatus: ...,
  // )
  //
  // Remove this method after all callers are migrated.
  // =========================================================

  static Future<ApiResponse<String>> updateConfigurationStatus({
    required String configurationID,
    required String status,
  }) {
    return updateAdminWorkflowStatus(
      configurationID: configurationID,
      adminWorkflowStatus: status,
    );
  }

  // =========================================================
  // DELETE CONFIGURATION
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> deleteConfiguration({
    required String configurationID,
  }) {
    return ApiClient.delete<Map<String, dynamic>>(
      url:
      '${ApiEndpoints.apiBaseUrl}/admin/configurations/${Uri.encodeComponent(configurationID)}',
      parser: _mapParser,
    );
  }

  // =========================================================
  // GET ADMIN USERS
  // =========================================================

  static Future<ApiResponse<List<AdminUser>>> getUsers({
    AdminConfigurationFilters filters = const AdminConfigurationFilters(),
  }) {
    final uri = Uri.parse(
      '${ApiEndpoints.apiBaseUrl}/admin/users',
    ).replace(
      queryParameters: filters.toQueryParameters(),
    );

    return ApiClient.get<List<AdminUser>>(
      url: uri.toString(),
      parser: (data) {
        if (data is! Map) {
          return <AdminUser>[];
        }

        final map = Map<String, dynamic>.from(data);

        final rawData = map['data'];

        if (rawData is! List) {
          return <AdminUser>[];
        }

        return rawData
            .whereType<Map>()
            .map(
              (item) => AdminUser.fromJson(
            Map<String, dynamic>.from(
              item,
            ),
          ),
        )
            .toList();
      },
    );
  }

  // =========================================================
  // UPDATE USER ROLE
  // =========================================================

  static Future<ApiResponse<String>> updateUserRole({
    required String userID,
    required String role,
  }) {
    final normalized = role.trim().toLowerCase();

    if (!const {
      'user',
      'admin',
    }.contains(normalized)) {
      return Future.value(
        ApiResponse<String>.failure(
          message: 'Invalid user role.',
          statusCode: 400,
        ),
      );
    }

    return ApiClient.patch<String>(
      url:
      '${ApiEndpoints.apiBaseUrl}/admin/users/${Uri.encodeComponent(userID)}/role',
      body: {
        'role': normalized,
      },
      parser: (data) {
        if (data is Map) {
          final map = Map<String, dynamic>.from(data);

          final user = map['user'];

          if (user is Map) {
            final returnedRole = user['role']?.toString().trim().toLowerCase();

            if (returnedRole != null &&
                const {
                  'user',
                  'admin',
                }.contains(
                  returnedRole,
                )) {
              return returnedRole;
            }
          }
        }

        return '';
      },
    );
  }

  // =========================================================
  // RESET USER PASSWORD
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> resetUserPassword({
    required String userID,
    required String password,
  }) {
    return ApiClient.patch<Map<String, dynamic>>(
      url:
      '${ApiEndpoints.apiBaseUrl}/admin/users/${Uri.encodeComponent(userID)}/password',
      body: {
        'password': password,
      },
      parser: _mapParser,
    );
  }

  // =========================================================
  // UPDATE USER
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> updateUser({
    required String userID,
    required Map<String, dynamic> changes,
  }) {
    return ApiClient.patch<Map<String, dynamic>>(
      url:
      '${ApiEndpoints.apiBaseUrl}/admin/users/${Uri.encodeComponent(userID)}',
      body: changes,
      parser: _mapParser,
    );
  }

  // =========================================================
  // DELETE USER
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> deleteUser({
    required String userID,
  }) {
    return ApiClient.delete<Map<String, dynamic>>(
      url:
      '${ApiEndpoints.apiBaseUrl}/admin/users/${Uri.encodeComponent(userID)}',
      parser: _mapParser,
    );
  }

  // =========================================================
  // COMMON MAP PARSER
  // =========================================================

  static Map<String, dynamic> _mapParser(
      dynamic data,
      ) {
    if (data is Map<String, dynamic>) {
      return data;
    }

    if (data is Map) {
      return Map<String, dynamic>.from(
        data,
      );
    }

    return <String, dynamic>{};
  }
}