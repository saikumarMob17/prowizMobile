import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prowiz/controllers/login_controller.dart';
import 'package:prowiz/screens/home_screen.dart';
import 'package:prowiz/utils/colors.dart';
import 'package:prowiz/utils/custom_loader.dart';
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
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  var focusBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none);

  var contentPadding = const EdgeInsets.symmetric(horizontal: 10, vertical: 5);

  var hintTextStyle =
      const TextStyle(fontSize: 12, color: ConstantColors.blackColor);
  userNameField() {
    return TextFormField(
      controller: loginController.emailController,
      onChanged:(value) {
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
    return loginController.isLoading
        ? const Center(
            child: CustomLoader(
            color: Colors.red,
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
}
