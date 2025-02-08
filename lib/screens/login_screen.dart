import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prowiz/controllers/login_controller.dart';
import 'package:prowiz/screens/registration_page.dart';
import 'package:prowiz/utils/colors.dart';
import 'package:prowiz/utils/custom_loader.dart';
import 'package:prowiz/utils/custom_text.dart';
import 'package:prowiz/utils/global_theme.dart';
import 'package:prowiz/utils/strings.dart';
import 'package:prowiz/utils/images.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();




    // Map<String, dynamic> arguments=  Get.arguments ?? "";
    //
    // String email = arguments['email'] ?? "";
    // String password = arguments['password'] ?? "";


    return Obx(() => Scaffold(
      backgroundColor: themeController.isDarkMode.value ? ConstantColors.blackColor: ConstantColors.primaryColor,
      body: GetBuilder<LoginController>(
          init: loginController,
          builder: (_) {
            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center ,
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
                      const SizedBox(height: 40,),
                     // registerWidget(),

                    ],
                  ),
                ),
              ),
            );
          }),
    ));
  }


  var focusBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none);

  var contentPadding = const EdgeInsets.symmetric(horizontal: 10, vertical: 5);

  var hintTextStyle =
      const TextStyle(fontSize: 12, color: ConstantColors.blackColor);
  userNameField() {

   // loginController.emailController.text = email;

    return TextFormField(
      controller: loginController.emailController,
      onChanged:(value) {
        log("value ===> $value");
        loginController.emailValidation();
      },
      decoration: InputDecoration(
          filled: true,
          errorText: loginController.emailError,
          hintText: Constants.userName,
          hintStyle: hintTextStyle,
          contentPadding: contentPadding,
          fillColor: ConstantColors.whiteColor,
          focusedBorder: focusBorder,
          border: focusBorder),
    );
  }

  passwordField() {

   // loginController.passwordController.text = password;


    return TextFormField(
      controller: loginController.passwordController,
      obscureText: loginController.isPasswordObscured,

      onChanged: (value) {
        loginController.passwordValidation();
      },
      decoration: InputDecoration(
        filled: true,

        errorText: loginController.passwordError,
        suffixIcon: IconButton(
          icon: Icon(loginController.isPasswordObscured
              ? Icons.visibility_off
              : Icons.visibility),
          onPressed: loginController.passwordVisibility,
        ),
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
    return loginController.isLoading.value
        ? const Center(
            child: CustomLoader(

          ))
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: loginController.isButtonVisible
                  ? ConstantColors.loginButtonColor
                  : Colors.grey,
            ),
            onPressed: () =>  loginController.isButtonVisible
                ? loginController.login()
                : null,
            child: const CustomTextWidget(
              text: Constants.Login,
              color:  ConstantColors.whiteColor,
              size: 16,
            ));
  }

  registerWidget() {

    TextStyle defaultStyle =const TextStyle(color: ConstantColors.whiteColor, fontSize: 14, fontWeight: FontWeight.w600);
    TextStyle linkTextStyle =const  TextStyle(color: ConstantColors.loginButtonColor, fontSize: 14, fontWeight: FontWeight.w600);


    return RichText(text: TextSpan(
      style: defaultStyle,
      children: [
        const TextSpan(text:  Constants.needAnAccount),

        const WidgetSpan(child: SizedBox(width: 5,)),
        TextSpan(text: Constants.register, style: linkTextStyle,
        recognizer: TapGestureRecognizer()..onTap = () {

          Get.to( RegistrationPage());

        })
      ]
    ));


  }
}
