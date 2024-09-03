import 'dart:ui';

import 'package:get/get.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          "studentServices": "Student Services",
          "employee": "Employee",
          "student": "Student",
          "parent": "Parent",
          "parentServices": "Parent Services",
          "staffServices": "Staff Services",
          "login": "Login",
          "idNum": "ID Number",
          "userType": "User Type",
          "password": "Password",
          "back": "Back",
          "main": "Home",
          "logout": "Logout",
          "logoutHint": "Do you really want to logout?",
          "exitHint": "Do you really want to exit the app?",
          "track": "Track",
          "confirm": "Confirm",
          "cancel": "Cancel",
          "guestRegister": "Register as a guest",
          "visAboutUs": "About our school",
          "visSchoolAccess": "School Access",
          "visCallUS": "Telephone book",
          "visRegistraion": "Admission",
          "visBook": "Guestbook",
          "visEmployment": "Employment",
          "visPhotoalbum": "Photo Album",
          "visNews": "Latest News",
          "loginError": "Error happend, try again later",
          "loginAuthError": "ID number or password not correct",
          "language": "Language",
          "required_field": "This field is required.",
          "numbers_only": "Enter numbers only",
          "password_form_hint":
          "Password shouldn't be less than 6 letters or numbers",
          "idHint": "ID number not more than 15 digits",
          "error":"Error",
          "fingerPrint":"Use fingerprint to log in"
        },
        'ar_EG': {
          "studentServices": "خدمات الطالب",
          "employee": "موظف",
          "student": "طالب",
          "parent": "ولي أمر",
          "parentServices": "خدمات ولي الأمر",
          "staffServices": "خدمات المنسوبين",
          "login": "تسجيل الدخول",
          "idNum": "رقم الهوية",
          "userType": "نوع المستخدم",
          "password": "كلمة المرور",
          "back": "رجوع",
          "main": "الرئيسية",
          "logout": "تسجيل الخروج",
          "logoutHint": "هل تريد حقًا تسجيل الخروج؟",
          "exitHint": "هل تريد حقًا الخروج من التطبيق؟",
          "track": "تتبع",
          "confirm": "تأكيد",
          "cancel": "إلغاء",
          "guestRegister": "التسجيل كزائر",
          "visAboutUs": "عن مدرستنا",
          "visSchoolAccess": "الوصول للمدارس",
          "visCallUS": "دليل الهاتف",
          "visRegistraion": "القبول والتسجيل",
          "visBook": "سجل الزوار",
          "visEmployment": "التوظيف",
          "visPhotoalbum": "ألبومات الصور",
          "visNews": " آخر الاخبار",
          "loginError": "حدث خطأ، حاول مرة أخرى",
          "loginAuthError": "رقم الهوية أو كلمة المرور غير صحيحة",
          "language": "اللغة",
          "required_field": "هذا الحقل مطلوب",
          "numbers_only": "أدخل أرقام فقط",
          "password_form_hint": "يجب ألا تقل كلمة المرور عن 6 أحرف أو أرقام",
          "idHint": "رقم الهوية لا يزيد عن ١٥ رقم",
          "error":"خطأ",
          "fingerPrint":"استخدم البصمه لتسجيل الدخول"
        }
      };

    TextDirection getTextDirection(String langCode) {
    switch (langCode) {
      case 'ar':
        return TextDirection.rtl;
      case 'en':
      default:
        return TextDirection.ltr;
    }
  }
}
