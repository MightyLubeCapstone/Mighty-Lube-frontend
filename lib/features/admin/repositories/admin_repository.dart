import '../../../core/network/api_response.dart';
import '../../../core/network/services/admin_api_service.dart';
import '../models/admin_models.dart';

class AdminRepository {
  AdminRepository._();

  // =========================================================
  // CONFIGURATIONS
  // =========================================================

  static Future<ApiResponse<AdminConfigurationListResponse>>
  getConfigurations({
    AdminConfigurationFilters filters = const AdminConfigurationFilters(),
  }) {
    return AdminApiService.getConfigurations(
      filters: filters,
    );
  }


  // =========================================================
  // GET CONFIGURATION IMAGE SIGNED URL
  //
  // Returns temporary signed URL metadata for an image
  // stored inside configurationData.
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>>
  getConfigurationImageUrl({
    required String configurationID,
    required String imageKey,
  }) {
    return AdminApiService.getConfigurationImageUrl(
      configurationID: configurationID,
      imageKey: imageKey,
    );
  }

  static Future<ApiResponse<AdminConfiguration>> getConfiguration({
    required String configurationID,
  }) {
    return AdminApiService.getConfiguration(
      configurationID: configurationID,
    );
  }

  static Future<ApiResponse<Map<String, dynamic>>> updateConfiguration({
    required String configurationID,
    required Map<String, dynamic> changes,
  }) {
    return AdminApiService.updateConfiguration(
      configurationID: configurationID,
      changes: changes,
    );
  }

  // =========================================================
  // UPDATE ADMIN WORKFLOW STATUS
  //
  // IMPORTANT:
  //
  // This updates adminStatus only.
  //
  // Flutter/domain name:
  //
  // adminWorkflowStatus
  //
  // Backend field:
  //
  // adminStatus
  //
  // Allowed values:
  //
  // requested
  // pending
  // done
  //
  // Configuration lifecycle status remains:
  //
  // submitted
  //
  // Example:
  //
  // configurationStatus = submitted
  // adminWorkflowStatus = pending
  // =========================================================

  static Future<ApiResponse<AdminStatusUpdate>> updateAdminWorkflowStatus({
    required String configurationID,
    required String adminWorkflowStatus,
  }) {
    return AdminApiService.updateAdminWorkflowStatus(
      configurationID: configurationID,
      adminWorkflowStatus: adminWorkflowStatus,
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
  // Remove this compatibility method after all callers have
  // been migrated.
  // =========================================================

  static Future<ApiResponse<AdminStatusUpdate>> updateConfigurationStatus({
    required String configurationID,
    required String status,
  }) {
    return updateAdminWorkflowStatus(
      configurationID: configurationID,
      adminWorkflowStatus: status,
    );
  }

  static Future<ApiResponse<Map<String, dynamic>>> deleteConfiguration({
    required String configurationID,
  }) {
    return AdminApiService.deleteConfiguration(
      configurationID: configurationID,
    );
  }

  // =========================================================
  // USERS
  // =========================================================

  static Future<ApiResponse<List<AdminUser>>> getUsers({
    AdminConfigurationFilters filters = const AdminConfigurationFilters(),
  }) {
    return AdminApiService.getUsers(
      filters: filters,
    );
  }

  static Future<ApiResponse<String>> updateUserRole({
    required String userID,
    required String role,
  }) {
    return AdminApiService.updateUserRole(
      userID: userID,
      role: role,
    );
  }

  static Future<ApiResponse<Map<String, dynamic>>> resetUserPassword({
    required String userID,
    required String password,
  }) {
    return AdminApiService.resetUserPassword(
      userID: userID,
      password: password,
    );
  }

  // =========================================================
  // UPDATE USER
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> updateUser({
    required String userID,
    required Map<String, dynamic> changes,
  }) {
    return AdminApiService.updateUser(
      userID: userID,
      changes: changes,
    );
  }

  // =========================================================
  // DELETE USER
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> deleteUser({
    required String userID,
  }) {
    return AdminApiService.deleteUser(
      userID: userID,
    );
  }

  // =========================================================
  // ACTIVITY LOGS
  //
  // Set useMockActivityLogs = true to test the drawer
  // with dummy data when the backend is not running.
  // =========================================================

  static const bool useMockActivityLogs = false;

  static Future<ApiResponse<ActivityLogListResponse>> getActivityLogs({
    ActivityLogFilters filters = const ActivityLogFilters(),
  }) {
    if (useMockActivityLogs) {
      return _mockActivityLogs(filters);
    }

    return AdminApiService.getActivityLogs(
      filters: filters,
    );
  }

  static Future<ApiResponse<ActivityLogListResponse>> _mockActivityLogs(
      ActivityLogFilters filters,
      ) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 400),
    );

    const samples = [
      ['AUTH', 'LOGIN', 'Logged in', null],
      ['CONFIGURATION', 'CONFIG_STATUS_CHANGED', 'Changed status Pending → Approved', 'RFQ-0012'],
      ['USER', 'USER_ROLE_CHANGED', 'Changed role User → Admin', 'john@example.com'],
      ['RFQ', 'RFQ_PDF_EXPORTED', 'Exported RFQ PDF', 'RFQ-0009'],
      ['CONFIGURATION', 'CONFIG_CREATED', 'Created configuration', 'RFQ-0015'],
      ['AUTH', 'PASSWORD_RESET', 'Reset password via email OTP', null],
    ];

    final now = DateTime.now();

    final all = List.generate(95, (i) {
      final sample = samples[i % samples.length];

      return ActivityLog(
        id: 'mock-$i',
        createdAt: now.subtract(Duration(minutes: i * 47)),
        entityType: sample[0]!,
        action: sample[1]!,
        message: sample[2]!,
        entityLabel: sample[3],
        actorName: i.isEven ? 'Admin User' : 'Rahul Sharma',
        actorRole: i.isEven ? 'Admin' : 'User',
        metadata: sample[1] == 'CONFIG_STATUS_CHANGED'
            ? const {'before': 'Pending', 'after': 'Approved'}
            : const <String, dynamic>{},
        ipAddress: '192.168.1.${i % 255}',
      );
    }).where((log) {
      final search = filters.search.trim().toLowerCase();

      return (filters.entityType == null ||
          log.entityType == filters.entityType) &&
          (filters.from == null ||
              !log.createdAt!.isBefore(filters.from!)) &&
          (search.isEmpty ||
              '${log.message} ${log.actorDisplay} ${log.entityLabel ?? ''}'
                  .toLowerCase()
                  .contains(search));
    }).toList();

    final start = (filters.page - 1) * filters.limit;

    return ApiResponse.success(
      data: ActivityLogListResponse(
        data: all.skip(start).take(filters.limit).toList(),
        page: filters.page,
        limit: filters.limit,
        total: all.length,
      ),
    );
  }
}