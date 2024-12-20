import 'package:flutter/material.dart';
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
      final response =
          await http.post(Uri.parse('$baseUrl/api/users'), headers: {
        'Content-Type': 'application/json',
        'firstName': firstName,
        'lastName': lastName,
        'username': username,
        'password': password,
        'emailAddress': email,
        'phoneNumber': phoneNumber,
        'companyName': companyName,
        'country': country,
      });

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('sessionID', responseData['sessionID']);
        await prefs.setBool('isLoggedIn', true); // we'll talk about this one

        return true;
      } else {
        print('Account creation failed: ${response.body}');
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> loginUser(String username, String password) async {
    try {
      final url = Uri.parse('$baseUrl/api/sessions');
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final response = await http.post(url, headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${prefs.getString('sessionID')}',
        'username': username,
        'password': password,
      });

      print(response.statusCode);
      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        print(responseData);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('sessionID', responseData['sessionID']);
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('currentUsername', username);

        return true;
      } else {
        print(response.body);
        return false;
      }
    } catch (e) {
      print(e);
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
      print("Error logging out: ${error.toString()}");
    } finally {
      print('logged out');
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

      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(responseData);
        return responseData['message'];
      } else if (response.statusCode == 400) {
        print('Failed to get user');
        return 'Username already exists';
      } else {
        print('Failed to get user');
        return 'Error: ${response.body}';
      }
    } catch (error) {
      print("Error getting user: $error");
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
        print(responseData);
        return {
          'firstName': responseData['firstName'],
          'lastName': responseData['lastName'],
        };
      } else {
        print('Failed to get user');
        return {'error': 'Error fetching user'};
      }
    } catch (error) {
      print("Error getting user: $error");
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
        print('No session ID found');
        return null;
      }

      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'username': username,
      });

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(responseData);
        return responseData;
      } else {
        print('Failed to get user info');
        return null;
      }
    } catch (error) {
      print("Error getting user info: $error");
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> getFglm() async {
    try {
      final url = Uri.parse('$baseUrl/api/fglm');
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${prefs.getString('sessionID')}',
      });

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['fglmEntries'] is List) {
          return List<Map<String, dynamic>>.from(responseData['fglmEntries']);
        } else {
          print('response here : $responseData');
          return null;
        }
      }
    } catch (error) {
      print("Error getting FGLM: $error");
      return null;
    }
    return null;
  }

  Future<bool> addFglm(Map<String, dynamic> fglmData) async {
    try {
      final url = Uri.parse('$baseUrl/api/fglm');
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final response = await http.post(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${prefs.getString('sessionID')}',
        'fglmData': jsonEncode(fglmData),
      });

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(responseData);
        return true;
      } else {
        print('Failed to add FGLM ${response.body}');
        return false;
      }
    } catch (error) {
      print("Error adding FGLM: $error");
      return false;
    }
  }
}
