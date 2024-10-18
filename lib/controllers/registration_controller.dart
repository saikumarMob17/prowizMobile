import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:prowiz/network/api_services.dart';
import 'package:prowiz/screens/login_screen.dart';

import 'package:prowiz/utils/custom_snackbar.dart';
import 'package:prowiz/utils/strings.dart';

class RegistrationController extends GetxController {
  late TextEditingController userName, email, password, centerId, locationCode;
  bool isLoading = false;

  bool isButtonVisible = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? emailError, passwordError, userNameError, locationCodeError;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    userName = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    centerId = TextEditingController();
    locationCode = TextEditingController();

    email.addListener(checkInput);
    password.addListener(checkInput);
    userName.addListener(checkInput);
    locationCode.addListener(checkInput);
  }

  checkInput() {
    isLoading = false;
    isButtonVisible = email.text.isNotEmpty &&
        userName.text.isNotEmpty &&
        locationCode.text.isNotEmpty &&
        password.text.isNotEmpty;
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

        showCustomSnackBar(
          response,
          title: "Register",
          color: Colors.green,

          isSuccess: true,
          snackBarPosition: SnackPosition.TOP,
        );

        Get.to(LoginScreen());


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
      log("Register error login ===> ${e.toString()}");
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
        log("getAccessToken ===> response===> $response");
        log("getAccessToken LoginResponseModel data===> ${response?.data}");
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
