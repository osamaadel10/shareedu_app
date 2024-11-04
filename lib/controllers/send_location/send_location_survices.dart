import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shareedu_app/constant/varibles/global_varible.dart';
import 'package:shareedu_app/data/local_database.dart';
import 'package:shareedu_app/models/send_location.dart';

import '../../main.dart';

// ignore: camel_case_type
class send_location_Services {
  Timer? timer;
  Location location = Location();
  LocationData? currentLocation;

  static Future<void> sendLocation(SendLocationModel send_location) async {
    final String baseUrl = mainUrl;
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
        "MobileServices2022/AutoCallGetLocation.asp",
        queryParameters: send_location.toJson(),
        options: Options(method: "POST"),
      );
    } catch (e) {
      return;
    }
  }

  Future<void> startsend() async {
    PermissionStatus permissionGranted;
    bool serviceEnabled;


    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }
      await getLocation();
      if (currentLocation != null) {
    Timer.periodic(const Duration(seconds: 20), (Timer t) async {
      if (issendlocation == false) {
        t.cancel();
        return;
      }
      await getLocation();
      if (currentLocation != null) {
        await sendLocation(
          SendLocationModel(
              tokenId: LocalDatabase.getUserToken() ?? "",
              Lang: currentLocation!.longitude ?? 0.0,
              Lat: currentLocation!.latitude ?? 0.0),
        );
      }
    });}
  }

  Future<void> getLocation() async {
    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      Get.snackbar('error'.tr, "$e");
    }
  }
}
