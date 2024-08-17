
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:prowiz/models/cameras_list_model.dart';
import 'package:prowiz/network/api_services.dart';
import 'package:prowiz/utils/build_environments.dart';
import 'package:prowiz/utils/storage_utils.dart';
import 'package:prowiz/utils/strings.dart';

class CamerasController extends GetxController {
  var camerasList = <CamerasListModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var locationCode = ''.obs;
  var selectedGroupIndex = 0.obs; // For tracking the selected group
  var selectedSubgroupIndex = 0.obs; // For tracking the selected subgroup
  var videoUrls = <Map<String, String>>[].obs; // Store video URLs
  var subgroups = <SubgroupId>[].obs; // List of subgroups

  Future<void> fetchCameras(String locationCode) async {
    isLoading.value = true;
    errorMessage.value = '';

    String camerasUrlPath = BuildEnvironments.getBaseUrl() + Constants.parentCamerasApi;

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      "x-access-token": StorageUtils.getAccessToken()
    };

    final response = await ApiServices.postApiCall(
        url: camerasUrlPath,
        headers: headers,
        dataParams: {
          "locationcode": locationCode,
        });

    if (response?.statusCode == 200) {
      try {
        camerasList.value = List<CamerasListModel>.from(
            response?.data.map((json) => CamerasListModel.fromJson(json))
        );
        updateSubgroups();
        fetchSubgroupVideos(); // Fetch videos for the default subgroup
      } catch (e) {
        errorMessage.value = 'Error parsing data';
      }
    } else {
      errorMessage.value = 'Error: ${response?.statusCode}';
    }

    isLoading.value = false;
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
    var selectedSubgroup = selectedGroup.subgroupId[selectedSubgroupIndex.value];

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
}
