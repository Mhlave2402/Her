import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:her_user_app/features/ride/controllers/ride_controller.dart';
import 'package:her_user_app/util/app_constants.dart';
import 'package:http/http.dart' as http;

class NotificationHelper {

  static Future<void> initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = const AndroidInitializationSettings('notification_icon');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings = InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationsSettings, onDidReceiveNotificationResponse: (NotificationResponse response) async {
      try{
        if(response.payload!.isNotEmpty){
        }
      }catch (e){
        debugPrint(e.toString());
      }
      return;
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print("onMessage: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
        print("onMessage message type:${message.data['type']}");
      }
      if(message.data['type'] == 'message' && Get.currentRoute.startsWith('/chat-screen')){
        // if(Get.find<AuthController>().profileModel!.id.toString() == message.data['sender_id']){
        //   Get.find<ChatController>().getMessages(1, int.parse(message.data['conversation_id']), null, isFromNotification: true);
        // }else{
        //   showCustomNotification(message, flutterLocalNotificationsPlugin, false);
        // }
      }else if(message.data['type'] == 'message' && !Get.currentRoute.startsWith('/chat-screen')){
        showCustomNotification(message, flutterLocalNotificationsPlugin, false);
      }else if(message.data['type'] != 'message'){
        showCustomNotification(message, flutterLocalNotificationsPlugin, false);
      }
      Get.find<RideController>().getRideDetails(Get.find<RideController>().tripDetails!.id!);

    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print("onMessageOpenedApp: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
      }
      try{
        if(message.notification!.title!.isNotEmpty){
        }
      }catch (e){
        debugPrint(e.toString());
      }
    });
  }

  static Future<void> showCustomNotification(RemoteMessage message, FlutterLocalNotificationsPlugin fln, bool data) async {
    if(!GetPlatform.isIOS){
      String? _title;
      String? _body;
      String? _orderID;
      String? _image;
      if(data){
        _title = message.data['title'];
        _body = message.data['body'];
        _orderID = message.data['order_id'];
        _image = (message.data['image'] != null && message.data['image'].isNotEmpty)
            ? message.data['image'].startsWith('http') ? message.data['image']
            : '${AppConstants.baseUrl}/storage/app/public/notification/${message.data['image']}' : null;
      }else{
        _title = message.notification!.title;
        _body = message.notification!.body;
        _orderID = message.notification!.titleLocKey;
        if(GetPlatform.isAndroid){
          _image = (message.notification!.android!.imageUrl != null && message.notification!.android!.imageUrl!.isNotEmpty)
              ? message.notification!.android!.imageUrl!.startsWith('http') ? message.notification!.android!.imageUrl
              : '${AppConstants.baseUrl}/storage/app/public/notification/${message.notification!.android!.imageUrl}' : null;
        }else if(GetPlatform.isIOS){
          _image = (message.notification!.apple!.imageUrl != null && message.notification!.apple!.imageUrl!.isNotEmpty)
              ? message.notification!.apple!.imageUrl!.startsWith('http') ? message.notification!.apple!.imageUrl
              : '${AppConstants.baseUrl}/storage/app/public/notification/${message.notification!.apple!.imageUrl}' : null;
        }
      }

      if(_image != null && _image.isNotEmpty){
        try{
          await showBigPictureNotificationHiddenLargeIcon(_title!, _body!, _orderID!, _image, fln);
        }catch(e) {
          await showTextNotification(_title!, _body!, _orderID!, fln);
        }
      }else{
        await showTextNotification(_title!, _body!, _orderID!, fln);
      }
    }
  }

  static Future<void> showTextNotification(String title, String body, String? orderID, FlutterLocalNotificationsPlugin fln) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'her_user_app', 'her_user_app', playSound: true,
      importance: Importance.max, priority: Priority.max, sound: RawResourceAndroidNotificationSound('notification'),
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: orderID);
  }

  static Future<void> showBigPictureNotificationHiddenLargeIcon(String title, String body, String? orderID, String image, FlutterLocalNotificationsPlugin fln) async {
    final String largeIconPath = await _downloadAndSaveFile(image, 'largeIcon');
    final String bigPicturePath = await _downloadAndSaveFile(image, 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath), hideExpandedLargeIcon: true,
      contentTitle: title, htmlFormatContentTitle: true,
      summaryText: body, htmlFormatSummaryText: true,
    );
    final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'her_user_app', 'her_user_app',
      largeIcon: FilePathAndroidBitmap(largeIconPath), priority: Priority.max, playSound: true,
      styleInformation: bigPictureStyleInformation, importance: Importance.max,
      sound: const RawResourceAndroidNotificationSound('notification'),
    );
    final NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: orderID);
  }

  static Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

}

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print("onBackground: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
  }
}
