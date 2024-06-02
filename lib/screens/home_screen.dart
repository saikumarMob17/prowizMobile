import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:prowiz/utils/colors.dart';
import 'package:prowiz/utils/custom_text.dart';
import 'package:prowiz/utils/strings.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> listOfItems = [
    "Library",
    "Play Area",
    "Play Group",
    "COMMON AREAS",
  ];
  String? selectedValue;
  int currentPageIndex = 0;

  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ConstantColors.primaryColor,
        bottomNavigationBar: NavigationBar(
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: "Home"),
            NavigationDestination(icon: Icon(Icons.settings), label: "Home"),
            NavigationDestination(
                icon: Icon(Icons.account_circle), label: "Home"),
          ],
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const CustomTextWidget(
                  text: Constants.previews,
                  color: ConstantColors.whiteColor,
                  size: 20,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 28,
                ),
                ExpansionTile(
                  initiallyExpanded: true,
                  dense: true,
                  collapsedTextColor: Colors.yellow,
                  iconColor: ConstantColors.whiteColor,
                  collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(42),
                      side: const BorderSide(
                          color: ConstantColors.loginButtonColor)),
                  shape: const RoundedRectangleBorder(side: BorderSide.none),
                  collapsedBackgroundColor: ConstantColors.buttonColor,
                  collapsedIconColor: ConstantColors.whiteColor,
                  title: const CustomTextWidget(
                    text: "Class",
                    fontWeight: FontWeight.w600,
                    size: 16,
                    color: ConstantColors.whiteColor,
                  ),
                  children: listOfItems.map((e) {
                    return ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(42),
                        // side:const BorderSide(color: ConstantColors.buttonColor)
                      ),
                      onTap: () {
                        setState(() {
                          _videoPlayerController.value.isPlaying
                              ? _videoPlayerController.pause()
                              : _videoPlayerController.play();
                        });
                      },
                      title: CustomTextWidget(
                        text: e.toString(),
                        fontWeight: FontWeight.w600,
                        size: 16,
                        color: ConstantColors.whiteColor,
                      ),
                    );
                  }).toList(),
                ),
                GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 27,
                            mainAxisSpacing: 34,
                            crossAxisCount: 2),
                    itemBuilder: (context, int index) {
                      return GestureDetector(
                        onTap: () {

                        },
                        child: Container(
                          height: 89,
                          width: 116,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: ConstantColors.whiteColor, width: 1),
                          ),
                          child: _videoPlayerController.value.isInitialized
                              ? AspectRatio(
                                  aspectRatio:
                                      _videoPlayerController.value.aspectRatio,
                                  child: VideoPlayer(_videoPlayerController),
                                )
                              : const SizedBox(),
                        ),
                      );
                    })
              ],
            ),
          ),
        ));
  }
}
