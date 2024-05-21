import 'package:flutter/material.dart';
import 'package:prowiz/screens/home_screen.dart';
import 'package:prowiz/screens/login_screen.dart';
import 'package:prowiz/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }

  // ThemeData _buildTheme(Brightness dark) {
  //   var baseTheme = ThemeData(brightness: dark);
  //
  //   return baseTheme.copyWith(
  //     textTheme: GoogleFonts.robotoTextTheme(baseTheme.textTheme),
  //   );
  // }
}
