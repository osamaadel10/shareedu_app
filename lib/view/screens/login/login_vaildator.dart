import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Validators {
  static bool isEmpty(String name) {
    if (name.isEmpty) {
      Get.snackbar('error'.tr, 'required_field'.tr,
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
    if (num.trim().isEmpty) {
      Get.snackbar('error'.tr, 'required_field'.tr,
          borderColor: Colors.red,
          backgroundColor: Colors.redAccent,
          borderWidth: 2,
          colorText: Colors.white,
          icon: Icon(Icons.error_outline,color:Colors.white ,size: 40.r,));
      return true;
    }
    try {
      int.parse(num);
      if (num.length > 15) {
        Get.snackbar('error'.tr, 'idHint'.tr,
            borderColor: Colors.red,
            backgroundColor: Colors.redAccent,
            borderWidth: 2,
            colorText: Colors.white,
            icon: Icon(Icons.error_outline,color:Colors.white ,size: 40.r,));
        return true;
      }
    } catch (e) {
      Get.snackbar('error'.tr, 'numbers_only'.tr,
          borderColor: Colors.red,
          backgroundColor: Colors.redAccent,
          borderWidth: 2,
          colorText: Colors.white,
          icon: Icon(Icons.error_outline,color:Colors.white ,size: 40.r,));
      return true;
    }
    return false;
  }

  static bool passwordValidator(String pass) {
    if (pass.trim().length < 6) {
      Get.snackbar('error'.tr, 'password_form_hint'.tr,
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
