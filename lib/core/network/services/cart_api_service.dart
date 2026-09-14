import '../api_client.dart';
import '../api_endpoints.dart';
import '../api_response.dart';

class CartApiService {
  CartApiService._();

  // =========================================================
  // GET ALL CART CONFIGURATIONS
  //
  // OLD:
  // CartAPI.getOrders()
  //
  // GET /api/cart
  //
  // Backend response:
  //
  // {
  //   "success": true,
  //   "count": 1,
  //   "cart": [
  //     {
  //       "configurationID": "...",
  //       "configurationName": "...",
  //       "productType": "...",
  //       "productName": "...",
  //       "quantity": 1,
  //       "status": "cart",
  //       "isComplete": true,
  //       "createdAt": "...",
  //       "updatedAt": "..."
  //     }
  //   ]
  // }
  // =========================================================

  static Future<ApiResponse<List<dynamic>>> getOrders() async {
    return ApiClient.get<List<dynamic>>(
      url: ApiEndpoints.cart,
      requiresAuth: true,
      parser: (data) {
        if (data is Map && data['cart'] is List) {
          return List<dynamic>.from(data['cart']);
        }

        if (data is List) {
          return List<dynamic>.from(data);
        }

        return <dynamic>[];
      },
    );
  }

  // =========================================================
  // GET SINGLE CART CONFIGURATION
  //
  // OLD:
  // CartAPI.getOrder(orderID)
  //
  // NEW:
  // GET /api/cart/order
  //
  // configurationID is passed through header.
  //
  // Backend response:
  //
  // {
  //   "success": true,
  //   "configuration": {
  //     "configurationID": "...",
  //     "configurationName": "...",
  //     "productType": "...",
  //     "productName": "...",
  //     "numRequested": 1,
  //     "status": "cart",
  //     "isComplete": true,
  //     "configurationData": {...},
  //     ...
  //   }
  // }
  // =========================================================

  static Future<ApiResponse<dynamic>> getOrder({
    required dynamic configurationID,
  }) async {
    return ApiClient.get<dynamic>(
      url: '${ApiEndpoints.cart}/order',
      requiresAuth: true,
      headers: {
        'configurationID': configurationID.toString(),
      },
      parser: (data) {
        if (data is Map && data.containsKey('configuration')) {
          return data['configuration'];
        }

        return data;
      },
    );
  }

  // =========================================================
  // UPDATE CART CONFIGURATION
  //
  // OLD:
  // CartAPI.updateOrder(
  //   orderID,
  //   newData,
  //   numRequestedValue,
  // )
  //
  // NEW:
  // PUT /api/cart/order
  //
  // Body:
  //
  // {
  //   "configurationID": "...",
  //   "data": {...},
  //   "numRequested": 2
  // }
  // =========================================================

  static Future<ApiResponse<bool>> updateOrder({
    required dynamic configurationID,
    required Map<String, dynamic> newData,
    required int numRequested,
  }) async {
    final response = await ApiClient.put<dynamic>(
      url: '${ApiEndpoints.cart}/order',
      requiresAuth: true,
      body: {
        'configurationID': configurationID,
        'data': newData,
        'numRequested': numRequested,
      },
    );

    if (!response.success) {
      return ApiResponse<bool>.failure(
        message:
        response.message ??
            'Unable to update cart configuration.',
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
  // DELETE CART CONFIGURATION
  //
  // OLD:
  // CartAPI.deleteOrder(orderID)
  //
  // NEW:
  // DELETE /api/cart/order
  //
  // Body:
  //
  // {
  //   "configurationID": "..."
  // }
  // =========================================================

  static Future<ApiResponse<bool>> deleteOrder({
    required dynamic configurationID,
  }) async {
    final response = await ApiClient.delete<dynamic>(
      url: '${ApiEndpoints.cart}/order',
      requiresAuth: true,
      body: {
        'configurationID': configurationID,
      },
    );

    if (!response.success) {
      return ApiResponse<bool>.failure(
        message:
        response.message ??
            'Unable to delete cart configuration.',
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