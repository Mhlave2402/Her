import 'package:her_user_app/features/ride/domain/models/premium_feature_model.dart';

class RideDetails {
  final Driver? driver;
  final Vehicle? vehicle;
  final VehicleCategory? vehicleCategory;
  final List<PremiumFeature>? premiumFeatures;
  final String? verificationCode;

  RideDetails({
    this.driver,
    this.vehicle,
    this.vehicleCategory,
    this.premiumFeatures,
    this.verificationCode,
  });
}

class Driver {
  final String? profileImage;
  final String? firstName;
  final String? lastName;
  final double? avgRating;
  final bool? isVerified;

  Driver({
    this.profileImage,
    this.firstName,
    this.lastName,
    this.avgRating,
    this.isVerified,
  });
}

class Vehicle {
  final Model? model;
  final String? color;
  final String? licencePlateNumber;

  Vehicle({
    this.model,
    this.color,
    this.licencePlateNumber,
  });
}

class Model {
  final String? name;

  Model({this.name});
}

class VehicleCategory {
  final String? name;

  VehicleCategory({this.name});
}
