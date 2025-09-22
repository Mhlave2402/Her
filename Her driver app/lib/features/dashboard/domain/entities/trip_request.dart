class TripRequest {
  final String tripId;
  final String pickupLocation;
  final String dropoffLocation;
  final double pickupDistance;
  final double tripDistance;
  final int estimatedPickupTime;
  final String vehicleCategory;
  final double fare;
  final List<String> specialRequests;
  final double clientRating;
  final int countdownSeconds;
  final String? otp;

  TripRequest({
    required this.tripId,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.pickupDistance,
    required this.tripDistance,
    required this.estimatedPickupTime,
    required this.vehicleCategory,
    required this.fare,
    required this.specialRequests,
    required this.clientRating,
    required this.countdownSeconds,
    this.otp,
  });

  factory TripRequest.fromJson(Map<String, dynamic> json) {
    return TripRequest(
      tripId: json['trip_id'],
      pickupLocation: json['pickup_location']['address'],
      dropoffLocation: json['dropoff_location']['address'],
      pickupDistance: (json['pickup_distance_km'] as num).toDouble(),
      tripDistance: (json['trip_distance_km'] as num).toDouble(),
      estimatedPickupTime: (json['estimated_time_to_pickup'] as num).toInt(),
      vehicleCategory: json['vehicle_category'],
      fare: (json['fare_amount'] as num).toDouble(),
      specialRequests: List<String>.from(json['special_requests'] ?? []),
      clientRating: (json['client_rating'] as num?)?.toDouble() ?? 0.0,
      countdownSeconds: (json['countdown_seconds'] as num).toInt(),
      otp: json['otp'],
    );
  }
}
