import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shareedu_app/constant/styles/colors.dart';
import 'package:shareedu_app/constant/varibles/global_varible.dart';
import 'package:shareedu_app/view/screens/login/login_vaildator.dart';

class LoginFieldWidget extends StatelessWidget {
  const LoginFieldWidget({
    Key? key,
    this.onChanged,
    required this.labelText,
  }) : super(key: key);
  final Function()? onChanged;
  final String labelText;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText,
            style:TextStyle(
              fontFamily: 'Cairo',
              color: primaryColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(height: 10),
        SizedBox(
          height: 40.h,
          child: TextFormField(
            onChanged: (val){
              userid = val;
              Validators.numValidator(val);
            },
            minLines: 1,
            maxLines: 2,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xff0E4D68)),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xff0E4D68)),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }
}
