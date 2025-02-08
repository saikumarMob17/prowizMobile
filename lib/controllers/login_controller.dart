import 'dart:convert';
import 'dart:developer';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:prowiz/models/login_response.dart';
import 'package:prowiz/network/api_services.dart';
import 'package:prowiz/screens/home_screen.dart';
import 'package:prowiz/screens/splash_screen.dart';
import 'package:prowiz/utils/custom_snackbar.dart';
import 'package:prowiz/utils/strings.dart';

class LoginController extends GetxController {
  late TextEditingController emailController,
      passwordController,
      locationController;

  RxBool isLoading = false.obs;
  var camerasList = <Camera>[].obs;
  var errorMessage = ''.obs;
  var locationCode = ''.obs;
  var selectedGroupIndex = 0.obs; // For tracking the selected group
  var selectedSubgroupIndex = 0.obs; // For tracking the selected subgroup
  var videoUrls = <Map<String, String>>[].obs; // Store video URLs
  var subgroups = <SubgroupId>[].obs;

  final Rx<NotchBottomBarController> notchBottomBarController =
      NotchBottomBarController(index: 0).obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late LoginResponseModel loginResponseModel;

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

    emailController = TextEditingController();
    passwordController = TextEditingController();
    locationController = TextEditingController();

    //Add Listeners for input changes

    emailController.addListener(checkInput);
    passwordController.addListener(checkInput);
    loadUserData();

    //  getAccessToken(emailController.text.trim(), passwordController.text.trim());
  }

  void loadUserData() {
    var storedUserData = storageBox.read(Constants.isUserData);

    log("storedUserData Type is===> ${storedUserData.runtimeType}");
    log("storedUserData===> ${storedUserData}");

    if (storedUserData != null) {
      try {
        // Decode JSON string to Map
        Map<String, dynamic> jsonData = storedUserData;



        // Convert to model
        loginResponseModel = LoginResponseModel.fromJson(jsonData);


        // Update values
        camerasList.value = loginResponseModel.cameras;

        locationController.text = loginResponseModel.user.locationCode;

        updateSubgroups();
        fetchSubgroupVideos();




        log("User Data Loaded Successfully: ${camerasList}");
      } catch (e) {
        log("Error loading user data: $e");
      }
    }
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
        passwordController.text.isEmpty ? Constants.passwordEmpty : null;

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
    isLoading.value = true;

    update();
    try {
      LoginResponseModel loginResponseModel = await getAccessToken(
          emailController.text.trim(), passwordController.text.trim());

      isLoading.value = false;
      update();

      // if (jsonDecode(loginResponseModel?.data.toString() ?? "").containsKey("error")) {
      //   isLoading.value = false;
      //   // Extract the error message and display a snackbar
      //   String errorMessage = "Inavalid Credntails";
      //   Get.snackbar(
      //     "Error",
      //     errorMessage,
      //     snackPosition: SnackPosition.BOTTOM,
      //     backgroundColor: Colors.red,
      //     colorText: Colors.white,
      //     duration: Duration(seconds: 3),
      //   );
      // }

      if (loginResponseModel.cameras.isNotEmpty) {
        storageBox.write(Constants.email, loginResponseModel.user.email);

        storageBox.write(Constants.isLoggedIn, true);
        storageBox.write(Constants.isUserData, loginResponseModel.toJson());
        showCustomSnackBar(Constants.loginSuccess, title: "Login");
        Get.offAll(HomeScreen());
      } else {
        log("ELSE error login ===> ");
        isLoading.value = false;
        String errorMessage =
            loginResponseModel.message ?? Constants.invalidEmailPassword;
        showCustomSnackBar(
          errorMessage,
          title: "Login",
          color: Colors.redAccent,
          snackBarPosition: SnackPosition.BOTTOM,
        );
      }
    } on Exception catch (e) {
      log("login error login ===> ${e.toString()}");
      isLoading.value = false;
      update();

      showCustomSnackBar("Something went wrong, please try again.",
          title: e.toString());
    }
  }

  void passwordVisibility() {
    isPasswordObscured = !isPasswordObscured;

    update();
  }

  void updateSubgroups() {
    if (selectedGroupIndex.value < camerasList.length) {
      var selectedGroup = camerasList[selectedGroupIndex.value];
      subgroups.value = selectedGroup.subgroupId;
    }
  }

  Future<void> fetchSubgroupVideos() async {
    if (selectedGroupIndex.value >= camerasList.length) return;
    var selectedGroup = camerasList[selectedGroupIndex.value];

    if (selectedSubgroupIndex.value >= selectedGroup.subgroupId.length) return;
    var selectedSubgroup =
        selectedGroup.subgroupId[selectedSubgroupIndex.value];

    // Fetch videos based on selected group and subgroup
    var urls = <Map<String, String>>[];
    for (var video in selectedSubgroup.url) {
      urls.add({
        "subgroupId": selectedSubgroup.subgroupId,
        "name": video.name,
        "url": video.url,
      });
    }

    videoUrls.value = urls;
  }

  Future<LoginResponseModel> getAccessToken(
      String? email, String password) async {
    if (kDebugMode) {
      log("getAccessToken ===> email===> password $email $password");
    }

    String loginUrlPath = Constants.customerLoginApi;
    //String loginUrlPath = BuildEnvironments.getBaseUrl() + Constants.parentLoginApi;

    Map<String, String> headers = {'Content-Type': 'application/json'};

    final response = await ApiServices.postApiCall(
        url: loginUrlPath,
        headers: headers,
        dataParams: {
          // "email": email,
          "loginField": email,
          "password": password,
        });

    if (kDebugMode) {
      log("getAccessToken111111 ===> response===> ${response!.statusCode}");
    }
    try {
      if (response?.statusCode == 200 && response?.data != null) {
        loginResponseModel = loginResponseModelFromJson(response?.data);

        // if(jsonDecode(response?.data).containsKey("error")){
        //
        //
        //   ErrorResponse errorResponse = ErrorResponse.fromJson(response?.data);
        //
        //   log("errorResponse ===> $errorResponse");
        //
        // }

        if (loginResponseModel.cameras.isEmpty) {
          camerasList.value = [];
        } else {
          isLoading.value = false;

          log("test123444");
          camerasList.value = loginResponseModel.cameras;

          locationController.text = loginResponseModel.user.locationCode;

          storageBox.write(Constants.locationCode, locationController.text);


          if (kDebugMode) {
            log("getAccessToken ===> loginResponse===> $loginResponseModel");
            log("AccessToken===> ${loginResponseModel.user}");
          }

          camerasList.value = loginResponseModel.cameras;

          Future.delayed(Duration( milliseconds: 300), () {
            updateSubgroups();
            fetchSubgroupVideos();
          });
          

        }

        return loginResponseModel;
      } else {
        isLoading.value = false;

        log("ISERROR");
        return LoginResponseModel(
            message: "",
            user: User(id: "", username: "", email: "", locationCode: ""),
            cameras: []);

        // return LoginResponseModel(
        //     user: User(id: "", username: "", email: "", locationCode: ""),
        //     cameras: Camera(groupId: [], subgroupId: []),
        //     message: "");
      }
    } on DioException catch (e) {
      log("message ${e.toString()}");
      return LoginResponseModel.fromJson(
        e.response?.data['message'],
      );
    }
  }
}
