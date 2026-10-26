import '../../../features/configurations/models/customer_details.dart';
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
  // GET USER PROJECTS
  //
  // GET /api/configurations/projects
  //
  // Backend response:
  // {
  //   "data": [{ projectID, projectNumber, projectName }]
  // }
  // =========================================================

  static Future<ApiResponse<List<UserProject>>> getProjects() async {
    return ApiClient.get<List<UserProject>>(
      url: ApiEndpoints.configurationProjects,
      requiresAuth: true,
      parser: (data) {
        final items = data is Map ? data['data'] : data;

        if (items is! List) {
          return <UserProject>[];
        }

        return items
            .whereType<Map>()
            .map((item) => UserProject.fromJson(
          Map<String, dynamic>.from(item),
        ))
            .where((project) => project.projectID.isNotEmpty)
            .toList();
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
  // projectID:
  // "uuid"     -> attach these RFQs to the user's existing
  //               project (404 if it is not theirs).
  //
  // projectName:
  // null       -> standalone RFQs
  // "Ford ..." -> backend creates a new project (name must be
  //               unique per user, otherwise 409) and groups
  //               these RFQs under it.
  //
  // Send only one of the two.
  //
  // customerDetails:
  // required for standalone RFQs, a new project, and an
  // existing project that has none yet (backend saves it to
  // the project). Ignored for a project that has details.
  //
  // Backend returns each RFQ with its rfqNumber, plus the
  // project (projectNumber, projectName) when one was created.
  // =========================================================

  static Future<ApiResponse<FinalizeResult>> finalize({
    required List<String> configurationIDs,
    String? projectID,
    String? projectName,
    CustomerDetails? customerDetails,
  }) async {
    final trimmedProjectID = projectID?.trim() ?? '';
    final trimmedProjectName = projectName?.trim() ?? '';

    final response = await ApiClient.put<dynamic>(
      url: ApiEndpoints.configurations,
      requiresAuth: true,
      body: {
        'configurationIDs': configurationIDs,
        if (trimmedProjectID.isNotEmpty)
          'projectID': trimmedProjectID
        else if (trimmedProjectName.isNotEmpty)
          'projectName': trimmedProjectName,
        if (customerDetails != null)
          'customerDetails': customerDetails.toJson(),
      },
    );

    if (!response.success) {
      return ApiResponse<FinalizeResult>.failure(
        message:
        response.statusCode == 409
            ? (response.message ?? 'Project name already exists.')
            : response.statusCode == 404 && trimmedProjectID.isNotEmpty
            ? (response.message ?? 'Project not found.')
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