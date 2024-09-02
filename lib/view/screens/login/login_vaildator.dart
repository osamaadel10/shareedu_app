import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Validators {
  static bool isEmpty(String name ,String pass) {
    if (name.isEmpty || name.trim().isEmpty || pass.trim().length < 6) {
      Get.snackbar('error'.tr, 'loginAuthError'.tr,
          borderColor: Colors.red,
          backgroundColor: Colors.redAccent,
          borderWidth: 2,
          colorText: Colors.white,
          icon: Icon(Icons.error_outline,color:Colors.white ,size: 40.r,));
      return true;
    }
    return false;
  }
  static bool numValidator(String num) {
    try {
      int.parse(num);
      if (num.length > 15) {
        Get.snackbar('error'.tr, 'loginAuthError'.tr,
            borderColor: Colors.red,
            backgroundColor: Colors.redAccent,
            borderWidth: 2,
            colorText: Colors.white,
            icon: Icon(Icons.error_outline,color:Colors.white ,size: 40.r,));
        return true;
      }
    } catch (e) {
      Get.snackbar('error'.tr, 'loginAuthError'.tr,
          borderColor: Colors.red,
          backgroundColor: Colors.redAccent,
          borderWidth: 2,
          colorText: Colors.white,
          icon: Icon(Icons.error_outline,color:Colors.white ,size: 40.r,));
      return true;
    }
    return false;
  }
}
