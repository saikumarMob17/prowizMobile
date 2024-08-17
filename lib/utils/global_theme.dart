import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class ThemeController extends GetxController {
  RxBool isDarkMode = false.obs;

  void toggleTheme(bool isDark) {
    isDarkMode.value = isDark;
  }

  ThemeData get themeData {
    return isDarkMode.value ? ThemeData.dark() : ThemeData.light();
  }
}
