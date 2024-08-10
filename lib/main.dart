import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:prowiz/screens/splash_screen.dart';

void main() async{

  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class CenterMenu extends StatefulWidget {
  @override
  _CenterMenuState createState() => _CenterMenuState();
}

class _CenterMenuState extends State<CenterMenu> {
  String selectedItem = 'Play Area';

  void _onItemSelected(String item) {
    setState(() {
      selectedItem = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        _buildClassTile(context, 'Class', onPressed: () {
          _onItemSelected('Class');
        }),
        _buildListItem(context, 'Library', onPressed: () {
          _onItemSelected('Library');
        }),
        _buildListItem(context, 'Play Area',
            isHighlighted: selectedItem == 'Play Area', onPressed: () {
          _onItemSelected('Play Area');
        }),
        _buildListItem(context, 'Playgroup',
            isHighlighted: selectedItem == 'Playgroup', onPressed: () {
          _onItemSelected('Playgroup');
        }),
        _buildListItem(context, 'COMMON ARES',
            isHighlighted: selectedItem == 'COMMON ARES', onPressed: () {
          _onItemSelected('COMMON ARES');
        }),
      ],
    );
  }

  Widget _buildClassTile(BuildContext context, String title,
      {required VoidCallback onPressed}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: const Color(0xFF004275), // Blue background color
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing:
            const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
        onTap: onPressed,
      ),
    );
  }

  Widget _buildListItem(BuildContext context, String title,
      {bool isHighlighted = false, required VoidCallback onPressed}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: isHighlighted ? Colors.transparent : Colors.transparent,
        border: isHighlighted
            ? Border.all(color: Colors.cyanAccent, width: 1.0)
            : null,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: onPressed,
      ),
    );
  }
}
