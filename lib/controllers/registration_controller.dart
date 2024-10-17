import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {
  late TextEditingController userName, email, password, centerId, locationCode;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    userName = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    centerId = TextEditingController();
    locationCode = TextEditingController();
  }




}
