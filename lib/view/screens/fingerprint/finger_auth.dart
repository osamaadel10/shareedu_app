import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shareedu_app/constant/styles/colors.dart';
import 'package:shareedu_app/controllers/authServices/auth_services.dart';
import 'package:shareedu_app/data/local_database.dart';
import 'package:shareedu_app/models/enterWithFinger.dart';
import 'package:shareedu_app/view/screens/splash/splash_screen.dart';

import '../../../controllers/authServices/api_auth.dart';

class FingerAuth extends StatefulWidget {
  const FingerAuth({super.key});

  @override
  State<FingerAuth> createState() => _FingerAuthState();
}

class _FingerAuthState extends State<FingerAuth> {
  @override
  void initState() {
    super.initState();
    autoAuth();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(        
          children: [
            SizedBox(height: 100.h,),
            Icon(Icons.lock_person_outlined,size: 200.r,color: primaryColor,),
            SizedBox(height: 50.h,),
            CircularProgressIndicator(strokeAlign: 4.w,strokeWidth: 13.w,color: primaryColor,),
          ],
        ),
      ),
    );
  }
  autoAuth() async {
    final isAuthenticated = await LocalAuthApi.authenticate();
    if (isAuthenticated) {
      Get.offAll(getFirstScreen(LocalDatabase.getUserIndex()));
      AuthServices.enterWithFinger(EnterModel(
          tokenId: LocalDatabase.getUserToken() ?? "",
          operSys: Platform.isAndroid ? "android" : "ios",
          userType: LocalDatabase.getUserIndex() ?? 0,
          userLang: LocalDatabase.getLanguageCode()));
    } else {
      exit(1);
    }
  }
}
