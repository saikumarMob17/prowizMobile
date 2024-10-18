import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackBar(String message,{String? title, Color? color, SnackPosition? snackBarPosition, bool isSuccess = false}) {
  Get.snackbar(
    title ?? "",
    message,
    duration: const Duration(seconds: 1),
    snackPosition:snackBarPosition ??  SnackPosition.TOP,
    backgroundColor: color ?? Colors.green,
    colorText: Colors.white,
    borderRadius: 10,
    margin: const EdgeInsets.all(10),
    icon: isSuccess ? const Icon(Icons.done_outline,color: Colors.white,): const Icon(
      Icons.error,
      color: Colors.white,
    ),
    shouldIconPulse: true,
    snackStyle: SnackStyle.FLOATING,
  );
}
