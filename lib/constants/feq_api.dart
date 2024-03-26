import 'dart:convert';
import 'package:http/http.dart' as http;

class FeqApi {
  Future<void> FeqPush(
    String left_ear_problem,
    String left_ear_fixed,
    String medical_details_id,
    String test_type_id,
    String right_ear_problem,
    String right_ear_fixed,
  ) async {
    try {
      Uri url = Uri.parse('https://qbacp.com/mediclear/api/hearingdata');

      Map<String, dynamic> requestBody = {
        'left_ear_problem': left_ear_problem,
        'left_ear_fixed': left_ear_fixed,
        'medical_details_id': medical_details_id,
        'test_type_id': test_type_id,
        'right_ear_problem': right_ear_problem,
        'right_ear_fixed': right_ear_fixed,
      };

      http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      print('Response: ${response.body}');

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        String status = jsonResponse['status'];

        if (status == 'success') {
          print('Feq Push successful!');
        } else {
          print('Push failed. Message: ${jsonResponse['message']}');
        }
      } else if (response.statusCode == 404) {
        print('404 error message=> ${response.body}');
      } else {
        print('Failed to Push. Status code: ${response.statusCode}');
        print('Error message: ${response.body}');
      }
    } catch (e) {
      print('Error during API call: $e');
    }
  }
}
