import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:her_user_app/features/auth/screens/sign_in_screen.dart';
import 'package:her_user_app/features/onboard/domain/onboard_model.dart';
import 'package:her_user_app/features/onboard/widget/dot_indicator.dart';
import 'package:her_user_app/features/onboard/widget/onboard_content.dart';
import 'package:her_user_app/features/splash/controllers/config_controller.dart';
import 'package:her_user_app/util/dimensions.dart';
import 'package:her_user_app/util/images.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  int _pageIndex = 0;

  final List<Onboard> _onboardList = [
    Onboard(
      image: Images.onBoard,
      title: 'Request a Ride',
      description: 'Request a ride get picked up by a nearby community driver',
    ),
    Onboard(
      image: Images.onBoard,
      title: 'Confirm Your Driver',
      description: 'Huge drivers network helps you find comfortable, safe and cheap ride',
    ),
    Onboard(
      image: Images.onBoard,
      title: 'Track your ride',
      description: 'Know your driver in advance and be able to view current location in real time on the map',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemCount: _onboardList.length,
                  itemBuilder: (context, index) => OnboardContent(
                    image: _onboardList[index].image,
                    title: _onboardList[index].title,
                    description: _onboardList[index].description,
                  ),
                ),
              ),
              Row(
                children: [
                  ...List.generate(
                    _onboardList.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: Dimensions.paddingSizeExtraSmall),
                      child: DotIndicator(isActive: index == _pageIndex),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_pageIndex == _onboardList.length - 1) {
                          Get.find<ConfigController>().disableIntro();
                          Get.offAll(() => const SignInScreen());
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Theme.of(context).cardColor,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Dimensions.paddingSizeLarge),
              if (_pageIndex != _onboardList.length - 1)
                TextButton(
                  onPressed: () {
                    Get.find<ConfigController>().disableIntro();
                    Get.offAll(() => const SignInScreen());
                  },
                  child: Text(
                    'skip'.tr,
                    style: GoogleFonts.poppins(
                      fontSize: Dimensions.fontSizeLarge,
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                    ),
                  ),
                ),
              if (_pageIndex == _onboardList.length - 1)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.find<ConfigController>().disableIntro();
                      Get.offAll(() => const SignInScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                    ),
                    child: Text(
                      'get_started'.tr,
                      style: GoogleFonts.poppins(
                        fontSize: Dimensions.fontSizeLarge,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).cardColor,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
