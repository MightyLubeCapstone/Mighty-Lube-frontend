import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../env.dart';

class AdminApiException implements Exception {
  const AdminApiException(this.message, this.statusCode);

  final String message;
  final int statusCode;
  bool get unauthorized => statusCode == 401;
  bool get forbidden => statusCode == 403;

  @override
  String toString() => message;
}

class ConfigurationSummary {
  const ConfigurationSummary({
    this.total = 0,
    this.requested = 0,
    this.pending = 0,
    this.done = 0,
  });

  final int total;
  final int requested;
  final int pending;
  final int done;

  factory ConfigurationSummary.fromJson(Map<String, dynamic> json) =>
      ConfigurationSummary(
        total: _asInt(json['total']),
        requested: _asInt(json['requested']),
        pending: _asInt(json['pending']),
        done: _asInt(json['done']),
      );
}

class AdminConfigurations {
  const AdminConfigurations({required this.summary, required this.data});
  final ConfigurationSummary summary;
  final List<AdminConfiguration> data;
}

class AdminConfiguration {
  AdminConfiguration({
    required this.id,
    required this.name,
    required this.status,
    required this.dateOrdered,
    required this.completeDate,
    required this.cart,
  });

  final String id;
  final String name;
  String status;
  final DateTime? dateOrdered;
  final DateTime? completeDate;
  final List<Map<String, dynamic>> cart;

  factory AdminConfiguration.fromJson(Map<String, dynamic> json) {
    final rawCart = json['cart'];
    return AdminConfiguration(
      id: json['_id']?.toString() ?? '',
      name: json['configurationName']?.toString() ?? 'Unnamed configuration',
      status: _normalizedStatus(json['status'] ?? json['orderStatus']),
      dateOrdered: DateTime.tryParse(json['dateOrdered']?.toString() ?? ''),
      completeDate: DateTime.tryParse(json['completeDate']?.toString() ?? ''),
      cart: rawCart is List
          ? rawCart
              .whereType<Map>()
              .map((item) => Map<String, dynamic>.from(item))
              .toList()
          : const [],
    );
  }
}

class AdminUser {
  AdminUser({
    required this.id,
    required this.userID,
    required this.username,
    required this.role,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.company,
    required this.country,
  });

  final String id;
  final String userID;
  final String username;
  String role;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String company;
  final String country;

  String get name {
    final value = '$firstName $lastName'.trim();
    return value.isEmpty ? '—' : value;
  }

  factory AdminUser.fromJson(Map<String, dynamic> json) => AdminUser(
        id: json['_id']?.toString() ?? '',
        userID: json['userID']?.toString() ?? '',
        username: json['username']?.toString() ?? '—',
        role: json['role']?.toString().toLowerCase() ?? 'user',
        firstName: json['firstName']?.toString() ?? '',
        lastName: json['lastName']?.toString() ?? '',
        email: json['email']?.toString() ?? '—',
        phone: json['phoneNumber']?.toString() ?? '—',
        company: json['companyName']?.toString() ?? '—',
        country: json['country']?.toString() ?? '—',
      );
}

