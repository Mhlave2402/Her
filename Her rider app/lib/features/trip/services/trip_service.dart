import 'dart:convert';
import 'package:http/http.dart' as http;

class TripService {
  final String _baseUrl = 'YOUR_API_BASE_URL'; // Replace with your actual base URL

  Future<String> getSharingLink(String tripId) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/api/trip-requests/$tripId/share'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['sharing_link'];
    } else {
      throw Exception('Failed to get sharing link');
    }
  }
}
