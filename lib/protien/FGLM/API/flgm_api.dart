import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../env.dart';

class FormAPI {
  Future<bool> addFglm(dynamic fglmData, int numRequested) async {
    try {
      final url = Uri.parse('$baseUrl/api/fglm');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${prefs.getString('sessionID')}',
        },
        body: jsonEncode({'fglmData': fglmData, 'numRequested': numRequested}),
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
