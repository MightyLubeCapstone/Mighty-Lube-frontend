import '../../../core/network/api_response.dart';
import '../../../core/network/services/draft_api_service.dart';

class DraftRepository {
  DraftRepository._();

  // =========================================================
  // GET DRAFTS
  // =========================================================

  static Future<ApiResponse<List<dynamic>>> getDrafts() async {
    return DraftApiService.getDrafts();
  }

  // =========================================================
  // SAVE DRAFT
  //
  // Moves selected cart configurations into one draft.
  // =========================================================

  static Future<ApiResponse<bool>> saveDraft({
    required String draftTitle,
    required List<String> configurationIDs,
  }) async {
    return DraftApiService.saveDraft(
      draftTitle: draftTitle,
      configurationIDs: configurationIDs,
    );
  }

  // =========================================================
  // RESTORE DRAFT
  //
  // Moves all configurations in the draft back to cart.
  // =========================================================

  static Future<ApiResponse<bool>> restoreDraft({
    required String draftID,
  }) async {
    return DraftApiService.restoreDraft(
      draftID: draftID,
    );
  }

  // =========================================================
  // DELETE DRAFT
  //
  // Deletes the complete draft using draftID.
  // =========================================================

  static Future<ApiResponse<bool>> deleteDraft({
    required String draftID,
  }) async {
    return DraftApiService.deleteDraft(
      draftID: draftID,
    );
  }
}