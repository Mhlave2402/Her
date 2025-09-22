import 'package:image_picker/image_picker.dart';
import 'package:her_driver_app/data/api_client.dart';
import 'package:her_driver_app/features/auth/domain/models/signup_body.dart';

abstract class AuthServiceInterface {
  Future<dynamic> login({required String phone, required String password});
  Future<dynamic> logOut();
  Future<dynamic> registration({required SignUpBody signUpBody, XFile? profileImage, List<MultipartBody>? identityImage, List<MultipartDocument>? documents});
  Future<dynamic> sendOtp({required String phone});
  Future<dynamic> verifyOtp({required String phone, required String otp});
  Future<dynamic> verifyFirebaseOtp({required String phone, required String otp, required String session});
  Future<dynamic> resetPassword(String phoneOrEmail, String password);
  Future<dynamic> changePassword(String oldPassword, String password);
  Future<dynamic> updateToken();
  Future<dynamic> forgetPassword(String? phone);
  Future<dynamic> verifyPhone(String phone, String otp);
  Future<bool?> saveUserToken(String token, String zoneId);
  Future<String> getUserToken();
  Future<bool> isLoggedIn();
  Future<void> clearSharedData();
  Future<void> saveUserCredential(String code, String number, String password);
  Future<void> saveDeviceToken();
  Future<String> getDeviceToken();
  Future<String> getUserNumber();
  Future<String> getUserCountryCode();
  Future<String> getUserPassword();
  Future<bool> isNotificationActive();
  toggleNotificationSound(bool isNotification);
  Future<void> clearUserCredentials();
  Future<void> clearSharedAddress();
  Future<String> getZonId();
  Future<void> updateZone(String zoneId);
  Future<dynamic> permanentDelete();
  Future<dynamic> saveRideCreatedTime(DateTime dateTime);
  Future<dynamic> remainingTime();
  Future<String> getLoginCountryCode();
  Future<dynamic> isUserRegistered({required String phone});
}
