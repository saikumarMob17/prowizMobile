import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prowiz/controllers/login_controller.dart';
import 'package:prowiz/screens/home_screen.dart';
import 'package:prowiz/utils/colors.dart';
import 'package:prowiz/utils/custom_text.dart';
import 'package:prowiz/utils/strings.dart';
import 'package:prowiz/utils/images.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantColors.primaryColor,
      body: GetBuilder<LoginController>(
          init: loginController,
          builder: (_) {
            return Padding(
              padding: const EdgeInsets.all(57),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    ConstantImages.logo,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const CustomTextWidget(
                    text: Constants.welcomeBackSign,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    size: 16,
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  userNameField(),
                  const SizedBox(
                    height: 15,
                  ),
                  passwordField(),
                  const SizedBox(
                    height: 30,
                  ),
                  submitButton(context),
                ],
              ),
            );
          }),
    );
  }

  var focusBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none);

  var contentPadding = const EdgeInsets.symmetric(horizontal: 10, vertical: 5);

  var hintTextStyle = const TextStyle(fontSize: 12, color: Colors.black);
  userNameField() {
    return TextFormField(
      controller: loginController.email,
      decoration: InputDecoration(
          filled: true,
          hintText: Constants.userName,
          hintStyle: hintTextStyle,
          contentPadding: contentPadding,
          fillColor: ConstantColors.whiteColor,
          focusedBorder: focusBorder,
          border: focusBorder),
    );
  }

  passwordField() {
    return TextFormField(
      controller: loginController.password,
      decoration: InputDecoration(
        filled: true,
        hintText: Constants.password,
        hintStyle: hintTextStyle,
        fillColor: ConstantColors.whiteColor,
        contentPadding: contentPadding,
        focusedBorder: focusBorder,
        border: focusBorder,
      ),
    );
  }

  submitButton(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: ConstantColors.loginButtonColor,
        ),
        onPressed: () {
          loginController.getAccessToken(loginController.email.text.trim(),
              loginController.password.text.trim());
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => const HomeScreen()));
        },
        child: const CustomTextWidget(
          text: Constants.Login,
          color: ConstantColors.whiteColor,
          size: 16,
        ));
  }
}
