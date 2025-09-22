class SplitPayment {
  final int id;
  final int tripId;
  final int userId;
  final int withUserId;
  final String status;

  SplitPayment({
    required this.id,
    required this.tripId,
    required this.userId,
    required this.withUserId,
    required this.status,
  });

  factory SplitPayment.fromJson(Map<String, dynamic> json) {
    return SplitPayment(
      id: json['id'],
      tripId: json['trip_id'],
      userId: json['user_id'],
      withUserId: json['with_user_id'],
      status: json['status'],
    );
  }
}
