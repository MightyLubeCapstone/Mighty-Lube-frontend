import 'dart:convert';
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
}
