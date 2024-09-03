import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shareedu_app/controllers/authServices/auth_services.dart';
import 'package:shareedu_app/data/localData/local_database.dart';
import 'package:shareedu_app/models/enterWithFinger.dart';
import 'package:shareedu_app/view/screens/splash/splash_screen.dart';

import 'api_auth.dart';

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
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
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
