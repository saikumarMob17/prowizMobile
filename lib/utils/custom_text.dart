import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prowiz/utils/colors.dart';

class CustomTextWidget extends StatelessWidget {
  final Color? color;
  final String text;
  final double? size;
  final FontWeight? fontWeight;
  final double? wordSpacing;
  final TextDecoration? decoration;
  final VoidCallback? voidCallback;
  final TextAlign? textAlign;
  const CustomTextWidget(
      {super.key,
      required this.text,
      this.color,
      this.fontWeight,
      this.textAlign,
      this.size,
      this.decoration,
      this.wordSpacing,
      this.voidCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: voidCallback == null
          ? Text(
              text,
              textAlign: textAlign ?? TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: size ?? 16,
                decoration: decoration,
                decorationColor: ConstantColors.whiteColor,
                fontWeight: fontWeight ?? FontWeight.bold,
                color: color ?? ConstantColors.whiteColor,
                wordSpacing: wordSpacing ?? 0,
              ),
            )
          : GestureDetector(
              onTap: voidCallback,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: size ?? 12,
                  decoration: decoration,
                  fontWeight: fontWeight ?? FontWeight.normal,
                  color: color ?? ConstantColors.whiteColor,
                  wordSpacing: wordSpacing ?? 0,
                ),
              )),
    );
  }
}
