class GiftCard {
  final int id;
  final String code;
  final double amount;
  final String expiresAt;

  GiftCard({
    required this.id,
    required this.code,
    required this.amount,
    required this.expiresAt,
  });

  factory GiftCard.fromJson(Map<String, dynamic> json) {
    return GiftCard(
      id: json['id'],
      code: json['code'],
      amount: json['amount'].toDouble(),
      expiresAt: json['expires_at'],
    );
  }
}
