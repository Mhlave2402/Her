import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_user_app/features/dashboard/controllers/bottom_menu_controller.dart';
import 'package:her_user_app/features/dashboard/widgets/home_drawer_widget.dart';
import 'package:her_user_app/features/home/screens/home_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, val) async {
        Get.find<BottomMenuController>().exitApp();
      },
      child: Scaffold(
        drawer: const HomeDrawerWidget(),
        body: const HomeScreen(),
      ),
    );
  }
}
