import '../../../core/network/api_response.dart';
import '../../../core/network/services/product_api_service.dart';

class ProductRepository {
  ProductRepository._();

  // =========================================================
  // ADD PRODUCT TO CONFIGURATOR
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> addToConfigurator({
    required String productId,
    required Map<String, dynamic> configuration,
    required int quantity,
  }) async {
    final response = await ProductApiService.addOrder(
      productId: productId,
      configuration: configuration,
      quantity: quantity,
    );

    if (!response.success) {
      return ApiResponse<Map<String, dynamic>>.failure(
        message: response.message ?? 'Unable to add product',
        statusCode: response.statusCode,
        data: response.data,
      );
    }

    return response;
  }

  // =========================================================
  // GET CONFIGURATOR / CART
  // =========================================================

  static Future<ApiResponse<List<dynamic>>> getOrders() async {
    final response = await ProductApiService.getOrders();

    if (!response.success) {
      return ApiResponse<List<dynamic>>.failure(
        message: response.message ?? 'Unable to load configurator',
        statusCode: response.statusCode,
        data: response.data,
      );
    }

    return response;
  }

  // =========================================================
  // GET USER ORDERS
  // =========================================================

  static Future<ApiResponse<List<dynamic>>> getUserOrders() async {
    final response = await ProductApiService.getUserOrders();

    if (!response.success) {
      return ApiResponse<List<dynamic>>.failure(
        message: response.message ?? 'Unable to load orders',
        statusCode: response.statusCode,
        data: response.data,
      );
    }

    return response;
  }

  // =========================================================
  // GET CONFIGURATIONS
  // =========================================================

  static Future<ApiResponse<List<dynamic>>> getConfigurations() async {
    final response = await ProductApiService.getConfigurations();

    if (!response.success) {
      return ApiResponse<List<dynamic>>.failure(
        message: response.message ?? 'Unable to load configurations',
        statusCode: response.statusCode,
        data: response.data,
      );
    }

    return response;
  }
}