import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prowiz/models/login_response.dart';
import 'package:prowiz/network/api_services.dart';
import 'package:prowiz/screens/home_screen.dart';
import 'package:prowiz/screens/splash_screen.dart';
import 'package:prowiz/utils/build_environments.dart';
import 'package:prowiz/utils/colors.dart';
import 'package:prowiz/utils/custom_snackbar.dart';
import 'package:prowiz/utils/strings.dart';

class LoginController extends GetxController {
  late TextEditingController emailController, passwordController;

  bool isLoading = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isButtonVisible = false;

  String? emailError;
  String? passwordError;
  bool isPasswordObscured = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    emailController = TextEditingController(text: "archana@coact.co.in");
    passwordController = TextEditingController(text: "Coact@123");

    //Add Listeners for input changes

    emailController.addListener(checkInput);
    passwordController.addListener(checkInput);
  }

  checkInput() {
    isButtonVisible =
        emailController.text.isNotEmpty && passwordController.text.isNotEmpty;

    update();
  }

  void emailValidation() {
    emailError = _validateEmail(emailController.text.trim());

    if (emailError != null) {
      update();
    }
  }

  void passwordValidation() {
    passwordError =
        passwordController.text.isEmpty ? "Password can not empty" : null;

    if (passwordError != null) {
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

  void login() async {
    isLoading = true;

    update();
    try {
      LoginResponseModel loginResponseModel = await getAccessToken(
          emailController.text.trim(), passwordController.text.trim());

      isLoading = false;
      update();
      if (loginResponseModel.accessToken.isNotEmpty) {
        storageBox.write(Constants.accessToken, loginResponseModel.accessToken);
        storageBox.write(
            Constants.email, loginResponseModel.email.split("@")[0]);

        showCustomSnackBar(Constants.loginSuccess, title: "Login");

        Get.to(const HomeScreen());
      } else {
        isLoading = false;
        String errorMessage =
            loginResponseModel.message ?? Constants.invalidEmailPassword;
        showCustomSnackBar(errorMessage,
            title: "Login",
            color: Colors.redAccent,
            snackBarPosition: SnackPosition.BOTTOM);
      }
    } on Exception catch (e) {
      isLoading = false;
      update();
      log("login error login ===> ${e.toString()}");
      showCustomSnackBar("Something went wrong, please try again.",
          title: e.toString());
    }
  }

  void passwordVisibility() {
    isPasswordObscured = !isPasswordObscured;

    update();
  }

  Future<LoginResponseModel> getAccessToken(
      String? email, String password) async {
    try {
      if (kDebugMode) {
        log("getAccessToken ===> email===> password $email $password");
      }

      String loginUrlPath =
          BuildEnvironments.getBaseUrl() + Constants.parentLoginApi;

      Map<String, String> headers = {'Content-Type': 'application/json'};

      final response = await ApiServices.postApiCall(
          url: loginUrlPath,
          headers: headers,
          dataParams: {
            "email": email,
            "password": password,
          });

      if (kDebugMode) {
        log("getAccessToken ===> response===> $response");
        log("getAccessToken LoginResponseModel data===> ${response?.data}");
      }
      if (response?.statusCode == 200) {
        LoginResponseModel loginResponse =
            LoginResponseModel.fromJson(response?.data);

        if (kDebugMode) {
          log("getAccessToken ===> loginResponse===> $loginResponse");
          log("AccessToken===> ${loginResponse.accessToken}");
        }

        return loginResponse;
      } else {
        isLoading = false;
        return LoginResponseModel(
            email: "", accessToken: "", message: response?.data['message']);
      }
    } on DioException catch (e) {
      log("message ${e.toString()}");
      return LoginResponseModel.fromJson(
        e.response?.data['message'],
      );
    }
  }
}
