import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prowiz/utils/colors.dart';
import 'package:prowiz/utils/custom_text.dart';
import 'package:prowiz/utils/custom_widgets.dart';
import 'package:prowiz/utils/global_theme.dart';
import 'package:prowiz/utils/strings.dart';

class RegistrationPage extends StatelessWidget {
   RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();


    var sizedBox= const SizedBox(height: 20,);
    return Scaffold(
      backgroundColor: themeController.isDarkMode.value
          ? ConstantColors.blackColor
          : ConstantColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customImage(),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: CustomTextWidget(

                    text: Constants.registerAnAccount,
                    fontWeight: FontWeight.bold,

                    size: 24,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                userNameTextField(),
                sizedBox,
                passwordTextField(),
                sizedBox,
                emailTextField(),
                sizedBox,
                centerIdTextFiled(),
                sizedBox,
                locationIdTextField(),
                sizedBox,
                SizedBox(height: 10,),
                submitButton(context),

              ],
            ),
          ),
        ),
      ),
    );




  }


  var focusBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20,),
      borderSide: BorderSide.none
  );

  var contentPadding =const EdgeInsets.symmetric(horizontal: 10,vertical: 5);


  var hintTextStyle =
  const TextStyle(fontSize: 12, color: ConstantColors.blackColor);

  userNameTextField() {
    return TextFormField(
      decoration:  InputDecoration(
          fillColor: ConstantColors.whiteColor,
          hintText: Constants.userName,
          filled: true,
          hintStyle: hintTextStyle,
          focusedBorder: focusBorder,
        border: focusBorder,
        contentPadding: contentPadding,


      ),
    );
  }

  passwordTextField() {
    return TextFormField(
      decoration:  InputDecoration(
        fillColor: ConstantColors.whiteColor,
        hintText: Constants.password,
        filled: true,
        hintStyle: hintTextStyle,
        focusedBorder: focusBorder,
        border: focusBorder,
        contentPadding: contentPadding,


      ),
    );
  }

  centerIdTextFiled() {
    return TextFormField(
      decoration:  InputDecoration(
        fillColor: ConstantColors.whiteColor,
        hintText: Constants.centerId,
        filled: true,
        hintStyle: hintTextStyle,
        focusedBorder: focusBorder,
        border: focusBorder,
        contentPadding: contentPadding,


      ),
    );
  }

  emailTextField() {
    return TextFormField(
      decoration:  InputDecoration(
        fillColor: ConstantColors.whiteColor,
        hintText: Constants.email,
        filled: true,
        hintStyle: hintTextStyle,
        focusedBorder: focusBorder,
        border: focusBorder,
        contentPadding: contentPadding,


      ),
    );
  }

  locationIdTextField() {
    return TextFormField(
      decoration:  InputDecoration(
        fillColor: ConstantColors.whiteColor,
        hintText: Constants.location,
        filled: true,
        hintStyle: hintTextStyle,
        focusedBorder: focusBorder,
        border: focusBorder,
        contentPadding: contentPadding,


      ),
    );
  }


   submitButton(BuildContext context) {
     return ElevatedButton(
         style: ElevatedButton.styleFrom(
           minimumSize: const Size(double.infinity, 48),
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(20),
           ),
           backgroundColor:  ConstantColors.loginButtonColor,
         ),
         onPressed:  (){},
         child: const CustomTextWidget(
           text: Constants.register,
           color:  ConstantColors.whiteColor,
           size: 16,
         ));
   }
}
