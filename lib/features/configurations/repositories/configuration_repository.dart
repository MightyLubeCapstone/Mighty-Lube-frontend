import '../../../core/network/api_response.dart';
import '../../../core/network/services/configuration_api_service.dart';

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

  static Future<ApiResponse<bool>> finalize({
    required List<String> configurationIDs,
  }) async {
    return ConfigurationApiService.finalize(
      configurationIDs: configurationIDs,
    );
  }
}