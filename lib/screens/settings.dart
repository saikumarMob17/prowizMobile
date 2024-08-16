import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prowiz/controllers/cameralist_controller.dart';
import 'package:prowiz/screens/video_player.dart';
import 'dart:convert';

import 'package:prowiz/utils/storage_utils.dart';


import 'package:flutter/material.dart';
import 'package:get/get.dart';

// CameraScreen({super.key, required this.controller1});
//
// final NotchBottomBarController controller1;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CameraScreen extends StatelessWidget {


  CameraScreen({super.key, required this.controller1});

final NotchBottomBarController controller1;

  final CamerasController controller = Get.put(CamerasController());
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cameras')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: textController,
              onChanged: (value){

                controller.camerasList.clear();
                controller.videosList.clear();

              },
              decoration: const InputDecoration(
                labelText: 'Enter Location Code',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (textController.text.isNotEmpty) {
                controller.fetchCameras(textController.text);
              } else {
                controller.errorMessage.value = 'Please enter a location code';
              }
            },
            child: const Text('Submit'),
          ),
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.errorMessage.value.isNotEmpty) {
              return Center(child: Text(controller.errorMessage.value));
            }

            if (controller.camerasList.isEmpty) {
              return const Center(child: Text('No cameras found'));
            }

            return DropdownButton<String>(
              hint: const Text('Select Group ID'),
              value: controller.selectedGroupId.value.isEmpty ? null : controller.selectedGroupId.value,
              items: controller.camerasList.map((c) {
                return DropdownMenuItem<String>(
                  value: c.groupId,
                  child: Text(c.groupId),
                );
              }).toList(),
              onChanged: (value) {
                controller.selectedGroupId.value = value!;
                controller.selectedSubgroupId.value = '';
                // Clear videos when group changes
                controller.videosList.clear();
              },
            );
          }),
          Obx(() {
            if (controller.selectedGroupId.value.isEmpty) return const SizedBox.shrink();

            final group = controller.camerasList
                .firstWhere((c) => c.groupId == controller.selectedGroupId.value);

            return Expanded(
              child: ListView(
                children: group.subgroupId.map((subgroup) {
                  return ExpansionTile(
                    title: Text(subgroup.subgroupId),
                    children: subgroup.url.map((url) {
                      return ListTile(
                        title: Text(url.name),
                        onTap: () {
                          controller.selectedSubgroupId.value = subgroup.subgroupId;
                          controller.fetchVideos(controller.selectedGroupId.value, subgroup.subgroupId);
                        },
                      );
                    }).toList(),
                  );
                }).toList(),
              ),
            );
          }),
          Obx(() {
            if (controller.videosList.isEmpty) return const SizedBox.shrink();

            return Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: controller.videosList.length,
                itemBuilder: (context, index) {
                  final video = controller.videosList[index];
                  return Stack(
                    children: [
                      VideoScreen(url: video.url,),
                      const Positioned.fill(
                        child: Icon(Icons.play_arrow, color: Colors.white, size: 36),
                      ),
                    ],
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
