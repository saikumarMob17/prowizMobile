// import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:prowiz/controllers/cameralist_controller.dart';
// import 'package:prowiz/screens/video_player.dart';
// import 'package:prowiz/utils/colors.dart';
// import 'package:prowiz/utils/custom_text.dart';
// import 'package:prowiz/utils/images.dart';
// import 'package:prowiz/utils/strings.dart';
//
//
// class HomeScreen1 extends StatelessWidget {
//   const HomeScreen1({super.key, required this.controller});
//
//   final NotchBottomBarController controller;
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     final cameraListController = Get.put(CameraListController());
//
//
//     final List<String> listOfItems = [
//       "Library",
//       "Play Area",
//       "Play Group",
//       "COMMON AREAS",
//     ];
//
//
//     return SafeArea(
//         child: Scaffold(
//           backgroundColor: ConstantColors.primaryColor,
//           body: Obx(() => SingleChildScrollView(
//             child: SizedBox(
//               height: Get.height,
//               width: Get.width,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(
//                     height: 50,
//                   ),
//                   locationCodeWidget(cameraListController),
//                   const SizedBox(
//                     height: 28,
//                   ),
//                   Visibility(
//                     visible: false,
//                     child: ExpansionTile(
//                       initiallyExpanded: true,
//                       //dense: true,
//                       collapsedTextColor: Colors.yellow,
//
//
//                       iconColor: ConstantColors.whiteColor,
//                       collapsedShape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(24),
//                           side: const BorderSide(
//                               color: ConstantColors.loginButtonColor)),
//                       shape:  RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(24),
//                           side: const BorderSide(
//                               color: Colors.white
//                           )
//                       ),
//                       collapsedBackgroundColor: ConstantColors.buttonColor,
//                       collapsedIconColor: ConstantColors.whiteColor,
//                       tilePadding: EdgeInsets.zero,
//
//                       title: const Text(
//                         "Center",
//                         style:
//                         TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                       ),
//                       children: listOfItems.map((e) {
//                         return ListTile(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(42),
//                             // side:const BorderSide(color: ConstantColors.buttonColor)
//                           ),
//                           onTap: () {
//                             // setState(() {
//                             //   _videoPlayerController.value.isPlaying
//                             //       ? _videoPlayerController.pause()
//                             //       : _videoPlayerController.play();
//                             // });
//                           },
//                           title: CustomTextWidget(
//                             text: e.toString(),
//                             fontWeight: FontWeight.w600,
//                             size: 16,
//                             color: ConstantColors.whiteColor,
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                   Visibility(
//                     visible: false,
//                     child: Expanded(
//                       child: GridView.builder(
//                           physics: const NeverScrollableScrollPhysics(),
//                           itemCount: 4,
//                           shrinkWrap: true,
//                           gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisSpacing: 27,
//                               mainAxisSpacing: 34,
//                               crossAxisCount: 2),
//                           itemBuilder: (context, int index) {
//                             return InkWell(
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => VideoScreen()));
//                                 //chewieController.enterFullScreen();
//                               },
//                               child: Stack(
//                                 alignment: Alignment.center,
//                                 fit: StackFit.expand,
//                                 children: [
//                                   Image.asset(ConstantImages.homeImage),
//                                   const Positioned(
//                                     left: 0,
//                                     right: 0,
//                                     top: 0,
//                                     bottom: 0,
//                                     child: Icon(
//                                       Icons.play_arrow,
//                                       color: Colors.white,
//                                       size: 36,
//                                     ),
//                                   ),
//                                 ],
//
//                                 /*return GestureDetector(
//                                   onTap: () {
//                                     chewieController.enterFullScreen();
//
//                                   },*/
//
//                                 /* child: Container(
//                                     height: 89,
//                                     width: 116,
//                                     decoration: BoxDecoration(
//                                       border: Border.all(
//                                           color: ConstantColors.whiteColor, width: 1),
//                                     ),
//
//                                     child:  _videoPlayerController.value.isInitialized
//                                         ? AspectRatio(
//                                             aspectRatio:
//                                                 _videoPlayerController.value.aspectRatio,
//                                             child: VideoPlayer(_videoPlayerController),
//                                           )
//                                         : const SizedBox(),
//                                   ),*/
//                               ),
//                             );
//                           }),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           )),
//         ),
//     );
//   }
//
//
//   locationCodeWidget(CameraListController cameraListController) {
//
//     return Column(
//       children: [
//         TextFormField(
//           controller: ,
//         )
//       ],
//
//     );
//
//
//   }
// }
//
