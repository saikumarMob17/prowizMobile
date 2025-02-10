import 'dart:convert';
import 'dart:developer' as logs;
import 'dart:math';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prowiz/models/login_response.dart';
import 'package:prowiz/network/api_services.dart';
import 'package:prowiz/screens/home_screen.dart';
import 'package:prowiz/screens/splash_screen.dart';
import 'package:prowiz/utils/custom_snackbar.dart';
import 'package:prowiz/utils/strings.dart';

class LoginController extends GetxController {
  late TextEditingController emailController,
      passwordController,
      locationController,
      captchaController;

  RxBool isLoading = false.obs;
  var camerasList = <Camera>[].obs;
  var errorMessage = ''.obs;
  var locationCode = ''.obs;
  var selectedGroupIndex = 0.obs; // For tracking the selected group
  var selectedSubgroupIndex = 0.obs; // For tracking the selected subgroup
  var videoUrls = <Map<String, String>>[].obs; // Store video URLs
  var subgroups = <SubgroupId>[].obs;
  RxString captchaText = "".obs;
  RxBool isVerified = false.obs;

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
    captchaController = TextEditingController();

    //Add Listeners for input changes

    emailController.addListener(checkInput);
    passwordController.addListener(checkInput);
    captchaController.addListener(checkInput);
    loadUserData();

    //TODO For generating the Captcha Text
    generateCaptcha();

  }

  void generateCaptcha() {
    if (isVerified.value) {
      return;
    }

    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';

    Random random = Random();

    captchaText.value =
        List.generate(5, (index) => chars[random.nextInt(chars.length)]).join();

    update();
  }

  void validateCaptcha(BuildContext context) {
    if ((captchaController.text.toUpperCase().trim() == captchaText.value.trim())) {
      isVerified.value = true;
      checkInput();
      update();
     // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("'CAPTCHA Matched ✅'")));
      login();
    } else {

      if(!isButtonVisible) {
        return;
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("'Incorrect CAPTCHA ❌'")));
      generateCaptcha();
      captchaController.clear();
    }
  }

  void loadUserData() {
    var storedUserData = storageBox.read(Constants.isUserData);

    logs.log("storedUserData Type is===> ${storedUserData.runtimeType}");
    logs.log("storedUserData===> $storedUserData");

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

        logs.log("User Data Loaded Successfully: $camerasList");
      } catch (e) {
        logs.log("Error loading user data: $e");
      }
    }
  }

  checkInput() {

    logs.log("Email Error ===> $emailError");
    logs.log("Email ISButtonVisible ===> $isButtonVisible");
    isButtonVisible = ((emailError == null) && (emailController.text.isNotEmpty)) && (passwordController.text.isNotEmpty) && (captchaController.value.text.isNotEmpty);

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
        logs.log("ELSE error login ===> ${loginResponseModel.message}");
        isLoading.value = false;
        isVerified.value = false;
        generateCaptcha();
        captchaController.clear();

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
      logs.log("login error login ===> ${e.toString()}");
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
      logs.log("getAccessToken ===> email===> password $email $password");
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
      logs.log("getAccessToken111111 ===> response===> ${response!.data}");
    }
    try {
      if ((response?.statusCode == 200) &&
          (response?.data != null) &&
          (jsonDecode(response?.data).containsKey("error"))) {
        // ErrorResponse errorResponse = ErrorResponse.fromJson(response?.data);

        logs.log("errorResponse ===> ${response?.data.runtimeType}");

        Map<String, dynamic> jsonResponse = jsonDecode(response?.data);
        isLoading.value = false;
        update();

        // showCustomSnackBar(jsonResponse['error'],
        //     title: "Login",
        //     isSuccess: false,
        //     snackBarPosition: SnackPosition.BOTTOM,
        //     color: Colors.red);

        return LoginResponseModel(
            message: jsonResponse['error'],
            user: User(id: "", username: "", email: "", locationCode: ""),
            cameras: []);
      }

      if (response?.statusCode == 200 && response?.data != null) {
        loginResponseModel = loginResponseModelFromJson(response?.data);

        // if(jsonDecode(response?.data).containsKey("error")){
        //
        //
        //   ErrorResponse errorResponse = ErrorResponse.fromJson(response?.data);
        //
        //   logs.log("errorResponse ===> $errorResponse");
        //
        // }

        if (loginResponseModel.cameras.isEmpty) {
          camerasList.value = [];
        } else {
          isLoading.value = false;

          logs.log("test123444");
          camerasList.value = loginResponseModel.cameras;

          locationController.text = loginResponseModel.user.locationCode;

          storageBox.write(Constants.locationCode, locationController.text);

          if (kDebugMode) {
            logs.log(
                "getAccessToken ===> loginResponse===> $loginResponseModel");
            logs.log("AccessToken===> ${loginResponseModel.user}");
          }

          camerasList.value = loginResponseModel.cameras;

          Future.delayed(Duration(milliseconds: 300), () {
            updateSubgroups();
            fetchSubgroupVideos();
          });
        }

        return loginResponseModel;
      } else {
        isLoading.value = false;

        logs.log("ISERROR");
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
      logs.log("message ${e.toString()}");
      return LoginResponseModel.fromJson(
        e.response?.data['message'],
      );
    }
  }
}
