import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'env.dart';

class UserAPI {
  Future<bool> checkSession() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final sessionID = prefs.getString("sessionID");
      if (sessionID == null) {
        return false;
      }
      final uri = Uri.parse("$baseUrl/api/sessions");
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $sessionID',
      };
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        return true;
      } else {
        prefs.remove("sessionID");
        return false;
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      return false;
    }
  }

  Future<bool> makeAccount(
    String username,
    String password,
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
    String companyName,
    String country,
  ) async {
    try {
      final response = await http.post(Uri.parse('$baseUrl/api/users'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'username': username,
            'password': password,
            'firstName': firstName,
            'lastName': lastName,
            'emailAddress': email,
            'phoneNumber': phoneNumber,
            'companyName': companyName,
            'country': country,
          }));

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('sessionID', responseData['sessionID']);

        return true;
      } else {
        if (kDebugMode) {
          print('Account creation failed: ${response.body}');
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<bool> forgotPassword(String email) async {
    try {
      final url = Uri.parse("$baseUrl/api/email/forgot");
      final headers = {
        "Content-Type": "application/json",
      };
      final body = jsonEncode({
        "email": email,
      });
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      return false;
    }
  }

  Future<bool> validateCode(String email, String passcode) async {
    try {
      final url = Uri.parse("$baseUrl/api/email/forgot");
      final headers = {
        "Content-Type": "application/json",
        "email": email,
        "passcode": passcode,
      };
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      return false;
    }
  }

  Future<bool> resetPassword(String email, String password) async {
    try {
      final url = Uri.parse("$baseUrl/api/email/forgot");
      final headers = {
        "Content-Type": "application/json",
        "email": email,
        "password": password,
      };
      final response = await http.put(url, headers: headers);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      return false;
    }
  }

  Future<bool> loginUser(String username, String password) async {
    try {
      final url = Uri.parse('$baseUrl/api/sessions');
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'username': username,
            'password': password,
          }));
      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('sessionID', responseData['sessionID']);
        return true;
      } else {
        if (kDebugMode) {
          print(response.body);
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<bool> logoutUser() async {
    // this isnt done yet
    try {
      final url = Uri.parse('$baseUrl/api/sessions');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('sessionID');
      if (token == null) {
        // send back to homepage with an error message
        return true;
      } else {
        final response = await http.delete(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );
        if (response.statusCode == 200) {
          // no error
          await prefs.remove('sessionID');
          return true;
        } else {
          await prefs.remove('sessionID');
          // error message, either way still going to send back to login screen
          return false;
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error logging out: ${error.toString()}");
      }
      return false;
    } finally {
      if (kDebugMode) {
        print('logged out');
      }
    }
  }

  Future<String> checkUser(String username) async {
    try {
      final url = Uri.parse('$baseUrl/api/users/username');
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'username': username,
      });

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['message'];
      } else if (response.statusCode == 400) {
        return 'Username already exists';
      } else {
        return 'Error: ${response.body}';
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error getting user: $error");
      }
      return 'Error';
    }
  }

  Future<dynamic> getUserInfo() async {
    try {
      final url = Uri.parse('$baseUrl/api/users/userinfo');
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final token = prefs.getString('sessionID');
      if (token == null) {
        return null;
      }

      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData;
      } else {
        return null;
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error getting user info: $error");
      }
      return null;
    }
  }
}

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
        if (kDebugMode) {
          print(responseData);
        }
        return true;
      } else {
        if (kDebugMode) {
          print('Failed to add order: ${response.body}');
        }
        return false;
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error adding order: $error");
      }
      return false;
    }
  }
}

class CartAPI {
  Future<dynamic> getOrders() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final uri = Uri.parse("$baseUrl/api/cart");
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
      if (kDebugMode) {
        print(error);
      }
      return [];
    }
  }

  Future<dynamic> getOrder(dynamic orderID) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final uri = Uri.parse("$baseUrl/api/cart/order");
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
      if (kDebugMode) {
        print(error);
      }
      return [];
    }
  }

  Future<bool> updateOrder(
      dynamic orderID, Map<String, dynamic> newData, int numRequestedValue) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final uri = Uri.parse("$baseUrl/api/cart/order");
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs.getString("sessionID")}",
      };
      final body = jsonEncode({
        "orderID": orderID,
        "data": newData,
        "numRequested": numRequestedValue,
      });
      final response = await http.put(uri, headers: headers, body: body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      return false;
    }
  }

  Future<bool> deleteOrder(dynamic orderID) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final uri = Uri.parse("$baseUrl/api/cart/order");
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
      if (kDebugMode) {
        print(error);
      }
      return false;
    }
  }

  Future<bool> restoreDraft(dynamic cartID) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final uri = Uri.parse("$baseUrl/api/cart");
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
      if (kDebugMode) {
        print(error);
      }
      return false;
    }
  }
}

class DraftAPI {
  Future<dynamic> getDrafts() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final uri = Uri.parse("$baseUrl/api/drafts");
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
      if (kDebugMode) {
        print(error);
      }
      return [];
    }
  }

  Future<bool> saveDraft(String draftTitle) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final uri = Uri.parse("$baseUrl/api/drafts");
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
      if (kDebugMode) {
        print(error);
      }
      return false;
    }
  }

  Future<bool> deleteDraft(dynamic cartID) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final uri = Uri.parse("$baseUrl/api/drafts");
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
      if (kDebugMode) {
        print(error);
      }
      return false;
    }
  }
}

class ConfigurationAPI {
  Future<dynamic> getConfigurations() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final uri = Uri.parse("$baseUrl/api/configurations");
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
      if (kDebugMode) {
        print(error);
      }
      return [];
    }
  }

  Future<bool> finalize(String configurationName) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final uri = Uri.parse("$baseUrl/api/configurations");
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${prefs.getString("sessionID")}",
      };
      final body = jsonEncode({
        "configurationName": configurationName,
      });
      final response = await http.put(uri, headers: headers, body: body);
      if (response.statusCode == 200) {
        // THEN send an email...
        try {
          final uri = Uri.parse("$baseUrl/api/email/send-email");
          final headers = {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${prefs.getString("sessionID")}",
          };
          final response = await http.post(uri, headers: headers, body: body);
          final data = jsonDecode(response.body);
          if (response.statusCode == 201) {
            return true;
          } else {
            if (kDebugMode) {
              print(data);
            }
          }
        } catch (error) {
          if (kDebugMode) {
            print(error);
          }
          return false;
        }
        return true;
      } else {
        return false;
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      return false;
    }
  }
}
