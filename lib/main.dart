import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shareedu_app/view/screens/splash/splash_screen.dart';
import 'constant/varibles/global_varible.dart';
import 'controllers/language/translation.dart';

void main() async {
  await GetStorage.init();
  box = GetStorage();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  String? storedLang = await box.read('lang');
  lang = storedLang != null ? Locale(storedLang) : Get.deviceLocale;
  if (storedLang == null) {
    await box.write('lang', Get.deviceLocale.toString());
  }

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    translations: Translation(),
    locale: lang,
    home: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: const SplashScreen(),
    );
  }
}
