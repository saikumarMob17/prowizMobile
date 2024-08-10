import 'dart:developer';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prowiz/screens/login_screen.dart';
import 'package:prowiz/utils/colors.dart';
import 'package:prowiz/utils/custom_text.dart';
import 'package:prowiz/utils/images.dart';
import 'package:prowiz/utils/strings.dart';



final storageBox= GetStorage();

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var welcomeFont = GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: ConstantColors.textFieldColor);
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              color: ConstantColors.primaryColor,
              image: DecorationImage(
                  image: AssetImage(ConstantImages.splashBg),
                  fit: BoxFit.fill)),
          child: Center(
            child: RichText(
              text: TextSpan(
                  text: Constants.welcomeText,
                  children: [
                    const WidgetSpan(
                        child: SizedBox(
                      width: 5,
                    )),
                    TextSpan(
                        text: Constants.login,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                        style: welcomeFont)
                  ],
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400, fontSize: 16)),
            ),
          ),
        ),
        bottomSheet: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          decoration: const BoxDecoration(
              color: ConstantColors.splashBgColor,
              image: DecorationImage(
                  image: AssetImage(
                    ConstantImages.bottomSheetBG,
                  ),
                  fit: BoxFit.fill),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(22), topLeft: Radius.circular(22))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 3,
                      width: 53,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22)),
                    ),
                  ),
                  const SizedBox(
                    height: 47,
                  ),
                   const CustomTextWidget(
                    text: Constants.helloWelcome,
                    color: ConstantColors.whiteColor,
                    size: 24,
                    fontWeight: FontWeight.w400,
                  ),
                   const CustomTextWidget(
                    text: Constants.ccTvLiveDesc,
                    color: Colors.white,
                    size: 24,
                    fontWeight: FontWeight.w400,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  richTextWidget(Constants.readMore, "",
                      isIcon: true,
                      sizedBoxValue: 3,
                      fontSize: 13,
                      content1Color: ConstantColors.textFieldColor),
                  const SizedBox(
                    height: 20,
                  ),

                  CustomTextWidget(

                      text: Constants.readMoreDesc,
                    textAlign: TextAlign.justify,
                    fontWeight: FontWeight.w400,
                    size: 12,
                    color: ConstantColors.whiteColor.withOpacity(0.5),


                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

richTextWidget(String content1, String content2,
    {String? content3,
    String? content4,
    double sizedBoxValue = 0,
    Color? content1Color,
    Color? content2Color,
    Color? content3Color,
    double fontSize = 12,
    bool isIcon = false}) {
  return RichText(
    text: TextSpan(
        text: content1,
        children: [
          WidgetSpan(
              child: SizedBox(
            width: sizedBoxValue,
          )),
          isIcon
              ? const WidgetSpan(
                  child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: ConstantColors.textFieldColor,
                  size: 16,
                ))
              : TextSpan(
                  text: content2,
                  style: TextStyle(
                    fontSize: fontSize,
                    color: content2Color,
                    letterSpacing: -0.24,
                  )),
          TextSpan(
              text: content3,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  log("YESSSSS");
                },
              style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w400,
                  color: content3Color,
                  letterSpacing: -0.24,
                  decoration: TextDecoration.underline)),
          TextSpan(
              text: content4,
              style: TextStyle(
                fontSize: fontSize,
                letterSpacing: -0.24,
                fontWeight: FontWeight.w400,
                color: content3Color,
              ))
        ],
        style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: fontSize,
            letterSpacing: -0.24,
            color: content1Color)),
  );
}
