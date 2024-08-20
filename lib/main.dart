import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prowiz/screens/intro_screen.dart';
import 'package:prowiz/screens/splash_screen.dart';
import 'package:prowiz/utils/global_theme.dart';

void main() async{

  await GetStorage.init();

  final themeController = Get.put(ThemeController());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Obx(() {
      final themeController = Get.find<ThemeController>();
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeController.themeData,
        home:   SplashScreen(),
      );
    });
  }
}

