import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shareedu_app/constant/varibles/global_varible.dart';
import 'package:shareedu_app/data/local_database.dart';
import 'package:shareedu_app/models/tracking.dart';

class TrackingServices {
  Timer? timer;
  Location location = Location();
  LocationData? currentLocation;

  static Future<void> sendLocation(TrackingModel trackingModel) async {
    const String baseUrl = "https://demo.shareedu-lms.com/";
    final Dio dio = Dio();
    dio.options.baseUrl = baseUrl;
    if (!kReleaseMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: false,
          responseBody: false,
          responseHeader: false,
          compact: true,
        ),
      );
    }

    try {
      await dio.request(
        "MobileServices2022/indexEmpTrack.asp",
        queryParameters: trackingModel.toJson(),
        options: Options(method: "POST"),
      );
    } catch (e) {
      return;
    }
  }

  void startTracking() {
     Timer.periodic(const Duration(seconds: 10), (Timer t) async {
      if(istracked == false){t.cancel(); return;}
      await getLocation();
      if (currentLocation != null) {
        Get.snackbar(backgroundColor:Colors.white,dismissDirection: DismissDirection.down, "Current Location","LANG = ${currentLocation!.longitude} \n LAT = ${currentLocation!.latitude}");
        await sendLocation(
          TrackingModel(
              tokenId: LocalDatabase.getUserToken() ?? "",
              operSys: Platform.isAndroid ? "android" : "ios",
              userType: LocalDatabase.getUserIndex() ?? 0,
              userLang: LocalDatabase.getLanguageCode(),
              Lang: currentLocation!.longitude ?? 0.0,
              Lat: currentLocation!.latitude ?? 0.0),
        );
      }
    });
  }

  Future<void> getLocation() async {
    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      Get.snackbar('error'.tr, "$e");
    }
  }
}
