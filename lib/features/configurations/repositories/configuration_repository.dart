import '../../../core/network/api_response.dart';
import '../../../core/network/services/configuration_api_service.dart';
import '../models/submitted_rfq.dart';

class ConfigurationRepository {
  ConfigurationRepository._();

  // =========================================================
  // GET CONFIGURATIONS
  // =========================================================

  static Future<ApiResponse<List<dynamic>>> getConfigurations() async {
    return ConfigurationApiService.getConfigurations();
  }

  // =========================================================
  // FINALIZE CONFIGURATION
  // =========================================================

  // projectName = null -> standalone RFQs.
  static Future<ApiResponse<FinalizeResult>> finalize({
    required List<String> configurationIDs,
    String? projectName,
  }) async {
    return ConfigurationApiService.finalize(
      configurationIDs: configurationIDs,
      projectName: projectName,
    );
  }
}