import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shareedu_app/view/screens/login/login_vaildator.dart';
import 'package:shareedu_app/view/widgets/language_sheet.dart';
import '../../../constant/styles/colors.dart';
import '../../../constant/varibles/global_varible.dart';
import '../../widgets/button.dart';
import 'login_field_widget.dart';
import 'login_provider.dart';
import 'password_text_field_widget.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Language().changeDirection(),
      child: Column(
        children: [
          Form(
            child: Column(
              children: [
                LoginFieldWidget(
                  labelText: 'idNum'.tr,
                ),
                const SizedBox(height: 10),
                const PasswordTextFieldWidget(),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('userType'.tr,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    color: primaryColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 10),
              SizedBox(
                height: 40.h,
                child: DropdownButtonFormField(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff0E4D68)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff0E4D68)),
                        borderRadius: BorderRadius.circular(15),
                      )),
                  value: UserType.employee,
                  items: [
                    DropdownMenuItem(
                      value: UserType.employee,
                      child: Text(
                        'employee'.tr,
                      ),
                    ),
                    DropdownMenuItem(
                      value: UserType.student,
                      child: Text(
                        'student'.tr,
                      ),
                    ),
                    DropdownMenuItem(
                      value: UserType.parent,
                      child: Text(
                        'parent'.tr,
                      ),
                    ),
                  ],
                  onChanged: (userType) {
                    switch (userType) {
                      case UserType.employee:
                        UserIndex = 1;
                        break;
                      case UserType.student:
                        UserIndex = 2;
                        break;
                      case UserType.parent:
                        UserIndex = 3;
                        break;
                      case UserType.trackedEmployee:
                      case null:
                        UserIndex = 1;
                        break;
                    }
                  },
                ),
              )
            ],
          ),
          SizedBox(height: 40.h),
          Button(
            width: double.infinity,
            title: 'login'.tr,
            onButtonPressed: () {
              if (checkData(userid, userpass)) {
                LoginProvider().onLoginPressed(context);
              }
            },
          ),
        ],
      ),
    );
  }
}

bool checkData(String id, String pass) {
  if (Validators.isEmpty(id) ||
      Validators.isEmpty(pass) ||
      Validators.numValidator(id) ||
      Validators.passwordValidator(pass)) {
    return false;
  }
  return true;
}
