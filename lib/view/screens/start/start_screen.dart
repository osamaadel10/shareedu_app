import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shareedu_app/view/screens/login/login_screen.dart';

import '../../../constant/logos/company_logo.dart';
import '../../../constant/logos/school_logo.dart';
import '../../../constant/styles/colors.dart';
import '../../widgets/button.dart';
import '../../widgets/language_sheet.dart';
import '../guest/guest_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              children: [
                SizedBox(height: 0.06 * Get.height),
                LogoSchool(width: Get.width - 20, height: Get.height / 3),
                SizedBox(
                  height: 50.h,
                ),
                Button(
                    title: 'login'.tr,
                    width: double.infinity,
                    onButtonPressed: () {
                      Get.to(() => const LoginScreen());
                    }),
                const SizedBox(height: 15),
                Button(
                  width: double.infinity,
                  title: "guestRegister".tr,
                  onButtonPressed: () {
                    Get.to(() => GuestScreen());
                  },
                ),
                const SizedBox(height: 15),
                Button(
                  width: double.infinity,
                  title: "language".tr,
                  onButtonPressed: () async {
                    changeLangeSheet(context);
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 100.w, vertical: 40.h),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: const LogoCompany(),
          ),
        ),
      ),
    );
  }
}
