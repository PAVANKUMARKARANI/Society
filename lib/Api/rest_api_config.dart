import 'dart:convert';
import 'package:http/http.dart' as http;

class RestApiService {
  static const String baseUrl = "https://jsonplaceholder.typicode.com";

  Future<List<dynamic>> fetchUsers() async {
    final response = await http.get(Uri.parse("$baseUrl/users"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to fetch users");
    }
  }
}
