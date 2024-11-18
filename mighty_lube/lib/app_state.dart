import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class ApiState extends ChangeNotifier {
  final String baseUrl = 'https://mighty-lube-backend.azurewebsites.net';

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(Uri.parse('$baseUrl/api/users'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${prefs.getString('sessionID')}',
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'password': password,
      'emailAddress': email,
      'phoneNumber': phoneNumber,
      'companyName': companyName,
      'country': country,
    });
    print(response.statusCode);
    print(username);
    print(password);

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //await prefs.setString('sessionID', responseData['sessionID']);
      //await prefs.setBool('isLoggedIn', true);

      return true;
    } else {
      print(response.statusCode);
      print(response.body);
      print('Account creation failed: ${response.body}');
      return false;
    }
  }

  Future<bool> loginUser(String username, String password) async {
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
      print('Logged in');
      return true;
    } else {
      print('not working');
      print(response.statusCode);
      print(response.body);
      return false;
    }
  }

  Future<void> logoutUser() async {
    // this isnt done yet
    final url = Uri.parse('$baseUrl/api/sessions');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('sessionID');
    try {
      final response = await http.delete(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
    } catch (error) {
      print("Error logging out: $error");
      error.toString();
    } finally {
      print(token);
      print('logged out');
      await prefs.remove('sessionID');
      await prefs.setBool('isLoggedIn', false);
    }
  }
}

/*
Future<void> getUser() async {
    final url = Uri.parse('$baseUrl/api/users');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('User: $data');
      } else {
        print('Failed to get user');
      }
    } catch (error) {
      print("Error getting user: $error");
    }
  }


Future<void> updateUser(String username, String password) async {
  final url = Uri.parse('');
  
  try {
    final response = await http.put(url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      print('User updated');
    } else {
      print('Failed to update user');
    }
  } catch (error) {
    print("Error updating user: $error");
  }
}

Future<void> deleteUser() async {
  final url = Uri.parse('');
  
  try {
    final response = await http.delete(url);
    if (response.statusCode == 204) {
      print('User deleted');
    } else {
      print('Failed to delete user');
    }
  } catch (error) {
    print("Error deleting user: $error");
  }
}

Future<void> addMachine(String name, String location) async {
  final url = Uri.parse('');
  
  try {
    final response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'location': location,
      }),
    );

    if (response.statusCode == 201) {
      print('Machine added');
    } else {
      print('Failed to add machine');
    }
  } catch (error) {
    print("Error adding machine: $error");
  }
}

Future<void> getMachines() async {
  final url = Uri.parse('');
  
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Machines: $data');
    } else {
      print('Failed to get machines');
    }
  } catch (error) {
    print("Error getting machines: $error");
  }
}

Future<void> updateMachine(String id, String name, String location) async {
  final url = Uri.parse('');
  
  try {
    final response = await http.put(url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'location': location,
      }),
    );

    if (response.statusCode == 200) {
      print('Machine updated');
    } else {
      print('Failed to update machine');
    }
  } catch (error) {
    print("Error updating machine: $error");
  }
}

Future<void> deleteMachine(String id) async {
  final url = Uri.parse('');
  
  try {
    final response = await http.delete(url);
    if (response.statusCode == 204) {
      print('Machine deleted');
    } else {
      print('Failed to delete machine');
    }
  } catch (error) {
    print("Error deleting machine: $error");
  }
}*/
