// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shareedu_app/view/screens/start/start_screen.dart';

import '../../data/localData/local_database.dart';
import '../../models/login_model.dart';


class AuthServices {
  static Future<int?> login(
    LoginModel loginParameters,
  ) async {
    const String baseUrl = "https://ms.edu.sa/";
    final Dio dio = Dio();
    dio.options.baseUrl = baseUrl;
    if (!kReleaseMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          compact: true,
        ),
      );
    }
    try {
      final res = await dio.request(
        "grand/shareedulogin/UserloginSendNewMob.asp",
        queryParameters: loginParameters.toJson(),
        options: Options(method: "POST"),
      );
      int? userIndex = int.tryParse(res.data);
      return (userIndex);
    } catch (e) {
      return null;
    }
  }

  static void logout(BuildContext context) {
    LocalDatabase.deletUserData();
    Get.offAll(()=> const StartScreen());
  }
}
