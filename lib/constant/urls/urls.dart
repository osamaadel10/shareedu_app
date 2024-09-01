import 'dart:io';
import '../../data/localData/local_database.dart';

class AppUrls {
  static const String _baseUrl = "https://ms.edu.sa/";
  static const String _guestBaseUrl =
      "https://ms.edu.sa/MobileServices2022/VisitorServices";
  static final String _queryParams = "TokenId=$_tokenId&OperSys=$_operSys";
  static final String? _tokenId = LocalDatabase.getUserToken();
  static final String _operSys = Platform.isAndroid ? "android" : "ios";

  //new urls for student, employee, and parent
  static final String studentPage =
      "$_baseUrl/MobileServices2022/indexStudent.asp?$_queryParams";
  static final String employeePage =
      "$_baseUrl/MobileServices2022/indexEmpService.asp?$_queryParams";
  static final String parentPage =
      "$_baseUrl/MobileServices2022/indexParService.asp?$_queryParams";

  //visitors links
  static final String visAboutUs = "$_guestBaseUrl/AboutUs.asp?$_queryParams";
  static final String visSchoolAccess =
      "$_guestBaseUrl/SchoolAccess.asp?$_queryParams";
  static final String visCallUS = "$_guestBaseUrl/CallUS.asp?$_queryParams";
  static final String visRegistraion =
      "$_baseUrl/ERegistraionNew/Index.asp?$_queryParams";
  static final String visBook = "$_guestBaseUrl/Guestbook.asp?$_queryParams";
  static final String visEmployment =
      "$_baseUrl/Employment/index.asp?$_queryParams";
  static final String visPhotoalbum =
      "$_guestBaseUrl/photoalbum.asp?$_queryParams";
  static final String visNews = "$_guestBaseUrl/News.asp?$_queryParams";

  //parent and employee links
  static final String empService =
      "$_baseUrl/MobileServices2022/indexEmpService.asp?$_queryParams";
  static final String empTrans =
      "$_baseUrl/MobileServices2022/indexEmpTrans.asp?$_queryParams";
  static final String empMsgs =
      "$_baseUrl/MobileServices2022/indexEmpMsgs.asp?$_queryParams";
  static final String empNoti =
      "$_baseUrl/MobileServices2022/indexEmpNoti.asp?$_queryParams";
  static final String empTrack =
      "$_baseUrl/MobileServices2022/indexEmpTrack.asp?$_queryParams";
  static final String empSettings =
      "$_baseUrl/MobileServices2022/indexEmpSettings.asp?$_queryParams";
  static final String parService =
      "$_baseUrl/MobileServices2022/indexParService.asp?$_queryParams";
  static final String parFees =
      "$_baseUrl/MobileServices2022/indexParFees.asp?$_queryParams";
  static final String parTrack =
      "$_baseUrl/MobileServices2022/indexParTrack.asp?$_queryParams";
  static final String parNoti =
      "$_baseUrl/MobileServices2022/indexParNoti.asp?$_queryParams";
  static final String parAutoCall =
      "$_baseUrl/MobileServices2022/indexParAutoCall.asp?$_queryParams";
  static final String parProblems =
      "$_baseUrl/MobileServices2022/indexParProblems.asp?$_queryParams";
  static final String parCallUS =
      "$_baseUrl/MobileServices2022/VisitorServices/CallUS.asp?$_queryParams";
}
