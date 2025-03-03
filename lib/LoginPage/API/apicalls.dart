import 'package:http/http.dart' as http;
import 'package:mighty_lube/env.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class ApiState extends ChangeNotifier {
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
