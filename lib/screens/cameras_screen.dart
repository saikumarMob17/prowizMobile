import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:prowiz/controllers/cameralist_controller.dart';
import 'package:prowiz/controllers/login_controller.dart';
import 'package:prowiz/screens/splash_screen.dart';
import 'package:prowiz/screens/video_player.dart';
import 'package:prowiz/utils/colors.dart';
import 'package:get/get.dart';
import 'package:prowiz/utils/custom_text.dart';
import 'package:prowiz/utils/global_theme.dart';
import 'package:prowiz/utils/images.dart';
import 'package:prowiz/utils/strings.dart';

class CameraScreen extends StatelessWidget {
  CameraScreen({super.key, required this.controller1});

  final NotchBottomBarController controller1;

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    final LoginController camerasController = Get.find<LoginController>();

    Future<bool> _onWillPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Are you sure?'),
              content: const Text('Do you want to exit an App'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () => exit(0),
                  child: const Text('Yes'),
                ),
              ],
            ),
          )) ??
          false;
    }

    return Obx(() {
      return WillPopScope(
        onWillPop: _onWillPop,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: themeController.isDarkMode.value
                ? ConstantColors.blackColor
                : ConstantColors.primaryColor,
            body: camerasController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Container(
                      height: Get.height,
                      width: Get.width,
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            ConstantImages.logo,
                            height: Get.width * 0.2,
                            width: Get.width * 0.2,
                          ),
                          TextField(
                            controller: camerasController.locationController,
                            readOnly: true,
                            textInputAction: TextInputAction.done,
                            onSubmitted: (value) {
                              FocusScope.of(context).unfocus();
                            },
                            autofocus: true,
                            decoration: const InputDecoration(
                              //labelText: Constants.enterLocationCode,
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ConstantColors.textFieldColor),
                              ),
                            ),
                            style: const TextStyle(color: Colors.white),
                            onChanged: (value) {
                              camerasController.locationCode.value = value;
                              camerasController.update();
                            },
                          ),
                          const SizedBox(height: 16),
                          const SizedBox(height: 16),
                          Obx(() {
                            if (camerasController.camerasList.isNotEmpty) {
                              if (camerasController.subgroups.isNotEmpty) {
                                return Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const CustomTextWidget(
                                        text: "Group ",
                                        color: ConstantColors.whiteColor,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 8.0),
                                        decoration: BoxDecoration(
                                          color: ConstantColors.buttonColor,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: DropdownButton<int>(
                                          value: camerasController
                                              .selectedGroupIndex.value,
                                          onChanged: (int? newValue) {
                                            if (newValue != null) {
                                              camerasController
                                                  .selectedGroupIndex
                                                  .value = newValue;
                                              camerasController
                                                  .updateSubgroups();
                                              camerasController
                                                      .selectedSubgroupIndex
                                                      .value =
                                                  0; // Reset to first subgroup
                                              camerasController
                                                  .fetchSubgroupVideos(); // Fetch videos for the default subgroup
                                            }
                                          },
                                          dropdownColor: Colors.blue[800],
                                          iconEnabledColor: Colors.white,
                                          items: List.generate(
                                            camerasController
                                                .camerasList.length,
                                            (index) {
                                              log("Error message of ${camerasController.camerasList[index].message}");
                                              return DropdownMenuItem<int>(
                                                value: index,
                                                child: Text(
                                                  camerasController
                                                      .camerasList[index]
                                                      .groupId,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              );
                                            },
                                          ),
                                          isExpanded: true,
                                          underline: const SizedBox(),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      const CustomTextWidget(
                                        text: "Sub Group ",
                                        color: ConstantColors.whiteColor,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Obx(() {
                                        if (camerasController
                                            .subgroups.isNotEmpty) {
                                          return Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0,
                                                vertical: 8.0),
                                            decoration: BoxDecoration(
                                              color: ConstantColors.buttonColor,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: DropdownButton<int>(
                                              value: camerasController
                                                  .selectedSubgroupIndex.value,
                                              onChanged: (int? newValue) {
                                                if (newValue != null) {
                                                  camerasController
                                                      .selectedSubgroupIndex
                                                      .value = newValue;
                                                  camerasController
                                                      .fetchSubgroupVideos(); // Fetch videos for the selected subgroup
                                                }
                                              },
                                              dropdownColor: Colors.blue[800],
                                              iconEnabledColor: Colors.white,
                                              items: List.generate(
                                                camerasController
                                                    .subgroups.length,
                                                (index) =>
                                                    DropdownMenuItem<int>(
                                                  value: index,
                                                  child: Text(
                                                    camerasController
                                                        .subgroups[index]
                                                        .subgroupId,
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
                                        return camerasController
                                                .videoUrls.isEmpty
                                            ? const Center(
                                                child: CustomTextWidget(
                                                  text:
                                                      "No videos found for this camera. Please select another.",
                                                  color:
                                                      ConstantColors.whiteColor,
                                                ),
                                              )
                                            : Expanded(
                                                child: GridView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount: camerasController
                                                      .videoUrls.length,
                                                  shrinkWrap: true,
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisSpacing: 27,
                                                    mainAxisSpacing: 34,
                                                    crossAxisCount: 2,
                                                  ),
                                                  itemBuilder:
                                                      (context, index) {
                                                    final video =
                                                        camerasController
                                                            .videoUrls[index];
                                                    final title =
                                                        camerasController
                                                            .videoUrls[index];

                                                    log("Video URL is ===> ${video["url"]!}");
                                                    return InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        VideoScreen(
                                                                          url: video["url"] ??
                                                                              "",
                                                                          title:
                                                                              title['name'] ?? "",
                                                                        )));
                                                      },
                                                      child: Stack(
                                                        alignment:
                                                            Alignment.center,
                                                        fit: StackFit.expand,
                                                        children: [
                                                          Image.asset(
                                                              ConstantImages
                                                                  .homeImage),
                                                          const Positioned(
                                                            left: 0,
                                                            right: 0,
                                                            top: 0,
                                                            bottom: 0,
                                                            child: Icon(
                                                              Icons.play_arrow,
                                                              color:
                                                                  Colors.white,
                                                              size: 36,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                      }),
                                    ],
                                  ),
                                );
                              } else {
                                return const Center(
                                  child: CustomTextWidget(
                                    text:
                                        "No cameras found for this location code. Please select another.",
                                    color: ConstantColors.whiteColor,
                                  ),
                                );
                              }
                            }

                            if (camerasController.errorMessage.isNotEmpty) {
                              return Text(camerasController.errorMessage.value,
                                  style: const TextStyle(color: Colors.white));
                            }

                            return Container();
                          })
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      );
    });
  }
}
