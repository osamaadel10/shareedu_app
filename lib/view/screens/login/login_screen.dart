import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shareedu_app/constant/logos/school_logo.dart';
import 'package:shareedu_app/view/widgets/app_bar.dart';
import '../../../constant/varibles/global_varible.dart';
import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "/login";
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserIndex = 1;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarW(
        title: 'login'.tr,
        hasTrackingButton: false,
        hasLang: true,
        hasBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            children: [
              const SizedBox(height: 5),
              LogoSchool(width: Get.width*0.4, height: Get.width*0.5,),
              const LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
