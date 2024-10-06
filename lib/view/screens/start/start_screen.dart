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
                SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                LogoSchool(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height / 3.7),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.09,
                ),
                Button(
                    title: 'login'.tr,
                    width: double.infinity,
                    hight: MediaQuery.of(context).size.height * 0.06,
                    onButtonPressed: () {
                      Get.to(() => const LoginScreen());
                    }),
                const SizedBox(height: 15),
                Button(
                  width: double.infinity,
                  hight: MediaQuery.of(context).size.height * 0.06,
                  title: "guestRegister".tr,
                  onButtonPressed: () {
                    Get.to(() =>const GuestScreen());
                  },
                ),
                const SizedBox(height: 15),
                Button(
                  width: double.infinity,
                  hight: MediaQuery.of(context).size.height * 0.06,
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
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.08,
            height: MediaQuery.of(context).size.height * 0.1,
            child: const LogoCompany(),
          ),
        ),
      ),
    );
  }
}
