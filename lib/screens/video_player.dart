import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prowiz/utils/colors.dart';
import 'package:prowiz/utils/custom_text.dart';


class VideoScreen extends StatelessWidget {

  VideoScreen({required this.url, required this.title});


 final String url;
 final String title;


  @override
  Widget build(BuildContext context) {

    final String decodedUrl = Uri.decodeComponent(url);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back_ios_new, color: ConstantColors.whiteColor,)),
        title: CustomTextWidget(text: title, color: ConstantColors.whiteColor,),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: BetterPlayer.network(

            decodedUrl,
            betterPlayerConfiguration:  const BetterPlayerConfiguration(
              fit: BoxFit.cover,
              autoDispose: true,
              autoDetectFullscreenAspectRatio: true,
              controlsConfiguration: BetterPlayerControlsConfiguration(
                enableProgressBar: false,
                playerTheme: BetterPlayerTheme.material,
                showControlsOnInitialize: false,
                  enableRetry: false,


                  // customControlsBuilder:
                  //               (controller, onControlsVisibilityChanged) =>
                  //               CustomControlsWidget(
                  //                 controller: controller,
                  //                 onControlsVisibilityChanged:
                  //                 onControlsVisibilityChanged,
                  //               ),
                          ),



              aspectRatio: 16 / 9,

              autoPlay: true,

              looping: false,

            ),
          ),
        ),
      ),
    );
  }
}


// class VideoScreen extends StatefulWidget {
//   final String url;
//
//   const VideoScreen({required this.url, Key? key}) : super(key: key);
//
//   @override
//   _ChangePlayerThemePageState createState() => _ChangePlayerThemePageState();
// }
//
// class _ChangePlayerThemePageState extends State<VideoScreen> {
//   late BetterPlayerController _betterPlayerController;
//   BetterPlayerDataSource? _dataSource;
//   BetterPlayerTheme _playerTheme = BetterPlayerTheme.material;
//
//   @override
//   void initState() {
//     super.initState();
//     _dataSource =
//         BetterPlayerDataSource(BetterPlayerDataSourceType.network, widget.url);
//     _betterPlayerController =  BetterPlayerController(
//       BetterPlayerConfiguration(
//         autoDispose: true,
//         controlsConfiguration: BetterPlayerControlsConfiguration(
//           playerTheme: _playerTheme,
//         ),
//       ),
//       betterPlayerDataSource: _dataSource,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Change player theme"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height: 8),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Text(
//                 "Player with the possibility to change the theme. Click on "
//                     "buttons below to change theme of player.",
//                 style: TextStyle(fontSize: 16),
//               ),
//             ),
//             BetterPlayer(
//               controller: _betterPlayerController,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//
//                 MaterialButton(
//                   child: Text("CUSTOM"),
//                   onPressed: () {
//                     setState(() {
//                       _playerTheme = BetterPlayerTheme.custom;
//                       _betterPlayerController.pause();
//                       _betterPlayerController =  BetterPlayerController(
//                         BetterPlayerConfiguration(
//                           autoDispose: true,
//                           controlsConfiguration:
//                           BetterPlayerControlsConfiguration(
//                             playerTheme: _playerTheme,
//                             customControlsBuilder:
//                                 (controller, onControlsVisibilityChanged) =>
//                                 CustomControlsWidget(
//                                   controller: controller,
//                                   onControlsVisibilityChanged:
//                                   onControlsVisibilityChanged,
//                                 ),
//                           ),
//                         ),
//                         betterPlayerDataSource: _dataSource,
//                       );
//                     });
//                   },
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
class CustomControlsWidget extends StatefulWidget {
  final BetterPlayerController? controller;
  final Function(bool visbility)? onControlsVisibilityChanged;

   CustomControlsWidget({
    Key? key,
    this.controller,
    this.onControlsVisibilityChanged,
  }) : super(key: key);

  @override
  _CustomControlsWidgetState createState() => _CustomControlsWidgetState();
}

class _CustomControlsWidgetState extends State<CustomControlsWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding:  const EdgeInsets.all(8.0),
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.purple.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      widget.controller!.isFullScreen
                          ? Icons.fullscreen_exit
                          : Icons.fullscreen,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
                onTap: () => setState(() {
                  if (widget.controller!.isFullScreen) {
                    widget.controller!.exitFullScreen();
                  } else {
                    widget.controller!.enterFullScreen();
                  }
                }),
              ),
            ),
          ),
          Padding(
            padding:  const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () async {
                          Duration? videoDuration = await widget
                              .controller!.videoPlayerController!.position;
                          setState(() {
                            if (widget.controller!.isPlaying()!) {
                              Duration rewindDuration = Duration(
                                  seconds: (videoDuration!.inSeconds - 2));
                              if (rewindDuration <
                                  widget.controller!.videoPlayerController!
                                      .value.duration!) {
                                widget.controller!.seekTo(const Duration(seconds: 0));
                              } else {
                                widget.controller!.seekTo(rewindDuration);
                              }
                            }
                          });
                        },
                        child: const Icon(
                          Icons.fast_rewind,
                          color: Colors.white,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (widget.controller!.isPlaying()!)
                              widget.controller!.pause();
                            else
                              widget.controller!.play();
                          });
                        },
                        child: Icon(
                          widget.controller!.isPlaying()!
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          Duration? videoDuration = await widget
                              .controller!.videoPlayerController!.position;
                          setState(() {
                            if (widget.controller!.isPlaying()!) {
                              Duration forwardDuration = Duration(
                                  seconds: (videoDuration!.inSeconds + 2));
                              if (forwardDuration >
                                  widget.controller!.videoPlayerController!
                                      .value.duration!) {
                                widget.controller!.seekTo(const Duration(seconds: 0));
                                widget.controller!.pause();
                              } else {
                                widget.controller!.seekTo(forwardDuration);
                              }
                            }
                          });
                        },
                        child: const Icon(
                          Icons.fast_forward,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

