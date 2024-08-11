import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:prowiz/utils/colors.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({this.color, this.size = 30, Key? key}) : super(key: key);

  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      color: color ?? ConstantColors.whiteColor,
      size: size,
    );
  }
}
