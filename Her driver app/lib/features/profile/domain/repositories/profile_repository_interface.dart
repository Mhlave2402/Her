
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:her_driver_app/data/api_client.dart';
import 'package:her_driver_app/features/profile/domain/models/vehicle_body.dart';
import 'package:her_driver_app/interface/repository_interface.dart';

abstract class ProfileRepositoryInterface implements RepositoryInterface{

  Future<Response?> profileOnlineOffline();
  Future<Response?> getProfileInfo();
  Future<Response?> dailyLog();
  Future<Response?> getVehicleModelList(int offset);
  Future<Response?> getVehicleBrandList(int offset);
  Future<Response?> getCategoryList(int offset);
  Future<Response?> addNewVehicle(VehicleBody vehicleBody, List<MultipartDocument> file );
  Future<Response?> updateVehicle(VehicleBody vehicleBody,String driverId);
  Future<Response?> updateProfileInfo(
      String firstName, String lastname,String email,
      String identityType, String identityNumber,
      XFile? profile,List<MultipartBody>? identityImage,
      List<String> services,
      List<String> oldDocuments,
      List<MultipartDocument> newDocuments,
      bool isNanny,
      bool isKidsOnlyVerified,
      bool isChildFriendly,
      bool acceptsLowerTierRides,
      bool hasBabySeat,
      bool acceptsMaleCompanion
      );
  Future<Response> getProfileLevelInfo();
}
