
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class LogoSchool extends StatelessWidget {
  double width = Get.width;
  double height = 180.h;
  LogoSchool ({super.key,required this.width,required this.height}) ;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
                "images/logo.png",
                width: width,
                height: height,
                fit: BoxFit.cover,
              );
  }
}