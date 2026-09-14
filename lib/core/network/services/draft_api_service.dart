import '../api_client.dart';
import '../api_endpoints.dart';
import '../api_response.dart';

class DraftApiService {
  DraftApiService._();

  // =========================================================
  // GET DRAFTS
  //
  // OLD:
  // DraftAPI.getDrafts()
  //
  // GET /api/drafts
  //
  // Backend response:
  //
  // {
  //   "success": true,
  //   "count": 1,
  //   "drafts": [...]
  // }
  // =========================================================

  static Future<ApiResponse<List<dynamic>>> getDrafts() async {
    return ApiClient.get<List<dynamic>>(
      url: '${ApiEndpoints.apiBaseUrl}/drafts',
      requiresAuth: true,
      parser: (data) {
        if (data is Map && data['drafts'] is List) {
          return List<dynamic>.from(data['drafts']);
        }

        if (data is List) {
          return List<dynamic>.from(data);
        }

        return <dynamic>[];
      },
    );
  }

  // =========================================================
  // SAVE DRAFT
  //
  // OLD:
  // DraftAPI.saveDraft(draftTitle)
  //
  // NEW:
  // PUT /api/drafts
  //
  // Body:
  //
  // {
  //   "draftTitle": "Factory Setup",
  //   "configurationIDs": [
  //     "id-1",
  //     "id-2"
  //   ]
  // }
  //
  // Backend:
  //
  // status:
  // cart -> draft
  //
  // Same draftID and draftTitle are assigned
  // to all selected configurations.
  // =========================================================

  static Future<ApiResponse<bool>> saveDraft({
    required String draftTitle,
    required List<String> configurationIDs,
  }) async {
    final response = await ApiClient.put<dynamic>(
      url: '${ApiEndpoints.apiBaseUrl}/drafts',
      requiresAuth: true,
      body: {
        'draftTitle': draftTitle,
        'configurationIDs': configurationIDs,
      },
    );

    if (!response.success) {
      return ApiResponse<bool>.failure(
        message:
        response.message ??
            'Unable to save draft.',
        statusCode: response.statusCode,
        data: false,
      );
    }

    return ApiResponse<bool>.success(
      data: true,
      message: response.message,
      statusCode: response.statusCode,
    );
  }

  // =========================================================
  // RESTORE DRAFT TO CART
  //
  // PUT /api/drafts/restore
  //
  // Body:
  //
  // {
  //   "draftID": "..."
  // }
  //
  // Backend:
  //
  // status:
  // draft -> cart
  //
  // draftID = null
  // draftTitle = null
  // =========================================================

  static Future<ApiResponse<bool>> restoreDraft({
    required String draftID,
  }) async {
    final response = await ApiClient.put<dynamic>(
      url: '${ApiEndpoints.apiBaseUrl}/drafts/restore',
      requiresAuth: true,
      body: {
        'draftID': draftID,
      },
    );

    if (!response.success) {
      return ApiResponse<bool>.failure(
        message:
        response.message ??
            'Unable to restore draft.',
        statusCode: response.statusCode,
        data: false,
      );
    }

    return ApiResponse<bool>.success(
      data: true,
      message: response.message,
      statusCode: response.statusCode,
    );
  }

  // =========================================================
  // DELETE DRAFT
  //
  // OLD:
  // DraftAPI.deleteDraft(cartID)
  //
  // NEW:
  // DELETE /api/drafts
  //
  // Body:
  //
  // {
  //   "draftID": "..."
  // }
  //
  // Deletes every ProductConfiguration belonging
  // to this draft for the logged-in user.
  // =========================================================

  static Future<ApiResponse<bool>> deleteDraft({
    required String draftID,
  }) async {
    final response = await ApiClient.delete<dynamic>(
      url: '${ApiEndpoints.apiBaseUrl}/drafts',
      requiresAuth: true,
      body: {
        'draftID': draftID,
      },
    );

    if (!response.success) {
      return ApiResponse<bool>.failure(
        message:
        response.message ?? 'Unable to delete draft.',
        statusCode: response.statusCode,
        data: false,
      );
    }

    return ApiResponse<bool>.success(
      data: true,
      message: response.message,
      statusCode: response.statusCode,
    );
  }
}