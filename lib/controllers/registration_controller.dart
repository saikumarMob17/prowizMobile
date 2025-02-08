import 'dart:convert';
import 'dart:developer'as logs;
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import 'package:prowiz/network/api_services.dart';
import 'package:prowiz/screens/login_screen.dart';

import 'package:prowiz/utils/custom_snackbar.dart';
import 'package:prowiz/utils/strings.dart';

class RegistrationController extends GetxController {
  late TextEditingController userName, email, password, centerId, locationCode;
  bool isLoading = false;

  RxBool isButtonVisible = false.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? emailError, passwordError, userNameError, locationCodeError;
  RxString captchaText = ''.obs;
  late TextEditingController captchaController;
  RxBool isVerified = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    userName = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    centerId = TextEditingController();
    locationCode = TextEditingController();
    captchaController = TextEditingController();

    email.addListener(checkInput);
    password.addListener(checkInput);
    userName.addListener(checkInput);
    locationCode.addListener(checkInput);
    generateCaptcha();
  }

  void generateCaptcha() {

    if(isVerified.value){
      return;

    }

    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789'; // Avoid similar characters
    Random random = Random();

    captchaText.value = List.generate(5, (index) => chars[random.nextInt(chars.length)]).join();
    update();

  }

  void validateCaptcha() {
    if (captchaController.text.toUpperCase() == captchaText.value) {
      isVerified.value = true;
      checkInput();
      update();
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(content: Text('CAPTCHA Matched ✅')));


    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(content: Text('Incorrect CAPTCHA ❌')));
      generateCaptcha(); // Refresh CAPTCHA on failure
      captchaController.clear();
    }
  }



  checkInput() {
    isLoading = false;
    isButtonVisible.value = email.text.isNotEmpty &&
        userName.text.isNotEmpty &&
        locationCode.text.isNotEmpty &&
        password.text.isNotEmpty && isVerified.value;
    update();
  }

  void emailValidation() {
    emailError = _validateEmail(email.text.trim());

    if (emailError != null) {
      update();
    }
  }

  void passwordValidation() {
    passwordError = password.text.isEmpty ? Constants.passwordEmpty : null;

    if (passwordError != null) {
      update();
    }
  }

  void userNameValidation() {
    userNameError = userName.text.isEmpty ? Constants.userNameEmpty : null;

    if (userNameError != null) {
      update();
    }
  }

  void locationValidation() {
    locationCodeError =
        locationCode.text.isEmpty ? Constants.locationEmpty : null;

    if (locationCodeError != null) {
      update();
    }
  }

  String? _validateEmail(String email) {
    if (email.isEmpty) {
      return 'Email is required';
    }

    String pattern = r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(email)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  void registerAccount() async {
    isLoading = true;

    try {
      var response = await getRegisterAccount(
          email.text.trim(),
          password.text.trim(),
          userName.text.trim(),
          locationCode.text.trim(),
          centerId.text.trim());

      isLoading = false;

      update();

      if (response.isNotEmpty) {
        showCustomSnackBar(response.toString(), title: "Register", );

        Get.to(LoginScreen(),
            arguments: {"email": email.text, "password": password.text});
      } else {
        isLoading = false;

        showCustomSnackBar(
          "User Not registered",
          title: "Register",
          color: Colors.redAccent,
          snackBarPosition: SnackPosition.BOTTOM,
        );
      }
    } on Exception catch (e) {
      isLoading = false;
      update();
      logs.log("Register error login ===> ${e.toString()}");
      showCustomSnackBar("Something went wrong, please try again.",
          title: e.toString());
      // TODO
    }
  }

  Future<String> getRegisterAccount(
      String? email, password, userName, locationCode, centerId) async {
    try {
      String registerUrlPath = Constants.registerApi;

      Map<String, String> headers = {'Content-Type': 'application/json'};

      final response = await ApiServices.postApiCall(
          url: registerUrlPath,
          headers: headers,
          dataParams: {
            "username": userName,
            "email": email,
            "password": password,
            "centerId": centerId,
            "locationCode": locationCode
          });

      if (kDebugMode) {
        logs.log("getAccessToken ===> response===> $response");
        logs.log("getAccessToken LoginResponseModel data===> ${response?.data}");
      }

      if (response?.statusCode == 200) {
        String registerMessage = jsonDecode(response?.data)['message'] ?? "";

        return registerMessage;
      }

      return "";
    } on Exception catch (e) {
      // TODO

      isLoading = false;
      return "";
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    userName.dispose();
    email.dispose();
    password.dispose();
    centerId.dispose();
    locationCode.dispose();
  }
}
