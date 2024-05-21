import 'package:flutter/material.dart';
import 'package:prowiz/utils/colors.dart';
import 'package:prowiz/utils/custom_text.dart';
import 'package:prowiz/utils/images.dart';
import 'package:prowiz/utils/strings.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
            color: ConstantColors.primaryColor,
            image: DecorationImage(
                image: AssetImage(ConstantImages.splashBg),
                fit: BoxFit.fill)),
        child: Center(
          child: RichText(
              text: const TextSpan(
                  text: Constants.welcomeBackText,
                  children: [
                    WidgetSpan(
                        child: SizedBox(
                          width: 5,
                        )),
                    TextSpan(
                      text: Constants.login,
                      style: TextStyle(
                        fontSize: 16,
                        color: ConstantColors.textFieldColor
                      )
                    )
                  ],
                  style:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),

          ),

        ),
      ),

      bottomSheet: Container(

        decoration: BoxDecoration(
            color: ConstantColors.primaryColor,
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(


              decoration: BoxDecoration(

                color: ConstantColors.primaryColor,
                gradient: LinearGradient(colors: [
                  ConstantColors.primaryColor,
                  ConstantColors.primaryColor,


                ]),
                borderRadius: BorderRadius.circular(22),

              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: 5,
                        width: 20,
                        decoration: BoxDecoration(
                          color: Colors.white,

                        ),
                      ),
                    ),
                    SizedBox(height: 50,),
                    CustomTextWidget(text: "Hello Welcome\nto CCTV live Portal pp",color: Colors.white,),
                    SizedBox(height: 20,),
                    CustomTextWidget(text: Constants.textData,color: Colors.white,),
                    SizedBox(height: 20,),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
