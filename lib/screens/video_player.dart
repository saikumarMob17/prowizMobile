import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';


class VideoScreen extends StatelessWidget {

  VideoScreen({required this.url});


 final String url;


  @override
  Widget build(BuildContext context) {
    // The encoded HLS URL

    // Decode the URL
    final String decodedUrl = Uri.decodeComponent(url);

    return Scaffold(
      appBar: AppBar(
        title: Text('HLS Video Player'),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: BetterPlayer.network(
            decodedUrl,
            betterPlayerConfiguration: BetterPlayerConfiguration(
              fit: BoxFit.cover,

              aspectRatio: 16 / 9,

              autoPlay: true,
              looping: true,

            ),
          ),
        ),
      ),
    );
  }
}


// class CustomVideoPlayer extends StatefulWidget {
//   @override
//   _CustomVideoPlayerState createState() => _CustomVideoPlayerState();
// }
//
// class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
//   late VideoPlayerController _controller;
//   late ChewieController _chewieController;
//
//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeRight,
//       DeviceOrientation.landscapeLeft,
//     ]);
//     _controller = VideoPlayerController.networkUrl(Uri.parse(
//       "https%3A%2F%2Fdpb0aqku1cqs2.cloudfront.net%2Fklayneocloud%2FInfantV1c7be41d9-f798-431b-91ca-0231e7a54c98.stream%2Fplaylist.m3u8%3FrandomTokenPrefixstarttime%3D1723817336.722%26randomTokenPrefixendtime%3D1731017.336%26randomTokenPrefixCustomParameter%3Dpeppersalt%26randomTokenPrefixhash%3D-ZsRoyGpVUOdguRiHuITy2z5qvUGdn3sR48ijp4QBTM%3D",
//     ));
//     _chewieController = ChewieController(
//       videoPlayerController: _controller,
//       autoPlay: true,
//       looping: true,
//       aspectRatio: 2.2,
//       customControls: CustomMaterialControls(),
//       showControlsOnInitialize: true,
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     _chewieController.dispose();
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Expanded(
//         child: Chewie(
//           controller: _chewieController,
//         ),
//       ),
//     );
//   }
// }
//
// class CustomMaterialControls extends StatefulWidget {
//   @override
//   _CustomMaterialControlsState createState() => _CustomMaterialControlsState();
// }
//
// class _CustomMaterialControlsState extends State<CustomMaterialControls> {
//   @override
//   Widget build(BuildContext context) {
//     final chewieController = ChewieController.of(context);
//
//     return Container(
//       color: Colors.black26,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: <Widget>[
//           _buildPlayPause(chewieController),
//           _buildProgressBar(chewieController),
//           _buildBottomBar(chewieController),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPlayPause(ChewieController chewieController) {
//     return IconButton(
//       icon: Icon(
//         chewieController.isPlaying ? Icons.pause : Icons.play_arrow,
//         color: Colors.white,
//         size: 30.0,
//       ),
//       onPressed: () {
//         setState(() {
//           chewieController.isPlaying
//               ? chewieController.pause()
//               : chewieController.play();
//         });
//       },
//     );
//   }
//
//   Widget _buildProgressBar(ChewieController chewieController) {
//     return VideoProgressIndicator(
//       chewieController.videoPlayerController,
//       allowScrubbing: true,
//     );
//   }
//
//   Widget _buildBottomBar(ChewieController chewieController) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: <Widget>[
//         IconButton(
//           icon: const Icon(
//             Icons.fast_rewind,
//             color: Colors.white,
//             size: 30.0,
//           ),
//           onPressed: () {
//             final newPosition =
//                 chewieController.videoPlayerController.value.position -
//                     const Duration(seconds: 10);
//             chewieController.videoPlayerController.seekTo(newPosition);
//           },
//         ),
//         IconButton(
//           icon: const Icon(
//             Icons.fast_forward,
//             color: Colors.white,
//             size: 30.0,
//           ),
//           onPressed: () {
//             final newPosition =
//                 chewieController.videoPlayerController.value.position +
//                     const Duration(seconds: 10);
//             chewieController.videoPlayerController.seekTo(newPosition);
//           },
//         ),
//         // Add more controls as needed
//       ],
//     );
//   }
// }
