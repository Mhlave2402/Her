import 'package:http/http.dart' as http;

class LocationService {
  final String _baseUrl = 'YOUR_API_BASE_URL'; // Replace with your actual base URL

  Future<void> updateLocation(String tripId, double latitude, double longitude) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/api/trip-requests/$tripId/location'),
      body: {
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update location');
    }
  }
}
