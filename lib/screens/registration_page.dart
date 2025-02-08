import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gcaptcha_v3/recaptca_config.dart';
import 'package:flutter_gcaptcha_v3/web_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prowiz/controllers/registration_controller.dart';
import 'package:prowiz/utils/colors.dart';
import 'package:prowiz/utils/custom_loader.dart';
import 'package:prowiz/utils/custom_text.dart';
import 'package:prowiz/utils/custom_widgets.dart';
import 'package:prowiz/utils/global_theme.dart';
import 'package:prowiz/utils/strings.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({super.key});

  final registerController = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    var sizedBox = const SizedBox(
      height: 20,
    );
    return Obx(() => Scaffold(
          backgroundColor: themeController.isDarkMode.value
              ? ConstantColors.blackColor
              : ConstantColors.primaryColor,
          body: GetBuilder<RegistrationController>(
              init: registerController,
              builder: (_) {
                return Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customImage(height: Get.height * 0.08),
                          const SizedBox(
                            height: 20,
                          ),
                          const Align(
                            alignment: Alignment.center,
                            child: CustomTextWidget(
                              text: Constants.registerAnAccount,
                              fontWeight: FontWeight.bold,
                              size: 24,
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          userNameTextField(),
                          sizedBox,
                          passwordTextField(),
                          sizedBox,
                          emailTextField(),
                          sizedBox,
                          centerIdTextFiled(),
                          sizedBox,
                          locationIdTextField(),
                          sizedBox,
                          const SizedBox(
                            height: 10,
                          ),

                          recaptchaWidget(context),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          // (registerController.captchaController.text
                          //             .toUpperCase() ==
                          //         registerController.captchaText.value)
                          //     ? submitButton(context)
                          //     : SizedBox(),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ));
  }

  var focusBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        20,
      ),
      borderSide: BorderSide.none);

  var contentPadding = const EdgeInsets.symmetric(horizontal: 10, vertical: 5);

  var hintTextStyle =
      const TextStyle(fontSize: 12, color: ConstantColors.blackColor);

  userNameTextField() {
    return TextFormField(
      controller: registerController.userName,
      onChanged: (value) {
        registerController.userNameValidation();
      },
      decoration: InputDecoration(
        fillColor: ConstantColors.whiteColor,
        hintText: Constants.userName,
        filled: true,
        hintStyle: hintTextStyle,
        focusedBorder: focusBorder,
        border: focusBorder,
        contentPadding: contentPadding,
      ),
    );
  }

  passwordTextField() {
    return TextFormField(
      controller: registerController.password,
      onChanged: (value) => registerController.passwordValidation(),
      decoration: InputDecoration(
        fillColor: ConstantColors.whiteColor,
        hintText: Constants.password,
        filled: true,
        hintStyle: hintTextStyle,
        focusedBorder: focusBorder,
        border: focusBorder,
        contentPadding: contentPadding,
      ),
    );
  }

  centerIdTextFiled() {
    return TextFormField(
      controller: registerController.centerId,
      decoration: InputDecoration(
        fillColor: ConstantColors.whiteColor,
        hintText: Constants.centerId,
        filled: true,
        hintStyle: hintTextStyle,
        focusedBorder: focusBorder,
        border: focusBorder,
        contentPadding: contentPadding,
      ),
    );
  }

  emailTextField() {
    return TextFormField(
      controller: registerController.email,
      onChanged: (value) => registerController.emailValidation,
      decoration: InputDecoration(
        fillColor: ConstantColors.whiteColor,
        hintText: Constants.email,
        filled: true,
        hintStyle: hintTextStyle,
        focusedBorder: focusBorder,
        border: focusBorder,
        contentPadding: contentPadding,
      ),
    );
  }

  locationIdTextField() {
    return TextFormField(
      controller: registerController.locationCode,
      onChanged: (value) => registerController.locationValidation,
      decoration: InputDecoration(
        fillColor: ConstantColors.whiteColor,
        hintText: Constants.location,
        filled: true,
        hintStyle: hintTextStyle,
        focusedBorder: focusBorder,
        border: focusBorder,
        contentPadding: contentPadding,
      ),
    );
  }

  submitButton(BuildContext context) {
    return registerController.isLoading
        ? const Center(
            child: CustomLoader(),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: registerController.isButtonVisible.value
                  ? ConstantColors.loginButtonColor
                  : Colors.grey,
            ),
            onPressed: () {
              registerController.isButtonVisible.value
                  ? registerController.registerAccount()
                  : null;
            },
            child: const CustomTextWidget(
              text: Constants.register,
              color: ConstantColors.whiteColor,
              size: 16,
            ));
  }

  recaptchaWidget(BuildContext context) {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: Get.width * 0.75,
          height: Get.height * 0.06,
          decoration: BoxDecoration(
              color: ConstantColors.whiteColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                 BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 2)
              ]
          ),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                registerController.captchaText.value,
                style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                    fontStyle: FontStyle.italic),
              ),

              if (!registerController.isVerified.value)
                Expanded(
                  child: TextButton(
                    onPressed: registerController.generateCaptcha,
                    child: const CustomTextWidget(
                      text: 'Reload CAPTCHA 🔄',
                      size: 12,
                      color: ConstantColors.loginButtonColor,
                    ),
                  ),
                ),


            ],
          ),
        ),

        const SizedBox(height: 30),
        TextField(
          readOnly: registerController.isVerified.value,
          controller: registerController.captchaController,
          style: const TextStyle(color: Colors.white),
          decoration:  InputDecoration(
              border: const OutlineInputBorder(),
              labelText:  'Enter CAPTCHA',
              suffixIcon: registerController.isVerified.value ? const Icon(Icons.verified,color: Colors.green,) : null
          ),
        ),
         SizedBox(height: registerController.isVerified.value ? 0: 20),
        ElevatedButton(

          onPressed: registerController.isVerified.value
              ? null
              : registerController.validateCaptcha,
          style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
              backgroundColor: registerController.isVerified.value
                  ? Colors.green
                  : ConstantColors.loginButtonColor),
          child: CustomTextWidget(text: registerController.isVerified.value
              ? ""
              : 'Verify',),
        ),

        registerController.isVerified.value ? submitButton(context) : const SizedBox(),

      ],
    ));
  }

}
