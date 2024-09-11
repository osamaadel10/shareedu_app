// ignore_for_file: unrelated_type_equality_checks
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shareedu_app/view/screens/splash/splash_screen.dart';
import '../../constant/styles/colors.dart';
import '../../constant/varibles/global_varible.dart';
import '../../data/local_database.dart';
import 'button.dart';

class Language {
  // ignore: prefer_typing_uninitialized_variables
  var local;
  changeLanguage(setlang, context) async {
    if (setlang == const Locale('ar_EG')) {
      await box.write('lang', 'ar_EG');
      local = 'ar_EG';
      lang = const Locale('ar_EG');
    } else {
      await box.write('lang', 'en_US');
      local = 'en_US';
      lang = const Locale('en_US');
      }
    Get.updateLocale(Locale(local));
  }

  changeDirection() {
    return (LocalDatabase.getLanguageCode() == 1)
        ? TextDirection.ltr
        : TextDirection.rtl;
  }
}

changeLangeSheet(BuildContext context) {
  showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      context: context,
      builder: (context) => SizedBox(
          height: Get.height / 3.5,
          width: Get.width,
          child: Directionality(
            textDirection: Language().changeDirection(),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 18),
                      Text('language'.tr,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          )),
                      SizedBox(height: 25.h),
                      Button(
                        title: "العربية",
                        borderRadius: 20.h,
                        color: (box.read('lang') == 'ar_EG')
                            ? greenColor
                            : const Color.fromARGB(193, 247, 247, 247),
                        textColor: Colors.black,
                        elevation: 5,
                        icon: (box.read('lang') == 'ar_EG')
                            ? const Icon(
                                Icons.check_circle,
                                color: primaryColor,
                              )
                            : null,
                        width: Get.width / 1.5,
                        onButtonPressed: () {
                          Language()
                              .changeLanguage(const Locale('ar_EG'), context);
                          Language().changeDirection();
                          Navigator.pop(context);
                          if (LocalDatabase.isUserAuthenticated()) {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => getFirstScreen(LocalDatabase.getUserIndex()),
                            ));
                          }
                        },
                      ),
                      SizedBox(height: 20.h),
                      Button(
                        title: "English",
                        borderRadius: 20.h,
                        color: (box.read('lang') == 'en_US')
                            ? greenColor
                            : const Color.fromARGB(193, 247, 247, 247),
                        textColor: Colors.black,
                        elevation: 7,
                        icon: (box.read('lang') == 'en_US')
                            ? const Icon(
                                Icons.check_circle,
                                color: primaryColor,
                              )
                            : const SizedBox(),
                        width: Get.width / 1.5,
                        onButtonPressed: () {
                          Language()
                              .changeLanguage(const Locale('en_US'), context);
                          Language().changeDirection();
                          Navigator.pop(context);
                          if (LocalDatabase.isUserAuthenticated()) {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => getFirstScreen(LocalDatabase.getUserIndex()),
                            ));
                          }
                        },
                      ),
                      const Spacer(),
                    ])),
          )));
}
