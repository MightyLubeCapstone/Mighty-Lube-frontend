import '../../../core/network/api_response.dart';
import '../../../core/network/services/configuration_api_service.dart';
import '../models/customer_details.dart';
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

  // projectID   -> attach to an existing project.
  // projectName -> create a new project.
  // both null   -> standalone RFQs.
  static Future<ApiResponse<FinalizeResult>> finalize({
    required List<String> configurationIDs,
    String? projectID,
    String? projectName,
    CustomerDetails? customerDetails,
  }) async {
    return ConfigurationApiService.finalize(
      configurationIDs: configurationIDs,
      projectID: projectID,
      projectName: projectName,
      customerDetails: customerDetails,
    );
  }

  // =========================================================
  // GET USER PROJECTS
  // =========================================================

  static Future<ApiResponse<List<UserProject>>> getProjects() async {
    return ConfigurationApiService.getProjects();
  }

  // =========================================================
  // UPDATE PROJECT CUSTOMER DETAILS
  // =========================================================

  static Future<ApiResponse<CustomerDetails>> updateProjectDetails({
    required String projectID,
    required CustomerDetails details,
  }) async {
    return ConfigurationApiService.updateProjectDetails(
      projectID: projectID,
      details: details,
    );
  }
}