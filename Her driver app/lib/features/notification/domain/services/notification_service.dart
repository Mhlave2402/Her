

import 'package:her_driver_app/features/notification/domain/repositories/notification_repository_interface.dart';
import 'package:her_driver_app/features/notification/domain/services/notification_service_interface.dart';

class NotificationService implements NotificationServiceInterface{

  final NotificationRepositoryInterface notificationRepositoryInterface;
  NotificationService({required this.notificationRepositoryInterface});

  @override
  Future getNotificationList(int offset) {
    return notificationRepositoryInterface.getList(offset: offset);
  }

  @override
  Future sendReadStatus(int notificationId) async{
    return await notificationRepositoryInterface.sendReadStatus(notificationId);
  }

}