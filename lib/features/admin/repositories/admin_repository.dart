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

  static Future<ApiResponse<String>> updateAdminWorkflowStatus({
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

  static Future<ApiResponse<String>> updateConfigurationStatus({
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
}