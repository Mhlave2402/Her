import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_user_app/features/notification/screens/notification_screen.dart';
import 'package:her_user_app/features/profile/screens/profile_screen.dart';
import 'package:her_user_app/features/trip/screens/trip_screen.dart';
import 'package:her_user_app/util/images.dart';

class HomeDrawerWidget extends StatelessWidget {
  const HomeDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('SheGo'),
          ),
          ListTile(
            leading: Image.asset(Images.activityOutline, width: 24, height: 24),
            title: const Text('Activity'),
            onTap: () {
              Get.to(() => const TripScreen(fromProfile: false));
            },
          ),
          ListTile(
            leading: Image.asset(Images.notificationOutline, width: 24, height: 24),
            title: const Text('Notification'),
            onTap: () {
              Get.to(() => const NotificationScreen());
            },
          ),
          ListTile(
            leading: Image.asset(Images.profileOutline, width: 24, height: 24),
            title: const Text('Profile'),
            onTap: () {
              Get.to(() => const ProfileScreen());
            },
          ),
        ],
      ),
    );
  }
}
