import 'package:her_user_app/interface/repository_interface.dart';

abstract class NotificationRepositoryInterface implements RepositoryInterface{
  Future<dynamic> sendReadStatus(int notificationId);
}