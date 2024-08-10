import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:prowiz/models/login_response.dart';
import 'package:prowiz/network/api_services.dart';
import 'package:prowiz/screens/home_screen.dart';
import 'package:prowiz/screens/splash_screen.dart';
import 'package:prowiz/utils/build_environments.dart';
import 'package:prowiz/utils/custom_snackbar.dart';
import 'package:prowiz/utils/storage_utils.dart';
import 'package:prowiz/utils/strings.dart';

class LoginController extends GetxController {
  late TextEditingController email, password;

  var isLoading = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    email = TextEditingController();
    password = TextEditingController();
  }

  Future<LoginResponseModel> getAccessToken(
      String? email, String password) async {
    isLoading = true;

    try {
      if (kDebugMode) {
        log("getAccessToken ===> email===> password $email $password");
      }

      String loginUrlPath =
          BuildEnvironments.getBaseUrl() + Constants.parentLoginApi;

      final response =
          await ApiServices.postApiCall(url: loginUrlPath, dataParams: {
        "email": email,
        "password": password,
      });

      isLoading = false;
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
        storageBox.write("accessToken", loginResponse.accessToken);

        Get.to(const HomeScreen());

        showCustomSnackBar(Constants.loginSuccess, title: "Login");

        return loginResponse;
      } else {
        isLoading = false;
        return LoginResponseModel(email: "", accessToken: "");
      }
    } on DioException catch (e) {
      return LoginResponseModel.fromJson(e.response?.data);
    }
  }
}
