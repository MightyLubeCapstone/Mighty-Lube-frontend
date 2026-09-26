import 'package:image_picker/image_picker.dart';

import '../api_client.dart';
import '../api_endpoints.dart';
import '../api_response.dart';

class ImageUploadService {
  ImageUploadService._();

  // =========================================================
  // UPLOAD IMAGE
  //
  // Uploads a customer-selected image to the backend.
  //
  // Along with the image, projectKey is sent so the backend
  // can create a readable object-storage folder:
  //
  // product-configurations/
  //   H102-CC5_CL/
  //     <uuid>.jpg
  //
  // The backend returns permanent file metadata such as:
  //
  // {
  //   "objectKey": "...",
  //   "originalName": "...",
  //   "contentType": "...",
  //   "size": 12345
  // }
  //
  // We store this metadata in ProductConfiguration.
  // We do NOT store the local device image path.
  // =========================================================

  static Future<ApiResponse<Map<String, dynamic>>> uploadImage(
      XFile image, {
        required String projectKey,
      }) {
    return ApiClient.postMultipart<Map<String, dynamic>>(
      url: ApiEndpoints.uploadImage,
      filePath: image.path,

      // Must match backend:
      // upload.single("image")
      fileField: 'image',

      // Additional multipart data used by backend
      // to build the storage folder.
      fields: {
        'projectKey': projectKey,
      },

      parser: _mapParser,
    );
  }

  // =========================================================
  // RESPONSE PARSER
  // =========================================================

  static Map<String, dynamic> _mapParser(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data;
    }

    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }

    return <String, dynamic>{};
  }
}