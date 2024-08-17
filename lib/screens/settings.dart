import 'dart:developer';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:prowiz/controllers/cameralist_controller.dart';
import 'package:prowiz/models/cameras_list_model.dart';
import 'package:prowiz/screens/video_player.dart';
import 'package:prowiz/utils/colors.dart';

import 'package:get/get.dart';
import 'package:prowiz/utils/global_theme.dart';
import 'package:prowiz/utils/images.dart';
import 'package:prowiz/utils/strings.dart';

class CameraScreen extends StatelessWidget {
  CameraScreen({super.key, required this.controller1});

  final NotchBottomBarController controller1;
  final CamerasController camerasController = Get.put(CamerasController());
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() => SafeArea(
          child: Scaffold(
            backgroundColor: themeController.isDarkMode.value
                ? ConstantColors.blackColor
                : ConstantColors.primaryColor,
            body: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      labelText: Constants.enterLocationCode,
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) {
                      camerasController.locationCode.value = value;
                    },
                  ),
                  const SizedBox(height: 16),
                  Obx(() => ElevatedButton(
                        onPressed: camerasController.locationCode.value.isEmpty
                            ? null
                            : () {
                                camerasController.fetchCameras(
                                    camerasController.locationCode.value);
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ConstantColors.whiteColor

                        ),
                        child:  Text("Submit", ),
                      )),
                  const SizedBox(height: 16),
                  Obx(() {
                    if (camerasController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (camerasController.camerasList.isNotEmpty) {
                      return Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: DropdownButton<int>(
                                value:
                                    camerasController.selectedGroupIndex.value,
                                onChanged: (int? newValue) {
                                  if (newValue != null) {
                                    camerasController.selectedGroupIndex.value =
                                        newValue;
                                    camerasController.updateSubgroups();
                                    camerasController.selectedSubgroupIndex
                                        .value = 0; // Reset to first subgroup
                                    camerasController
                                        .fetchSubgroupVideos(); // Fetch videos for the default subgroup
                                  }
                                },
                                dropdownColor: Colors.blue[800],
                                iconEnabledColor: Colors.white,
                                items: List.generate(
                                  camerasController.camerasList.length,
                                  (index) => DropdownMenuItem<int>(
                                    value: index,
                                    child: Text(
                                      camerasController
                                          .camerasList[index].groupId,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                isExpanded: true,
                                underline: const SizedBox(),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Obx(() {
                              if (camerasController.subgroups.isNotEmpty) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: DropdownButton<int>(
                                    value: camerasController
                                        .selectedSubgroupIndex.value,
                                    onChanged: (int? newValue) {
                                      if (newValue != null) {
                                        camerasController.selectedSubgroupIndex
                                            .value = newValue;
                                        camerasController
                                            .fetchSubgroupVideos(); // Fetch videos for the selected subgroup
                                      }
                                    },
                                    dropdownColor: Colors.blue[800],
                                    iconEnabledColor: Colors.white,
                                    items: List.generate(
                                      camerasController.subgroups.length,
                                      (index) => DropdownMenuItem<int>(
                                        value: index,
                                        child: Text(
                                          camerasController
                                              .subgroups[index].subgroupId,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    isExpanded: true,
                                    underline: const SizedBox(),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }),
                            const SizedBox(height: 16),
                            Obx(() {
                              return Visibility(
                                visible: camerasController.videoUrls.isNotEmpty,
                                child: Expanded(
                                  child: GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        camerasController.videoUrls.length,
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 27,
                                      mainAxisSpacing: 34,
                                      crossAxisCount: 2,
                                    ),
                                    itemBuilder: (context, index) {
                                      final video =
                                          camerasController.videoUrls[index];

                                      log("Video URL is ===> ${video["url"]!}");
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      VideoScreen(
                                                        url: video["url"]!,
                                                      )));
                                        },
                                        child: Stack(
                                          alignment: Alignment.center,
                                          fit: StackFit.expand,
                                          children: [
                                            Image.asset(
                                                ConstantImages.homeImage),
                                            const Positioned(
                                              left: 0,
                                              right: 0,
                                              top: 0,
                                              bottom: 0,
                                              child: Icon(
                                                Icons.play_arrow,
                                                color: Colors.white,
                                                size: 36,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      );
                    }

                    if (camerasController.errorMessage.isNotEmpty) {
                      return Text(camerasController.errorMessage.value,
                          style: const TextStyle(color: Colors.white));
                    }

                    return Container();
                  }),
                ],
              ),
            ),
          ),
        ));
  }
}
