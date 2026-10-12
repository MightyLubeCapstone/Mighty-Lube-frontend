
import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/network/api_response.dart';

/// Handles application version API requests.
///
/// Android/iOS:
/// - Check available updates.
/// - Fetch display-only version information.
///
/// Web:
/// - Fetch display-only version information.
///
/// These APIs are public and do not require authentication.
class AppVersionApiService {
  const AppVersionApiService();

  // =========================================================
  // CHECK APPLICATION VERSION
  // GET /api/app-version/check
  // =========================================================

  Future<ApiResponse<Map<String, dynamic>>> checkVersion({
    required String platform,
    required String installedVersion,
  }) async {
    final normalizedPlatform = platform.trim().toLowerCase();
    final normalizedVersion = installedVersion.trim();

    if (normalizedPlatform != 'android' &&
        normalizedPlatform != 'ios') {
      return ApiResponse<Map<String, dynamic>>.failure(
        message: 'Unsupported application platform.',
      );
    }

    final versionPattern = RegExp(r'^\d+(?:\.\d+){0,3}$');

    if (!versionPattern.hasMatch(normalizedVersion)) {
      return ApiResponse<Map<String, dynamic>>.failure(
        message: 'Invalid installed application version.',
      );
    }

    final url = Uri.parse(
      ApiEndpoints.appVersionCheck,
    ).replace(
      queryParameters: {
        'platform': normalizedPlatform,
        'version': normalizedVersion,
      },
    );

    return _getVersionResponse(url);
  }

  // =========================================================
  // GET DISPLAY VERSION
  // GET /api/app-version/display
  // =========================================================

  Future<ApiResponse<Map<String, dynamic>>> getDisplayVersion({
    required String platform,
  }) async {
    final normalizedPlatform = platform.trim().toLowerCase();

    if (normalizedPlatform != 'android' &&
        normalizedPlatform != 'ios' &&
        normalizedPlatform != 'web') {
      return ApiResponse<Map<String, dynamic>>.failure(
        message: 'Unsupported application platform.',
      );
    }

    final url = Uri.parse(
      ApiEndpoints.appVersionDisplay,
    ).replace(
      queryParameters: {
        'platform': normalizedPlatform,
      },
    );

    return _getVersionResponse(url);
  }

  // =========================================================
  // COMMON VERSION API REQUEST
  //
  // ApiResponseHandler passes the COMPLETE backend
  // response to custom parsers.
  //
  // Expected:
  // {
  //   "success": true,
  //   "message": "...",
  //   "data": {
  //     "latestVersion": "3.0.3",
  //     "updateEnabled": true
  //   }
  // }
  //
  // Extract only "data" for AppVersionModel.
  // =========================================================

  Future<ApiResponse<Map<String, dynamic>>> _getVersionResponse(
      Uri url,
      ) {
    return ApiClient.get<Map<String, dynamic>>(
      url: url.toString(),
      requiresAuth: false,
      parser: (dynamic response) {
        if (response is! Map) {
          throw const FormatException(
            'Invalid application version response.',
          );
        }

        final responseMap = Map<String, dynamic>.from(response);

        // Backend explicitly reported a failed request.
        if (responseMap['success'] == false) {
          throw FormatException(
            responseMap['message']?.toString() ??
                'Application version check failed.',
          );
        }

        // Extract nested version information.
        final dynamic data = responseMap['data'];

        if (data is! Map) {
          throw const FormatException(
            'Application version data is missing or invalid.',
          );
        }

        final versionData = Map<String, dynamic>.from(data);

        // Validate the essential version fields.
        if (versionData['platform'] is! String ||
            versionData['backendVersion'] is! String) {
          throw const FormatException(
            'Application version information is incomplete.',
          );
        }

        return versionData;
      },
    );
  }
}
