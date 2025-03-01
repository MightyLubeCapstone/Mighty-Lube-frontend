import 'dart:convert';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'env.dart';

class FormAPI {
  Future<bool> addOrder(String endpoint, dynamic order, int numRequested) async {
    try {
      final url = Uri.parse('$baseUrl/api/$endpoint');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('sessionID')}',
        },
        body: jsonEncode({'${endpoint}Data': order, 'numRequested': numRequested}),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(responseData);
        return true;
      } else {
        print('Failed to add order: ${response.body}');
        return false;
      }
    } catch (error) {
      print("Error adding order: $error");
      return false;
    }
  }

  Future<dynamic> getOrders() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final uri = Uri.parse("$baseUrl/api/orders");
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs.getString("sessionID")}",
      };
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        return data["orders"];
      } else if (response.statusCode == 400) {
        return [];
      } else {
        return [];
      }
    } catch (error) {
      print(error);
      return [];
    }
  }

  Future<dynamic> getDrafts() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final uri = Uri.parse("$baseUrl/api/orders/saved");
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs.getString("sessionID")}",
      };
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        return data["drafts"];
      } else if (response.statusCode == 400) {
        return [];
      } else {
        return [];
      }
    } catch (error) {
      print(error);
      return [];
    }
  }

  Future<dynamic> getConfigurations() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final uri = Uri.parse("$baseUrl/api/orders/configurations");
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs.getString("sessionID")}",
      };
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        return data["configurations"];
      } else if (response.statusCode == 400) {
        return [];
      } else {
        return [];
      }
    } catch (error) {
      print(error);
      return [];
    }
  }

  Future<dynamic> getOrder(dynamic orderID) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final uri = Uri.parse("$baseUrl/api/orders/order");
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs.getString("sessionID")}",
        "orderID": orderID.toString(),
      };
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        return data["orderInfo"];
      } else if (response.statusCode == 400) {
        return [];
      } else {
        return [];
      }
    } catch (error) {
      print(error);
      return [];
    }
  }

  Future<bool> updateOrder(dynamic orderID, Map<String, dynamic> newData) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final uri = Uri.parse("$baseUrl/api/orders/order");
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs.getString("sessionID")}",
      };
      final body = jsonEncode({
        "orderID": orderID,
        "data": newData,
      });
      final response = await http.put(uri, headers: headers, body: body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> deleteOrder(dynamic orderID) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final uri = Uri.parse("$baseUrl/api/orders/order");
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs.getString("sessionID")}",
      };
      final body = jsonEncode({
        "orderID": orderID,
      });
      final response = await http.delete(uri, headers: headers, body: body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> saveDraft(String draftTitle) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final uri = Uri.parse("$baseUrl/api/orders/save");
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs.getString("sessionID")}",
      };
      final body = jsonEncode({
        "draftTitle": draftTitle,
      });
      final response = await http.put(uri, headers: headers, body: body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> restoreDraft(dynamic cartID) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final uri = Uri.parse("$baseUrl/api/orders");
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs.getString("sessionID")}",
      };
      final body = jsonEncode({
        "cartID": cartID,
      });
      final response = await http.put(uri, headers: headers, body: body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> deleteDraft(dynamic cartID) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final uri = Uri.parse("$baseUrl/api/orders/saved");
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs.getString("sessionID")}",
      };
      final body = jsonEncode({
        "cartID": cartID,
      });
      final response = await http.delete(uri, headers: headers, body: body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> finalize(String configurationName) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final uri = Uri.parse("$baseUrl/api/orders/finalize");
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs.getString("sessionID")}",
      };
      final body = jsonEncode({
        "configurationName": configurationName,
      });
      final response = await http.put(uri, headers: headers, body: body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print(error);
      return false;
    }
  }
}
