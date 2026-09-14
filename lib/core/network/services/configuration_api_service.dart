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
  // =========================================================

  static Future<ApiResponse<bool>> finalize({
    required List<String> configurationIDs,
  }) async {
    final response = await ApiClient.put<dynamic>(
      url: ApiEndpoints.configurations,
      requiresAuth: true,
      body: {
        'configurationIDs': configurationIDs,
      },
    );

    if (!response.success) {
      return ApiResponse<bool>.failure(
        message:
        response.message ??
            'Unable to finalize configuration.',
        statusCode: response.statusCode,
        data: false,
      );
    }

    return ApiResponse<bool>.success(
      data: true,
      message:
      response.message ??
          'Configuration submitted successfully.',
      statusCode: response.statusCode,
    );
  }
}