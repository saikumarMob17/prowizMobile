import 'dart:developer';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prowiz/screens/account.dart';
import 'package:prowiz/screens/settings.dart';
import 'package:prowiz/screens/tab1.dart';
import 'package:prowiz/utils/colors.dart';
import 'package:prowiz/utils/custom_text.dart';
import 'package:prowiz/utils/global_theme.dart';
import 'package:prowiz/utils/images.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageController = PageController(initialPage: 0);

  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 0);

  int maxCount = 2;

  final List<String> listOfItems = [
    "Library",
    "Play Area",
    "Play Group",
    "COMMON AREAS",
  ];
  String? selectedValue;
  int currentPageIndex = 0;

  late ChewieController chewieController;
  late VideoPlayerController _videoPlayerController;
  int? bufferDelay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoPlayerController.dispose();
    chewieController.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final themeController = Get.find<ThemeController>();

    final List<Widget> bottomBarPages = [
      CameraScreen(
        controller1: _controller,
      ),
      //  const SettingScreen(),
      AccountScreen(
        controller: _controller,
      ),
    ];

    return Obx(() => Scaffold(
      backgroundColor: themeController.isDarkMode.value ? ConstantColors.blackColor : ConstantColors.primaryColor,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
        /// Provide NotchBottomBarController
        notchBottomBarController: _controller,
        color: ConstantColors.loginButtonColor,
        showLabel: true,
        textOverflow: TextOverflow.visible,
        maxLine: 1,
        shadowElevation: 5,
        kBottomRadius: 28.0,
        notchColor: Colors.transparent,

        /// restart app if you change removeMargins
        removeMargins: false,
        //bottomBarWidth: 300,
        showShadow: false,

        durationInMilliSeconds: 300,

        itemLabelStyle: const TextStyle(fontSize: 10),

        elevation: 1,
        bottomBarItems: [
          BottomBarItem(
              inActiveItem: Image.asset(ConstantImages.bottomNavIcon1),
              activeItem: Image.asset(ConstantImages.bottomNavIcon1),
              itemLabelWidget: const CustomTextWidget(
                text: "Home",
                color: ConstantColors.whiteColor,
                size: 12,
                fontWeight: FontWeight.w400,
              )),
          BottomBarItem(
              inActiveItem: Image.asset(ConstantImages.bottomNavIcon2),
              activeItem: Image.asset(ConstantImages.bottomNavIcon2),
              itemLabelWidget: const CustomTextWidget(
                text: "Account",
                color: ConstantColors.whiteColor,
                size: 12,
                fontWeight: FontWeight.w400,
              )),
        ],
        onTap: (index) {
          log('current selected index $index');
          _pageController.jumpToPage(index);
        },
        kIconSize: 24.0,
      )
          : null,

      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),

      // body: SafeArea(
      //   child: SingleChildScrollView(
      //     child: Padding(
      //       padding: const EdgeInsets.all(50.0),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           const SizedBox(
      //             height: 50,
      //           ),
      //           const CustomTextWidget(
      //             text: Constants.provideText,
      //             color: ConstantColors.whiteColor,
      //             size: 20,
      //             fontWeight: FontWeight.bold,
      //           ),
      //           const SizedBox(
      //             height: 28,
      //           ),
      //           ExpansionTile(
      //             initiallyExpanded: true,
      //             //dense: true,
      //             collapsedTextColor: Colors.yellow,
      //
      //             iconColor: ConstantColors.whiteColor,
      //             collapsedShape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(24),
      //                 side: const BorderSide(
      //                     color: ConstantColors.loginButtonColor)),
      //             shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(24),
      //                 side: const BorderSide(color: Colors.white)),
      //             collapsedBackgroundColor: ConstantColors.buttonColor,
      //             collapsedIconColor: ConstantColors.whiteColor,
      //             tilePadding: EdgeInsets.zero,
      //
      //             title: const Text(
      //               "Center",
      //               style: TextStyle(
      //                   color: Colors.white, fontWeight: FontWeight.bold),
      //             ),
      //             children: listOfItems.map((e) {
      //               return ListTile(
      //                 shape: RoundedRectangleBorder(
      //                   borderRadius: BorderRadius.circular(42),
      //                   // side:const BorderSide(color: ConstantColors.buttonColor)
      //                 ),
      //                 onTap: () {
      //                   // setState(() {
      //                   //   _videoPlayerController.value.isPlaying
      //                   //       ? _videoPlayerController.pause()
      //                   //       : _videoPlayerController.play();
      //                   // });
      //                 },
      //                 title: CustomTextWidget(
      //                   text: e.toString(),
      //                   fontWeight: FontWeight.w600,
      //                   size: 16,
      //                   color: ConstantColors.whiteColor,
      //                 ),
      //               );
      //             }).toList(),
      //           ),
      //           GridView.builder(
      //               physics: const NeverScrollableScrollPhysics(),
      //               itemCount: 4,
      //               shrinkWrap: true,
      //               gridDelegate:
      //                   const SliverGridDelegateWithFixedCrossAxisCount(
      //                       crossAxisSpacing: 27,
      //                       mainAxisSpacing: 34,
      //                       crossAxisCount: 2),
      //               itemBuilder: (context, int index) {
      //                 return InkWell(
      //                   onTap: () {
      //                     Navigator.push(
      //                         context,
      //                         MaterialPageRoute(
      //                             builder: (context) => CustomVideoPlayer()));
      //                     //chewieController.enterFullScreen();
      //                   },
      //                   child: Stack(
      //                     alignment: Alignment.center,
      //                     fit: StackFit.expand,
      //                     children: [
      //                       Image.asset(ConstantImages.homeImage),
      //                       const Positioned(
      //                         left: 0,
      //                         right: 0,
      //                         top: 0,
      //                         bottom: 0,
      //                         child: Icon(
      //                           Icons.play_arrow,
      //                           color: Colors.white,
      //                           size: 36,
      //                         ),
      //                       ),
      //                     ],
      //
      //                     /*return GestureDetector(
      //                     onTap: () {
      //                       chewieController.enterFullScreen();
      //
      //                     },*/
      //
      //                     /* child: Container(
      //                       height: 89,
      //                       width: 116,
      //                       decoration: BoxDecoration(
      //                         border: Border.all(
      //                             color: ConstantColors.whiteColor, width: 1),
      //                       ),
      //
      //                       child:  _videoPlayerController.value.isInitialized
      //                           ? AspectRatio(
      //                               aspectRatio:
      //                                   _videoPlayerController.value.aspectRatio,
      //                               child: VideoPlayer(_videoPlayerController),
      //                             )
      //                           : const SizedBox(),
      //                     ),*/
      //                   ),
      //                 );
      //               })
      //         ],
      //       ),
      //     ),
      //   ),
      // )
    ));
  }

  _buildClassListTile(BuildContext context, String title,
      {required VoidCallback onPressed}) {
    return Container(
      decoration: const BoxDecoration(
        color: ConstantColors.loginButtonColor,
      ),
      child: ListTile(
        title: Text(
          title,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
