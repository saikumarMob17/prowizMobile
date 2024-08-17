import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';


class VideoScreen extends StatelessWidget {

  VideoScreen({required this.url});


 final String url;


  @override
  Widget build(BuildContext context) {

    final String decodedUrl = Uri.decodeComponent(url);

    return Scaffold(
      appBar: AppBar(
        title: const Text('HLS Video Player'),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: BetterPlayer.network(
            decodedUrl,
            betterPlayerConfiguration: const BetterPlayerConfiguration(
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



