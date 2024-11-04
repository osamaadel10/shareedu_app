import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shareedu_app/view/screens/splash/splash_screen.dart';
import 'constant/varibles/global_varible.dart';
import 'controllers/language/translation.dart';
import 'package:flutter/services.dart';
import 'models/notifcation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


String mainUrl = "https://demo.shareedu-lms.com/";
String partOfmainUrl = "demo.shareedu-lms.com";

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
  
  await FirebaseFirestore.instance.collection('urls').doc('urlss').snapshots().listen((snapshot){
    var data = snapshot.data();
    mainUrl = data?['mainUrl']??mainUrl;
    partOfmainUrl = data?['partofmainUrl']??partOfmainUrl;});
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  if(await requestPermissionNotifcation())
  {
    FirebaseMessaging.onBackgroundMessage(firebaseMessageinginBackground);
  }
  
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          translations: Translation(),
          locale: lang,
          home: child,
        );
      },
      child: const SplashScreen(),
    );
  }
}
