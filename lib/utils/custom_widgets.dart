import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prowiz/utils/images.dart';

Widget customImage({double height= 70}) {
  return Center(
    child: Image.asset(ConstantImages.logo,
      fit: BoxFit.cover,
      height: height,


    ),
  );
}
