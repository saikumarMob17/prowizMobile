import 'dart:convert';
import 'dart:developer';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:prowiz/main.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:prowiz/models/cameras_list_model.dart';
import 'package:prowiz/network/api_services.dart';
import 'package:prowiz/utils/build_environments.dart';
import 'package:prowiz/utils/storage_utils.dart';

import 'dart:convert';
import 'package:get/get.dart';
import 'package:prowiz/utils/strings.dart';

// Model Classes (same as provided above)

class CamerasController extends GetxController {
  var camerasList = <CamerasListModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var selectedGroupId = ''.obs;
  var selectedSubgroupId = ''.obs;
  var videosList = <Url>[].obs;
  final String token = StorageUtils.getAccessToken();

  Future<void> fetchCameras(String locationCode) async {
    isLoading.value = true;
    errorMessage.value = '';

    String camerasUrlPath =
        BuildEnvironments.getBaseUrl() + Constants.parentCamerasApi;

    Map<String, String> headers = {'Content-Type': 'application/json',

      "x-access-token" : StorageUtils.getAccessToken()
    };


    final response =
    await ApiServices.postApiCall(url: camerasUrlPath,
        headers: headers,

        dataParams: {
      "locationcode": locationCode,

    });

    if (kDebugMode) {
      log("getAccessToken ===> response===> $response");
      log("getAccessToken LoginResponseModel data===> ${response?.data}");
    }




    if (response?.statusCode == 200) {
      try {
        List<dynamic> jsonResponse = jsonDecode(response?.data);
        camerasList.value = jsonResponse
            .map((json) => CamerasListModel.fromJson(json))
            .toList();
      } catch (e) {
        errorMessage.value = 'Error parsing data';
      }
    } else {
      errorMessage.value = 'Error: ${response?.statusCode}';
    }

    isLoading.value = false;
  }

  void fetchVideos(String groupId, String subgroupId) {
    // Dummy implementation to simulate fetching videos for a subgroup
    // Replace with your actual API call to get videos based on groupId and subgroupId
    videosList.value = camerasList
        .firstWhere((c) => c.groupId == groupId)
        .subgroupId
        .firstWhere((s) => s.subgroupId == subgroupId)
        .url;
  }
}

// class CameraListController extends GetxController {
//   late TextEditingController locationCodeController;
//
//   RxString selectedGroup = "".obs;
//   RxString selectedSubGroup = "".obs;
//
//   var camerasList = <CamerasListModel>[].obs;
//   var isLoading = false.obs;
//   var selectedGroupId = "".obs;
//   var selectedSubgroupId = "".obs;
//
//   var videosList = <Url>[].obs;
//
//   List<String> groupIds = [];
//
//   Map<String, List<String>> subgroups = {};
//
//   final pageController = PageController(initialPage: 0);
//   RxInt maxCount = 2.obs;
//
//   final NotchBottomBarController notchBottomBarController =
//       NotchBottomBarController(index: 0);
//
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     super.onInit();
//     locationCodeController = TextEditingController();
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     pageController.dispose();
//   }
//
//   // Future<CameraListController> getCameraListController(String locationCode) async{
//   //
//   //
//   //
//   //
//   //
//   // }
// }
