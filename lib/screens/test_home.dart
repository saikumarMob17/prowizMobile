import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:prowiz/screens/test_screen.dart';
import 'package:prowiz/utils/colors.dart';
import 'package:prowiz/utils/custom_text.dart';
import 'package:prowiz/utils/images.dart';
import 'package:prowiz/utils/strings.dart';
import 'package:video_player/video_player.dart';


class HomeScreen1 extends StatelessWidget {
  const HomeScreen1({super.key});

  @override
  Widget build(BuildContext context) {


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


    return SafeArea(
        child: Scaffold(
          body: Padding(
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
    );
  }
}



//
// class CenterScreen extends StatefulWidget {
//   @override
//   _CenterScreenState createState() => _CenterScreenState();
// }
//
// class _CenterScreenState extends State<CenterScreen> {
//   String dropdownValue = 'Class';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         toolbarHeight: 0,
//       ),
//       body: Container(
//         color: Color(0xFF002C4F),
//         padding: EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 10),
//             Text(
//               'Center',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 10),
//             DropdownButton<String>(
//               value: dropdownValue,
//               icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
//               iconSize: 16,
//               elevation: 16,
//               style: TextStyle(color: Colors.white),
//               dropdownColor: Color(0xFF004080),
//               underline: Container(
//                 height: 2,
//                 color: Colors.transparent,
//               ),
//               onChanged: (String? newValue) {
//                 setState(() {
//                   dropdownValue = newValue ?? "";
//                 });
//               },
//               items: <String>['Class', 'Library', 'Play Area', 'Playgroup', 'COMMON ARES']
//                   .map<DropdownMenuItem<String>>((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//             ),
//             Expanded(
//               child: ListView(
//                 children: [
//                   VideoThumbnail(time: '10:24 AM'),
//                   VideoThumbnail(time: '12:00 PM'),
//                   VideoThumbnail(time: '1:30 PM'),
//                   VideoThumbnail(time: '5:45 PM'),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Color(0xFF002C4F),
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.white,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: '',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: '',
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class VideoThumbnail extends StatelessWidget {
//   final String time;
//
//   VideoThumbnail({required this.time});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 10),
//       child: Column(
//         children: [
//           Image.network(
//             'https://via.placeholder.com/150',
//             height: 150,
//             width: double.infinity,
//             fit: BoxFit.cover,
//           ),
//           SizedBox(height: 5),
//           Text(
//             time,
//             style: TextStyle(color: Colors.white),
//           ),
//         ],
//       ),
//     );
//   }
// }
