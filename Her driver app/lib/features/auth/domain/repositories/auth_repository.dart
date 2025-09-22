import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:her_driver_app/data/api_client.dart';
import 'package:her_driver_app/features/auth/domain/repositories/auth_repository_interface.dart';
import 'package:her_driver_app/util/app_constants.dart';
import 'package:her_driver_app/features/auth/domain/models/signup_body.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepository implements AuthRepositoryInterface {
  final ApiClient apiClient;
  final FlutterSecureStorage secureStorage;
  AuthRepository({required this.apiClient, required this.secureStorage});

  @override
  Future<Response?> login({required String phone, required String password}) async {
    return await apiClient.postData(AppConstants.loginUri,
        {"phone_or_email": phone,
          "password": password});
  }

  @override
  Future<Response?> logOut() async {
    return await apiClient.postData(AppConstants.logout, {});
  }

  @override
  Future<Response> registration({required SignUpBody signUpBody, XFile? profileImage, List<MultipartBody>? identityImage, List<MultipartDocument>? documents}) async {
    return await apiClient.postMultipartData(AppConstants.registration,
      signUpBody.toJson(),
      identityImage!,
      MultipartBody('profile_image', profileImage), documents ?? []);
  }


  @override
  Future<Response?> sendOtp({required String phone}) async {
    return await apiClient.postData(AppConstants.sendOtp,
        {"phone_or_email": phone});
  }

  @override
  Future<Response?> verifyOtp({required String phone, required String otp}) async {
    return await apiClient.postData(AppConstants.otpVerification,
        {"phone_or_email": phone,
          "otp": otp
        });
  }

  @override
  Future<Response?> verifyFirebaseOtp({required String phone, required String otp, required String session}) async {
    return await apiClient.postData(AppConstants.otpFirebaseVerification,
        {"phone_or_email": phone,
          "code": otp,
          "session_info": session
        });
  }

  @override
  Future<Response?> resetPassword(String phoneOrEmail, String password) async {
    return await apiClient.postData(AppConstants.resetPassword,
      { "phone_or_email": phoneOrEmail,
        "password": password,},
    );
  }

  @override
  Future<Response?> changePassword(String oldPassword, String password) async {
    return await apiClient.postData(AppConstants.changePassword,
      { "password": oldPassword,
        "new_password": password,
      },
    );
  }



  String? deviceToken;
  @override
  Future<Response?> updateToken() async {
    if (GetPlatform.isIOS) {
      FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
      NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
        alert: true, announcement: false, badge: true, carPlay: false,
        criticalAlert: false, provisional: false, sound: true,
      );
      if(settings.authorizationStatus == AuthorizationStatus.authorized) {
        deviceToken = await _saveDeviceToken();
      }
    }else {
      deviceToken = await _saveDeviceToken();
      saveDeviceToken();
    }
    if(!GetPlatform.isWeb){
      FirebaseMessaging.instance.subscribeToTopic(AppConstants.topic);
    }
    return await apiClient.postData(AppConstants.fcmTokenUpdate, {"_method": "put", "fcm_token": deviceToken});
  }

  Future<String?> _saveDeviceToken() async {
    String? deviceToken = '@';
    try {
      deviceToken = await FirebaseMessaging.instance.getToken();
    }catch(e) {
      debugPrint('');
    }
    if (deviceToken != null) {
      if (kDebugMode) {
        print('--------Device Token---------- $deviceToken');
      }
    }
    return deviceToken;
  }

  @override
  Future<Response?> forgetPassword(String? phone) async {
    return await apiClient.postData(AppConstants.configUri, {"phone_or_email": phone});
  }



  @override
  Future<Response?> verifyPhone(String phone, String otp) async {
    return await apiClient.postData(AppConstants.configUri, {"phone": phone, "otp": otp});
  }

  @override
  Future<bool?> saveUserToken(String token, String zoneId) async {
    apiClient.token = token;
    String? languageCode = await secureStorage.read(key: AppConstants.languageCode);
    apiClient.updateHeader(token, languageCode, "latitude", "longitude", zoneId);
    await secureStorage.write(key: AppConstants.token, value: token);
    return true;
  }

  @override
  Future<String> getUserToken() async {
    return await secureStorage.read(key: AppConstants.token) ?? "";
  }

  @override
  Future<bool> isLoggedIn() async {
    return await secureStorage.containsKey(key: AppConstants.token);
  }

  @override
  Future<void> clearSharedData() async {
    await secureStorage.delete(key: AppConstants.token);
  }

  @override
  Future<void> saveUserCredential(String code ,String number, String password) async {
    try {
      await secureStorage.write(key: AppConstants.userPassword, value: password);
      await secureStorage.write(key: AppConstants.userNumber, value: number);
      await secureStorage.write(key: AppConstants.loginCountryCode, value: code);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveDeviceToken() async {
    try {
      await secureStorage.write(key: AppConstants.deviceToken, value: deviceToken??'');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> getDeviceToken() async {
    return await secureStorage.read(key: AppConstants.deviceToken) ?? "";
  }
  
  @override
  Future<String> getUserNumber() async {
   return await secureStorage.read(key: AppConstants.userNumber) ?? "";
  }

  @override
  Future<String> getUserCountryCode() async {
   return await secureStorage.read(key: AppConstants.userCountryCode) ?? "";
  }

  @override
  Future<String> getUserPassword() async {
    return await secureStorage.read(key: AppConstants.userPassword) ?? "";
  }

  @override
  Future<bool> isNotificationActive() async {
    String? value = await secureStorage.read(key: AppConstants.notification);
    return value == 'true';
  }

  @override
  toggleNotificationSound(bool isNotification){
    secureStorage.write(key: AppConstants.notification, value: isNotification.toString());
  }

  @override
  Future<void> clearUserCredential() async {
    await secureStorage.delete(key: AppConstants.userPassword);
    await secureStorage.delete(key: AppConstants.userNumber);
  }

  @override
  Future<void> clearSharedAddress() async {
    await secureStorage.delete(key: AppConstants.userAddress);
  }
  
  @override
  Future<String> getZonId() async {
    return await secureStorage.read(key: AppConstants.zoneId) ?? "";
  }
  
  @override
  Future<void> updateZone(String zoneId) async {
    try {
      await secureStorage.write(key: AppConstants.zoneId, value: zoneId);
      String? token = await secureStorage.read(key: AppConstants.token);
      String? languageCode = await secureStorage.read(key: AppConstants.languageCode);
      apiClient.updateHeader(token??'', languageCode, 'latitude', 'longitude', zoneId);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future add(value) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future get(String id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future getList({int? offset = 1}) {
    // TODO: implement getList
    throw UnimplementedError();
  }

  @override
  Future update(Map<String, dynamic> body, int id) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<Response?> permanentDelete() async{
    return await apiClient.postData(AppConstants.permanentDelete, {});
  }

  @override
  Future<void> saveRideCreatedTime(DateTime dateTime) async {
     await secureStorage.write(key: 'DateTime', value: dateTime.toString());
  }

  @override
  Future<String> remainingTime() async{
    return  await secureStorage.read(key: 'DateTime') ?? '';
  }

  @override
  Future<String> getLoginCountryCode() async {
    return await secureStorage.read(key: AppConstants.loginCountryCode) ?? "";
  }
  @override
  Future<Response?> isUserRegistered({required String phone}) async {
    return await apiClient.postData(AppConstants.checkRegisteredUserUri,
        {"phone_or_email": phone});
  }

}
