class GiftCard {
  int? id;
  String? code;
  double? amount;
  String? userId;
  String? expiresAt;
  String? createdAt;
  String? updatedAt;

  GiftCard(
      {this.id,
      this.code,
      this.amount,
      this.userId,
      this.expiresAt,
      this.createdAt,
      this.updatedAt});

  GiftCard.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    amount = json['amount'].toDouble();
    userId = json['user_id'];
    expiresAt = json['expires_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['amount'] = amount;
    data['user_id'] = userId;
    data['expires_at'] = expiresAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
