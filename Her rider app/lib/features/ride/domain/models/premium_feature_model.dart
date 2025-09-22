class PremiumFeature {
  final int id;
  final String name;
  final String iconUrl;
  final double surcharge;

  PremiumFeature({
    required this.id,
    required this.name,
    required this.iconUrl,
    required this.surcharge,
  });

  factory PremiumFeature.fromJson(Map<String, dynamic> json) {
    return PremiumFeature(
      id: json['id'],
      name: json['name'],
      iconUrl: json['icon_url'],
      surcharge: json['surcharge'].toDouble(),
    );
  }
}
