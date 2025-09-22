xclass VehicleCategoryModel {
  final int id;
  final String name;
  final String icon;

  VehicleCategoryModel({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory VehicleCategoryModel.fromJson(Map<String, dynamic> json) {
    return VehicleCategoryModel(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
    );
  }
}