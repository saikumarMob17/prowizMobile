import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  @override
  _CustomVideoPlayerState createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    _controller = VideoPlayerController.networkUrl(Uri.parse(
      "https://assets.mixkit.co/videos/preview/mixkit-spinning-around-the-earth-29351-large.mp4",
    ));
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: true,
      looping: true,
      aspectRatio: 2.2,
      customControls: CustomMaterialControls(),
      showControlsOnInitialize: true,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Chewie(
          controller: _chewieController,
        ),
      ),
    );
  }
}

class CustomMaterialControls extends StatefulWidget {
  @override
  _CustomMaterialControlsState createState() => _CustomMaterialControlsState();
}

class _CustomMaterialControlsState extends State<CustomMaterialControls> {
  @override
  Widget build(BuildContext context) {
    final chewieController = ChewieController.of(context);

    return Container(
      color: Colors.black26,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _buildPlayPause(chewieController),
          _buildProgressBar(chewieController),
          _buildBottomBar(chewieController),
        ],
      ),
    );
  }

  Widget _buildPlayPause(ChewieController chewieController) {
    return IconButton(
      icon: Icon(
        chewieController.isPlaying ? Icons.pause : Icons.play_arrow,
        color: Colors.white,
        size: 30.0,
      ),
      onPressed: () {
        setState(() {
          chewieController.isPlaying
              ? chewieController.pause()
              : chewieController.play();
        });
      },
    );
  }

  Widget _buildProgressBar(ChewieController chewieController) {
    return VideoProgressIndicator(
      chewieController.videoPlayerController,
      allowScrubbing: true,
    );
  }

  Widget _buildBottomBar(ChewieController chewieController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.fast_rewind,
            color: Colors.white,
            size: 30.0,
          ),
          onPressed: () {
            final newPosition =
                chewieController.videoPlayerController.value.position -
                    const Duration(seconds: 10);
            chewieController.videoPlayerController.seekTo(newPosition);
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.fast_forward,
            color: Colors.white,
            size: 30.0,
          ),
          onPressed: () {
            final newPosition =
                chewieController.videoPlayerController.value.position +
                    const Duration(seconds: 10);
            chewieController.videoPlayerController.seekTo(newPosition);
          },
        ),
        // Add more controls as needed
      ],
    );
  }
}
