// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shareedu_app/constant/varibles/global_varible.dart';
import 'package:shareedu_app/data/local_database.dart';
import 'package:shareedu_app/view/screens/web_view_screen/web_view_screen.dart';
import '../../../constant/urls/urls.dart';
import '../../../controllers/authServices/auth_services.dart';
import '../../../models/login_model.dart';
import '../../widgets/top_loader.dart';

class LoginProvider {
  Future<void> onLoginPressed(BuildContext context) async {
    TopLoader.startLoading(context);
    String? token = await FirebaseMessaging.instance.getToken();
    final int? userIndex = await _login(token, context);
    

    if (userIndex == null || token == null) {
      TopLoader.stopLoading(context);
      _showErrorMessage('loginError'.tr, context);
      return;
    }
    if (userIndex == 0) {
      TopLoader.stopLoading(context);
      _showErrorMessage('loginAuthError'.tr, context);
      return;
    }

    _saveUserDataToDatabse(userIndex, token);
    TopLoader.stopLoading(context);
    _reDirectUserToHomeScreen(userIndex, context);
  }

  Future<int?> _login(String? token, BuildContext context) async {
    final LoginModel loginModel = LoginModel(
      tokenId: token ?? "",
      operSys: Platform.isAndroid ? "android" : "ios",
      tuserName: int.parse(userid),
      tuserPassword: userpass.trim(),
      userType: UserIndex,
      userLang: LocalDatabase.getLanguageCode(),
    );
    final int? userIndex = await AuthServices.login(loginModel);
    return userIndex;
  }

  void _saveUserDataToDatabse(int userIndex, String token){
    LocalDatabase.saveUserIndex(userIndex);
    LocalDatabase.saveUserToken(token);
  }

  void _reDirectUserToHomeScreen(int userIndex, BuildContext context) {
    switch (userIndex) {
      case 1:
        {Get.offAll(() => WebViewScreen(
              title: 'staffServices'.tr,
              pageUrl: AppUrls.employeePage,
            ));
        }
        break;
      case 4:
      {Get.offAll(() => WebViewScreen(
              title: 'staffServices'.tr,
              pageUrl: AppUrls.employeePage,
            ));
        }
        break;
      case 2:
        {Get.offAll(() => WebViewScreen(
              title: 'studentServices'.tr,
              pageUrl: AppUrls.studentPage,
            ));
        }
        break;
      case 3:
        {
          Get.offAll(() => WebViewScreen(
                title: 'parentServices'.tr,
                pageUrl: AppUrls.parService,
              ));
        }
        break;
    }
  }

  void _showErrorMessage(String errorMessage, BuildContext context) {
    Get.snackbar('error'.tr, errorMessage,
        borderColor: Colors.red,
        backgroundColor: Colors.redAccent,
        borderWidth: 2,
        colorText: Colors.white,
        icon: Icon(
          Icons.error_outline,
          color: Colors.white,
          size: 40.r,
        ));
  }
}

enum UserType { employee, student, parent, trackedEmployee }
