import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gcaptcha_v3/recaptca_config.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prowiz/controllers/login_controller.dart';
import 'package:prowiz/screens/splash_screen.dart';
import 'package:prowiz/utils/global_theme.dart';
import 'package:screen_protector/screen_protector.dart';

void main() async{

  await GetStorage.init();
  Get.lazyPut(() => LoginController(), fenix: true);
  Get.lazyPut(() => ThemeController(), fenix: true);

  await ScreenProtector.preventScreenshotOn();

  RecaptchaHandler.instance.setupSiteKey(dataSiteKey: '6LezGscqAAAAAGLM_B8PgffChiO8P8YgDN915AkS');

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
      final themeController = Get.put(ThemeController());
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeController.themeData,
        home:   SplashScreen(),
      );
    });
  }
}

