import '../../../features/configurations/models/submitted_rfq.dart';
import '../api_client.dart';
import '../api_endpoints.dart';
import '../api_response.dart';

class ConfigurationApiService {
  ConfigurationApiService._();

  // =========================================================
  // GET CONFIGURATIONS
  //
  // OLD:
  // ConfigurationAPI.getConfigurations()
  //
  // GET /api/configurations
  //
  // Backend response:
  // {
  //   "configurations": [...]
  // }
  // =========================================================

  static Future<ApiResponse<List<dynamic>>> getConfigurations() async {
    return ApiClient.get<List<dynamic>>(
      url: ApiEndpoints.configurations,
      requiresAuth: true,
      parser: (data) {
        if (data is Map && data['configurations'] is List) {
          return List<dynamic>.from(data['configurations']);
        }

        if (data is List) {
          return List<dynamic>.from(data);
        }

        return <dynamic>[];
      },
    );
  }

  // =========================================================
  // FINALIZE CONFIGURATION
  //
  // OLD:
  // ConfigurationAPI.finalize(configurationName)
  //
  // STEP 1:
  // PUT /api/configurations
  //
  // STEP 2:
  // POST /api/email/send-email
  //
  // projectName:
  // null       -> standalone RFQs
  // "Ford ..." -> backend creates a new project (name must be
  //               unique per user, otherwise 409) and groups
  //               these RFQs under it.
  //
  // Backend returns each RFQ with its rfqNumber, plus the
  // project (projectNumber, projectName) when one was created.
  // =========================================================

  static Future<ApiResponse<FinalizeResult>> finalize({
    required List<String> configurationIDs,
    String? projectName,
  }) async {
    final trimmedProjectName = projectName?.trim() ?? '';

    final response = await ApiClient.put<dynamic>(
      url: ApiEndpoints.configurations,
      requiresAuth: true,
      body: {
        'configurationIDs': configurationIDs,
        if (trimmedProjectName.isNotEmpty)
          'projectName': trimmedProjectName,
      },
    );

    if (!response.success) {
      return ApiResponse<FinalizeResult>.failure(
        message:
        response.statusCode == 409
            ? (response.message ?? 'Project name already exists.')
            : response.message ??
            'Unable to finalize configuration.',
        statusCode: response.statusCode,
        errorCode: response.errorCode,
      );
    }

    return ApiResponse<FinalizeResult>.success(
      data: FinalizeResult.fromResponse(
        response.data,
      ),
      message:
      response.message ??
          'Configuration submitted successfully.',
      statusCode: response.statusCode,
    );
  }
}