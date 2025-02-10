import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:prowiz/controllers/login_controller.dart';
import 'package:prowiz/screens/login_screen.dart';
import 'package:prowiz/screens/splash_screen.dart';
import 'package:prowiz/utils/colors.dart';
import 'package:prowiz/utils/custom_dialog.dart';
import 'package:prowiz/utils/custom_text.dart';
import 'package:prowiz/utils/global_theme.dart';
import 'package:prowiz/utils/images.dart';
import 'package:prowiz/utils/storage_utils.dart';
import 'package:prowiz/utils/strings.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key, required this.controller, required this.loginController});

  final NotchBottomBarController controller;
  final LoginController loginController;

  @override
  Widget build(BuildContext context) {


    final ThemeController themeController = Get.put(ThemeController());
   // final LoginController loginController = Get.put(LoginController());

    Future<bool?> showLogoutConfirmationDialog(BuildContext context) {
      return showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Align(
                    alignment: Alignment.centerLeft,
                    child: CustomTextWidget(
                      text: Constants.logoutTitle,
                      color: ConstantColors.blackColor,
                    )),
                content: const Text(Constants.logoutDesc),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(Constants.btnText1),
                  ),
                  TextButton(
                    onPressed: () {
                      storageBox.erase();
                     // storageBox.remove(Constants.accessToken);
                      controller.index= 0;

                      loginController.passwordController.clear();
                      loginController.emailController.clear();
                      loginController.captchaController.clear();
                      loginController.isVerified.value = false;
                      loginController.generateCaptcha();
                     // loginController.captchaText.value = "";
                      Get.offAll(
                        LoginScreen(),
                      );
                    },
                    child: const Text(Constants.btnText2),
                  ),
                ],
              );
            },
          ) ??
          Future.value(false);
    }

    return SafeArea(
      child: Obx(() => Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(20.0),
                child: Container(
                  padding: const EdgeInsets.only(left: 24),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => onWillPop(context),
                        child: const CircleAvatar(
                          radius: 15,
                          backgroundColor: ConstantColors.buttonColor,
                          child: Icon(
                            Icons.arrow_back,
                            color: ConstantColors.whiteColor,
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CustomTextWidget(
                        text: StorageUtils.email().split('@')[0],
                        fontWeight: FontWeight.w400,
                        size: 22,
                        color: ConstantColors.whiteColor,
                      )
                    ],
                  ),
                ),
              ),
              toolbarHeight: 35,
              backgroundColor: Colors.transparent,
            ),
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    ConstantImages.logo,
                    fit: BoxFit.cover,
                    height: 80,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ConstantColors.whiteColor,
                        border: Border.all(
                            color: ConstantColors.buttonColor, width: 2)),
                    child: const Icon(
                      Icons.person,
                      size: 48,
                      color: ConstantColors.blackColor,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextWidget(text: StorageUtils.email().split('@')[0]),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomTextWidget(text: StorageUtils.email()),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextWidget(
                          text: themeController.isDarkMode.value
                              ? "Dark Theme"
                              : "Light Theme"),
                      const SizedBox(
                        width: 10,
                      ),
                      Transform.scale(
                        scale: 1,
                        child: Switch(
                            value: themeController.isDarkMode.value,
                            onChanged: (bool? value) {
                              if (value != null) {
                                themeController.toggleTheme(value);
                              }
                            }),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                   ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ConstantColors.buttonColor,
                          minimumSize:
                              Size(Get.width * 0.5, Get.height * 0.05)),
                      onPressed: () => showLogoutConfirmationDialog(context),
                      child: const CustomTextWidget(
                        text: Constants.logout,
                        size: 14,
                        color: ConstantColors.whiteColor,
                      )) ,
                ],
              ),
            ),
          )),
    );
  }
}
