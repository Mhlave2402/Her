class DriverBehaviorModel {
  final String type;
  final double value;
  final DateTime timestamp;

  DriverBehaviorModel({
    required this.type,
    required this.value,
    required this.timestamp,
  });

  factory DriverBehaviorModel.fromJson(Map<String, dynamic> json) {
    return DriverBehaviorModel(
      type: json['type'],
      value: json['value'].toDouble(),
      timestamp: DateTime.parse(json['created_at']),
    );
  }
}