class AdminAPI {
  Future<Map<String, String>> _headers() async {
    final prefs = await SharedPreferences.getInstance();
    final sessionID = prefs.getString('sessionID');
    if (sessionID == null || sessionID.isEmpty) {
      throw const AdminApiException('Your session is missing or expired.', 401);
    }
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $sessionID',
    };
  }

  Future<AdminConfigurations> getConfigurations() async {
    final response = await http.get(
      Uri.parse('$apiBaseUrl/admin/configurations'),
      headers: await _headers(),
    );
    final decoded = _decode(response);
    final summary = decoded['summary'];
    final data = decoded['data'];
    return AdminConfigurations(
      summary: ConfigurationSummary.fromJson(
          summary is Map ? Map<String, dynamic>.from(summary) : const {}),
      data: data is List
          ? data
              .whereType<Map>()
              .map((item) =>
                  AdminConfiguration.fromJson(Map<String, dynamic>.from(item)))
              .toList()
          : const [],
    );
  }

  Future<String> updateConfigurationStatus(String id, String status) async {
    final normalized = _normalizedStatus(status);
    if (!const {'requested', 'pending', 'done'}.contains(normalized)) {
      throw const AdminApiException('Invalid configuration status.', 400);
    }
    final response = await http.patch(
      Uri.parse(
          '$apiBaseUrl/admin/configurations/${Uri.encodeComponent(id)}/status'),
      headers: await _headers(),
      body: jsonEncode({'status': normalized}),
    );
    final decoded = _decode(response);
    final configuration = decoded['configuration'];
    final rawReturnedStatus = configuration is Map
        ? configuration['status'] ?? configuration['orderStatus']
        : null;
    final returnedStatus =
        rawReturnedStatus == null ? '' : _normalizedStatus(rawReturnedStatus);
    if (!const {'requested', 'pending', 'done'}.contains(returnedStatus)) {
      throw const AdminApiException(
          'The server returned an invalid configuration status.', 500);
    }
    return returnedStatus;
  }

  Future<void> updateConfiguration(
      String id, Map<String, dynamic> changes) async {
    final response = await http.patch(
      Uri.parse('$apiBaseUrl/admin/configurations/${Uri.encodeComponent(id)}'),
      headers: await _headers(),
      body: jsonEncode(changes),
    );
    _decode(response);
  }

  Future<void> deleteConfiguration(String id) async {
    final response = await http.delete(
      Uri.parse('$apiBaseUrl/admin/configurations/${Uri.encodeComponent(id)}'),
      headers: await _headers(),
    );
    _decode(response);
  }

  Future<List<AdminUser>> getUsers() async {
    final response = await http.get(
      Uri.parse('$apiBaseUrl/admin/users'),
      headers: await _headers(),
    );
    final decoded = _decode(response);
    final data = decoded['data'];
    return data is List
        ? data
            .whereType<Map>()
            .map((item) => AdminUser.fromJson(Map<String, dynamic>.from(item)))
            .toList()
        : const [];
  }

  Future<String> updateUserRole(String userID, String role) async {
    final normalized = role.toLowerCase();
    if (!const {'user', 'admin'}.contains(normalized)) {
      throw const AdminApiException('Invalid user role.', 400);
    }
    final response = await http.patch(
      Uri.parse('$apiBaseUrl/admin/users/${Uri.encodeComponent(userID)}/role'),
      headers: await _headers(),
      body: jsonEncode({'role': normalized}),
    );
    final decoded = _decode(response);
    final user = decoded['user'];
    final returnedRole =
        user is Map ? user['role']?.toString().trim().toLowerCase() : null;
    if (!const {'user', 'admin'}.contains(returnedRole)) {
      throw const AdminApiException(
          'The server returned an invalid user role.', 500);
    }
    return returnedRole!;
  }

  Future<void> resetUserPassword(String userID, String password) async {
    final response = await http.patch(
      Uri.parse(
          '$apiBaseUrl/admin/users/${Uri.encodeComponent(userID)}/password'),
      headers: await _headers(),
      body: jsonEncode({'password': password}),
    );
    _decode(response);
  }

  Future<void> updateUser(String userID, Map<String, dynamic> changes) async {
    final response = await http.patch(
      Uri.parse('$apiBaseUrl/admin/users/${Uri.encodeComponent(userID)}'),
      headers: await _headers(),
      body: jsonEncode(changes),
    );
    _decode(response);
  }

  Future<void> deleteUser(String userID) async {
    final response = await http.delete(
      Uri.parse('$apiBaseUrl/admin/users/${Uri.encodeComponent(userID)}'),
      headers: await _headers(),
    );
    _decode(response);
  }

  Map<String, dynamic> _decode(http.Response response) {
    dynamic decoded;
    try {
      decoded = response.body.isEmpty
          ? <String, dynamic>{}
          : jsonDecode(response.body);
    } catch (_) {
      decoded = <String, dynamic>{};
    }
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return decoded is Map ? Map<String, dynamic>.from(decoded) : {};
    }
    final backendMessage = decoded is Map
        ? decoded['message'] ?? decoded['error'] ?? decoded['details']
        : null;
    final fallback = switch (response.statusCode) {
      400 => 'The submitted value is invalid.',
      401 => 'Your session is missing or expired.',
      403 => 'This account does not have administrator access.',
      404 => 'The selected item no longer exists.',
      _ => response.statusCode >= 500
          ? 'A server error occurred. Please try again.'
          : 'The request could not be completed.',
    };
    throw AdminApiException(
        backendMessage?.toString() ?? fallback, response.statusCode);
  }
}

int _asInt(dynamic value) =>
    value is num ? value.toInt() : int.tryParse(value?.toString() ?? '') ?? 0;

String _normalizedStatus(dynamic value) {
  final status = value?.toString().trim().toLowerCase() ?? 'requested';
  return status == 'complete' ? 'done' : status;
}
