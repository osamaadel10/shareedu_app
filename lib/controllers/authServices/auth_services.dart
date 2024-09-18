import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shareedu_app/models/enterWithFinger.dart';
import 'package:shareedu_app/view/screens/start/start_screen.dart';
import 'package:shareedu_app/view/widgets/top_loader.dart';
import '../../constant/varibles/global_varible.dart';
import '../../data/local_database.dart';
import '../../models/login_model.dart';

class AuthServices {
  static Future<int?> login(
    LoginModel loginParameters,
  ) async {
    const String baseUrl = "https://demo.shareedu-lms.com/";
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
      int? userIndex = int.tryParse(res.data)??0;
      return (userIndex);
    } catch (e) {
      return null;
    }
  }

static Future enterWithFinger(
    EnterModel enterModel,
  ) async {
    // print(object)
    final EnterModel enterModel = EnterModel(
      tokenId: LocalDatabase.getUserToken() ?? "",
      operSys: Platform.isAndroid ? "android" : "ios",
      userType: LocalDatabase.getUserIndex()??0,
      userLang: LocalDatabase.getLanguageCode(),
    );
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
        "grand/shareedulogin/UserloginSendNewMob.asp",
        queryParameters:enterModel.toJson(),
        options: Options(method: "POST"),
      );
    } catch (e) {
      return null;
    }
  }


  static void logout(BuildContext context)async{
    userid ="" ;
    userpass ="" ;
    TopLoader.startLoading(context);
    LocalDatabase.deletUserData();
    TopLoader.stopLoading(context);
    Get.offAll(()=> const StartScreen());
  }
}
