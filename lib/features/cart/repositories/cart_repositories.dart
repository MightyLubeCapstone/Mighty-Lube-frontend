import '../../../../core/network/api_response.dart';
import '../../../../core/network/services/cart_api_service.dart';

class CartRepository {
  CartRepository._();

  // =========================================================
  // GET ALL CART CONFIGURATIONS
  // =========================================================

  static Future<ApiResponse<List<dynamic>>> getOrders() async {
    return CartApiService.getOrders();
  }

  // =========================================================
  // GET SINGLE CART CONFIGURATION
  // =========================================================

  static Future<ApiResponse<dynamic>> getOrder({
    required dynamic configurationID,
  }) async {
    return CartApiService.getOrder(
      configurationID: configurationID,
    );
  }

  // =========================================================
  // UPDATE CART CONFIGURATION
  // =========================================================

  static Future<ApiResponse<bool>> updateOrder({
    required dynamic configurationID,
    required Map<String, dynamic> newData,
    required int numRequested,
  }) async {
    return CartApiService.updateOrder(
      configurationID: configurationID,
      newData: newData,
      numRequested: numRequested,
    );
  }

  // =========================================================
  // DELETE CART CONFIGURATION
  // =========================================================

  static Future<ApiResponse<bool>> deleteOrder({
    required dynamic configurationID,
  }) async {
    return CartApiService.deleteOrder(
      configurationID: configurationID,
    );
  }
}