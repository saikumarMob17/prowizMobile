import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prowiz/screens/account.dart';
import 'package:prowiz/screens/settings.dart';
import 'package:prowiz/screens/test_home.dart';
import 'package:prowiz/screens/test_screen.dart';
import 'package:prowiz/utils/colors.dart';
import 'package:prowiz/utils/custom_text.dart';
import 'package:prowiz/utils/images.dart';
import 'package:prowiz/utils/strings.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _pageController = PageController(initialPage: 0);

  final NotchBottomBarController _controller = NotchBottomBarController(index: 0);

  int maxCount =3;

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

    initializePlayer();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
      "https://assets.mixkit.co/videos/preview/mixkit-spinning-around-the-earth-29351-large.mp4",
    ));

    await Future.wait([
      _videoPlayerController.initialize(),
    ]);
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    final subtitles = [
      Subtitle(
          index: 0,
          start: Duration.zero,
          end: const Duration(seconds: 10),
          text: const TextSpan(
              text: "Hello", style: TextStyle(color: Colors.red))),
    ];

    chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        looping: true,
        progressIndicatorDelay: bufferDelay != null
            ? Duration(milliseconds: bufferDelay ?? 0)
            : null,
        subtitle: Subtitles(subtitles),
        hideControlsTimer: const Duration(seconds: 1),
        subtitleBuilder: (context, dynamic subtitle) => Container(
              padding: const EdgeInsets.all(10),
              child: subtitles is InlineSpan
                  ? RichText(text: subtitle)
                  : Text(
                      subtitle.toString(),
                      style: const TextStyle(color: ConstantColors.whiteColor),
                    ),
            ));
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


    final List<Widget> bottomBarPages =[


      HomeScreen1(),
      const SettingScreen(),
      const AccountScreen(),




    ];





    return Scaffold(
        backgroundColor: ConstantColors.primaryColor,

        // bottomNavigationBar: NavigationBar(
        //   destinations: const [
        //     NavigationDestination(icon: Icon(Icons.home), label: "Home"),
        //     NavigationDestination(icon: Icon(Icons.settings), label: "Home"),
        //     NavigationDestination(
        //         icon: Icon(Icons.account_circle), label: "Home"),
        //   ],
        //   onDestinationSelected: (int index) {
        //     setState(() {
        //       currentPageIndex = index;
        //     });
        //   },
        // ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const CustomTextWidget(
                    text: Constants.provideText,
                    color: ConstantColors.whiteColor,
                    size: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  ExpansionTile(
                    initiallyExpanded: true,
                    //dense: true,
                    collapsedTextColor: Colors.yellow,


                    iconColor: ConstantColors.whiteColor,
                    collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                        side: const BorderSide(
                            color: ConstantColors.loginButtonColor)),
                    shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                      side: const BorderSide(
                        color: Colors.white
                      )
                    ),
                    collapsedBackgroundColor: ConstantColors.buttonColor,
                    collapsedIconColor: ConstantColors.whiteColor,
                    tilePadding: EdgeInsets.zero,

                    title: const Text(
                      "Center",
                      style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    children: listOfItems.map((e) {
                      return ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(42),
                          // side:const BorderSide(color: ConstantColors.buttonColor)
                        ),
                        onTap: () {
                          // setState(() {
                          //   _videoPlayerController.value.isPlaying
                          //       ? _videoPlayerController.pause()
                          //       : _videoPlayerController.play();
                          // });
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
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CustomVideoPlayer()));
                            //chewieController.enterFullScreen();
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            fit: StackFit.expand,
                            children: [
                              Image.asset(ConstantImages.homeImage),
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

                            /*return GestureDetector(
                            onTap: () {
                              chewieController.enterFullScreen();

                            },*/

                            /* child: Container(
                              height: 89,
                              width: 116,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: ConstantColors.whiteColor, width: 1),
                              ),

                              child:  _videoPlayerController.value.isInitialized
                                  ? AspectRatio(
                                      aspectRatio:
                                          _videoPlayerController.value.aspectRatio,
                                      child: VideoPlayer(_videoPlayerController),
                                    )
                                  : const SizedBox(),
                            ),*/
                          ),
                        );
                      })
                ],
              ),
            ),
          ),
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
