import 'package:flutter/material.dart';
import 'package:prowiz/utils/colors.dart';

class CustomTextWidget extends StatelessWidget {
  final Color? color;
  final String text;
  final double? size;
  final FontWeight? fontWeight;
  final double? wordSpacing;
  final VoidCallback? voidCallback;
  const CustomTextWidget(
      {super.key,
      required this.text,
      this.color,
      this.fontWeight,
      this.size,
      this.wordSpacing,
      this.voidCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: voidCallback == null
          ? Text(
              text,
              style: TextStyle(
                fontSize: size ?? 12,
                fontWeight: fontWeight ?? FontWeight.normal,
                color: color ?? ConstantColors.blackColor,
                wordSpacing: wordSpacing ?? 0,
              ),
            )
          : TextButton(
              onPressed: voidCallback,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: size ?? 12,
                  fontWeight: fontWeight ?? FontWeight.normal,
                  color: color ?? ConstantColors.blackColor,
                  wordSpacing: wordSpacing ?? 0,
                ),
              )),
    );
  }
}
