import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:her_driver_app/helper/notification_helper.dart';
import 'package:her_driver_app/helper/responsive_helper.dart';
import 'package:her_driver_app/helper/di_container.dart' as di;
import 'package:her_driver_app/helper/route_helper.dart';
import 'package:her_driver_app/localization/localization_controller.dart';
import 'package:her_driver_app/localization/messages.dart';
import 'package:her_driver_app/theme/dark_theme.dart';
import 'package:her_driver_app/theme/light_theme.dart';
import 'package:her_driver_app/theme/theme_controller.dart';
import 'package:her_driver_app/util/app_constants.dart';
import 'package:her_driver_app/features/auth/id_verification_screen.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:her_driver_app/data/api_client.dart';
import 'package:her_driver_app/features/dashboard/screens/dashboard_screen.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  if(ResponsiveHelper.isMobilePhone) {
    HttpOverrides.global = MyHttpOverrides();
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();



  Map<String, Map<String, String>> languages = await di.init();
  final RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage();

  await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
  await FirebaseMessaging.instance.requestPermission();
  FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MyApp(languages: languages, notificationData: remoteMessage?.data));
}

Future<bool> _checkVerificationStatus() async {
  final ApiClient apiClient = Get.find<ApiClient>();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString(AppConstants.token);

  if (token == null) {
    return false;
  }

  final Response response = await apiClient.getData(AppConstants.identityVerificationStatus);

  if (response.statusCode == 200) {
    final bool isVerified = response.body['is_verified'];
    prefs.setBool('is_verified', isVerified);
    return isVerified;
  } else {
    return false;
  }
}

class MyApp extends StatefulWidget {
  final Map<String, Map<String, String>> languages;
  final Map<String,dynamic>? notificationData;
  const MyApp({super.key, required this.languages, this.notificationData});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isVerified = false;
  final LocalAuthentication _localAuth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    _checkVerification();
  }

  Future<void> _checkVerification() async {
    final isVerified = await _checkVerificationStatus();
    if (isVerified) {
      final canCheckBiometrics = await _localAuth.canCheckBiometrics;
      if (canCheckBiometrics) {
        final didAuthenticate = await _localAuth.authenticate(
          localizedReason: 'Please authenticate to continue',
        );
        if (didAuthenticate) {
          setState(() {
            _isVerified = true;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVerified) {
      return MaterialApp(
        home: IdVerificationScreen(),
      );
    }
    return GetBuilder<ThemeController>(builder: (themeController) {
      return GetBuilder<LocalizationController>(builder: (localizeController) {
        return SafeArea(
          top: false,
          child: GetMaterialApp(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            navigatorKey: Get.key,
            scrollBehavior: const MaterialScrollBehavior().copyWith(
              dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},),
            theme: themeController.darkTheme ? darkTheme : lightTheme,
            locale: localizeController.locale,
            initialRoute: RouteHelper.getSplashRoute(notificationData: widget.notificationData),
            getPages: RouteHelper.routes,
            translations: Messages(languages: widget.languages),
            fallbackLocale: Locale(AppConstants.languages[0].languageCode, AppConstants.languages[0].countryCode),
            defaultTransition: Transition.fadeIn,
            transitionDuration: const Duration(milliseconds: 500),
              builder:(context,child){
                return Stack(
                  children: [
                    MediaQuery(data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling), child: child!),
                  ],
                );
              }
          ),
        );
      });
    });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
