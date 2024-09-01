import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shareedu_app/constant/varibles/global_varible.dart';
import '../../../constant/styles/colors.dart';

class PasswordTextFieldWidget extends StatefulWidget {
  const PasswordTextFieldWidget({
    Key? key,
    this.lableText,
  }) : super(key: key);
  final String? lableText;

  @override
  State<PasswordTextFieldWidget> createState() =>
      _PasswordTextFieldWidgetState();
}

class _PasswordTextFieldWidgetState extends State<PasswordTextFieldWidget> {
  bool isPassVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('password'.tr,
            style: TextStyle(
              fontFamily: 'Cairo',
              color: primaryColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(height: 10),
        SizedBox(
          height: 40.h,
          child: TextFormField(
            onChanged: (value) {
              userpass = value;
            },
            obscureText: !isPassVisible,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(8),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xff0E4D68)),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xff0E4D68)),
                borderRadius: BorderRadius.circular(15),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                child: Icon(
                  isPassVisible ? Icons.visibility : Icons.visibility_off,
                  color: primaryColor,
                ),
                onTap: () {
                  setState(() {
                    isPassVisible = !isPassVisible;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
