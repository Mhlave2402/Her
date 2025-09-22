class VehicleCategory {
  String? id;
  String? name;
  String? type;
  double? childFriendlyFee;

  VehicleCategory({this.id, this.name, this.type, this.childFriendlyFee});

  VehicleCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    childFriendlyFee = json['child_friendly_fee'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['child_friendly_fee'] = childFriendlyFee;
    return data;
  }
}
