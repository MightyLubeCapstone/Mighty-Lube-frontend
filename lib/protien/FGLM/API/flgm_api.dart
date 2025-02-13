import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../env.dart';

class FormAPI {
  // untested :.(
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

  Future<bool> addFglm(dynamic fglmData) async {
    try {
      final url = Uri.parse('$baseUrl/api/fglm');
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('sessionID')}',
        },
        body: jsonEncode({'fglmData': fglmData}),
      );

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
