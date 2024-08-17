import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prowiz/utils/colors.dart';
import 'package:prowiz/utils/custom_text.dart';
import 'package:prowiz/utils/global_theme.dart';
import 'package:prowiz/utils/storage_utils.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key, required this.controller});

  final NotchBottomBarController controller;

  @override
  Widget build(BuildContext context) {

    final ThemeController themeController = Get.put(ThemeController());

    return SafeArea(
      child: Obx(() => Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(20.0),
            child: Container(
              padding: const EdgeInsets.only(left: 24),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 15,
                    backgroundColor: ConstantColors.buttonColor,
                    child: Icon(
                      Icons.arrow_back,
                      color: ConstantColors.whiteColor,
                      size: 18,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CustomTextWidget(
                    text: StorageUtils.email().split('@')[0],
                    fontWeight: FontWeight.w400,
                    size: 22,
                    color: ConstantColors.whiteColor,
                  )
                ],
              ),
            ),
          ),
          toolbarHeight: 35,

          // leading: const CircleAvatar(
          //   radius: 10,
          //   backgroundColor: ConstantColors.buttonColor,
          //   child: Icon(Icons.arrow_back_outlined,color: ConstantColors.whiteColor,),
          // ),

          backgroundColor: Colors.transparent,
          // title: CustomTextWidget(text: StorageUtils.email(),
          //
          // color: Colors.white,),
        ),
        body:  Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:  ConstantColors.whiteColor,
                    border: Border.all(color: ConstantColors.buttonColor,width: 2)
                ),
                child: const Icon(Icons.person, size: 48, color: ConstantColors.blackColor,),

              ),
              const SizedBox(height: 10,),
              CustomTextWidget(text: StorageUtils.email().split('@')[0]),
              const SizedBox(height: 5,),
              CustomTextWidget(text: StorageUtils.email()),
              SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextWidget(text: themeController.isDarkMode.value ? "Dark Theme": "Light Theme"),
                  SizedBox(width: 10,),

                  Transform.scale(
                    scale: 1,
                    child: Switch(
                        value: themeController.isDarkMode.value, onChanged: (bool? value){

                      if(value !=null){
                        themeController.toggleTheme(value);
                      }

                    }),
                  )

                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
