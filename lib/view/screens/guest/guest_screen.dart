import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shareedu_app/view/widgets/language_sheet.dart';
import '../../../constant/urls/urls.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/content_Icons.dart';

class GuestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orientaion = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppbarW(
        title: 'guestRegister'.tr,
        hasBackButton: true,
        hasTrackingButton: false,
        hasLang: true,
      ),
      body: Directionality(
        textDirection: Language().changeDirection(),
        child: Padding(
          padding:const  EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: orientaion == Orientation.portrait ? 2 : 4,
            childAspectRatio: 1.5,
            mainAxisSpacing: 16,
            crossAxisSpacing: 10,
            padding: const EdgeInsets.all(4.0),
            children: [ 
              buildIcon(context, "about_school", 'visAboutUs'.tr,
                  AppUrls.visAboutUs),
              buildIcon(context, "teacher", 'visSchoolAccess'.tr,
                  AppUrls.visSchoolAccess),
              buildIcon(context, "contacts", 'visCallUS'.tr,
                  AppUrls.visCallUS),
              buildIcon(context, "registraion", 'visRegistraion'.tr,
                  AppUrls.visRegistraion),
              buildIcon(context, "guests", 'visBook'.tr,
                  AppUrls.visBook),
              buildIcon(context, "tawzif", 'visEmployment'.tr,
                  AppUrls.visEmployment),
              buildIcon(context, "images", 'visPhotoalbum'.tr,
                  AppUrls.visPhotoalbum),
              buildIcon(context, "news", 'visNews'.tr,
                  AppUrls.visNews),
            ],
          ),
        ),
      ),
    );
  }
}
