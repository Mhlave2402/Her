import 'package:get/get.dart';
import 'package:her_user_app/features/auth/domain/models/error_response.dart';
import 'package:her_user_app/features/auth/screens/sign_in_screen.dart';
import 'package:her_user_app/features/splash/controllers/config_controller.dart';
import 'package:her_user_app/common_widgets/custom_snackbar.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if(response.statusCode == 401) {
      Get.find<ConfigController>().removeSharedData();
      Get.offAll(()=> const SignInScreen());

    }else if(response.statusCode == 403) {
      ErrorResponse errorResponse;
      errorResponse = ErrorResponse.fromJson(response.body);
      if(errorResponse.errors != null && errorResponse.errors!.isNotEmpty){
        customSnackBar(errorResponse.errors![0].message!);
      }else{
        customSnackBar(response.body['message']);
      }

    }else if(response.statusCode == 422) {
      ErrorResponse errorResponse;
      errorResponse = ErrorResponse.fromJson(response.body);
      if(errorResponse.errors != null && errorResponse.errors!.isNotEmpty){
        customSnackBar(errorResponse.errors![0].message!);
      }else{
        customSnackBar(response.body['message']);
      }

    }else if(response.statusCode == 500){
      customSnackBar(response.statusText!);
    }else {
      customSnackBar(response.statusText!);
    }
  }
}
