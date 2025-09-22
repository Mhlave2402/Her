import 'package:http/http.dart' as http;
import 'dart:convert';

class TripService {
  final String baseUrl = 'http://localhost'; // Fetched from Laravel .env file

  Future<http.Response> inviteParticipant(String tripId, String userId, double sharePercentage, bool isPrimary) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/trip-payments/$tripId/participants'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer YOUR_AUTH_TOKEN'}, // Replace with actual token
      body: jsonEncode({
        'user_id': userId,
        'share_percentage': sharePercentage,
        'is_primary': isPrimary,
      }),
    );
    return response;
  }

  Future<http.Response> recordPayment(String tripId, String participantId, double amount, String paymentMethod) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/trip-payments/$tripId/payments'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer YOUR_AUTH_TOKEN'}, // Replace with actual token
      body: jsonEncode({
        'participant_id': participantId,
        'amount': amount,
        'payment_method': paymentMethod,
      }),
    );
    return response;
  }

  Future<http.Response> getPaymentStatus(String tripId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/trip-payments/$tripId/status'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer YOUR_AUTH_TOKEN'}, // Replace with actual token
    );
    return response;
  }

  Future<http.Response> updateWithMaleCompanion(String tripId, bool withMaleCompanion) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/trip-requests/$tripId/with-male-companion'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer YOUR_AUTH_TOKEN'}, // Replace with actual token
      body: jsonEncode({
        'with_male_companion': withMaleCompanion,
      }),
    );
    return response;
  }

  Future<http.Response> updateIsChildFriendly(String tripId, bool isChildFriendly) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/trip-requests/$tripId/is-child-friendly'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer YOUR_AUTH_TOKEN'}, // Replace with actual token
      body: jsonEncode({
        'is_child_friendly': isChildFriendly,
      }),
    );
    return response;
  }

  Future<http.Response> requestNannyRide(String tripId, bool isNannyRide) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/trip-requests/$tripId/request-nanny'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer YOUR_AUTH_TOKEN'}, // Replace with actual token
      body: jsonEncode({
        'is_nanny_ride': isNannyRide,
      }),
    );
    return response;
  }

  Future<http.Response> requestKidsOnlyRide(String tripId, bool isKidsOnlyRide) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/trip-requests/$tripId/request-kids-only'),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer YOUR_AUTH_TOKEN'}, // Replace with actual token
      body: jsonEncode({
        'is_kids_only_ride': isKidsOnlyRide,
      }),
    );
    return response;
  }
}
