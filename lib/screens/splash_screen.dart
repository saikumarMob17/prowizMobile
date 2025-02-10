import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prowiz/screens/home_screen.dart';
import 'package:prowiz/screens/login_screen.dart';
import 'package:prowiz/screens/registration_page.dart';
import 'package:prowiz/utils/colors.dart';
import 'package:prowiz/utils/images.dart';
import 'package:prowiz/utils/storage_utils.dart';

final storageBox = GetStorage();

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    startTimer();
    return Scaffold(
      backgroundColor: ConstantColors.primaryColor,
      body: Center(
        child: Image.asset(ConstantImages.logo),
      ),
    );
  }

  void startTimer() {
    Future.delayed(const Duration(seconds: 2), () {
      if (StorageUtils.getLoggedIn()) {
        Get.to( const HomeScreen());
      }
      else {
        Get.offAll(LoginScreen());
      }
    });
  }
}
