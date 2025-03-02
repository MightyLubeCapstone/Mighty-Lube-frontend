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
        await prefs.setBool('isLoggedIn', true); // we'll talk about this one
        await prefs.setString('currentUsername', username);

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
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('currentUsername', username);
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

  Future<void> logoutUser() async {
    // this isnt done yet
    try {
      final url = Uri.parse('$baseUrl/api/sessions');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('sessionID');
      if (token == null) {
        // send back to homepage with an error message
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
        } else {
          // error message, either way still going to send back to login screen
        }
        await prefs.remove('sessionID');
        await prefs.setBool('isLoggedIn', false); // will talk about this too
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error logging out: ${error.toString()}");
      }
    } finally {
      if (kDebugMode) {
        print('logged out');
      }
    }
  }

  Future<String> checkUser(String username) async {
    try {
      final url = Uri.parse('$baseUrl/api/users/username');
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${prefs.getString('sessionID')}',
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

  Future<Map<String, String>> getUser(String username) async {
    try {
      final url = Uri.parse('$baseUrl/api/users/userinfo');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      username = prefs.getString('currentUsername') ?? username;

      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${prefs.getString('sessionID')}',
        'username': username,
      });

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return {
          'firstName': responseData['firstName'],
          'lastName': responseData['lastName'],
        };
      } else {
        return {'error': 'Error fetching user'};
      }
    } catch (error) {
      if (kDebugMode) {
        print("Error getting user: $error");
      }
      return {'error': 'Server error'};
    }
  }

  Future<Map<String, dynamic>?> getUserInfo(String username) async {
    try {
      final url = Uri.parse('$baseUrl/api/users/userinfo');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      username = prefs.getString('currentUsername') ?? username;

      final token = prefs.getString('sessionID');
      if (token == null) {
        return null;
      }

      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'username': username,
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
