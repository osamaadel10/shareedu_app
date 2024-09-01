import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constant/styles/colors.dart';
import 'button.dart';

Future<void> showConfirmationDialog(
  BuildContext context, {
  required String title,
  required String? subtitle1,
  String? subtitle2,
  String? cancelButtonTitle,
  required VoidCallback onYesPressed,
}) async {
  final size = MediaQuery.of(context).size;
  final orientation = MediaQuery.of(context).orientation;
  final dialog = Dialog(
    backgroundColor: backgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
        width:
            (orientation == Orientation.portrait ? size.width : size.height) *
                .9,
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: (() {
                      Navigator.of(context).pop();
                    }),
                    child: const Icon(Icons.close, size: 28),
                  ),
                ],
              ),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              if (subtitle1 != null)
                Text(
                  subtitle1,
                  style: TextStyle(fontSize: 14.sp),
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Button(
                  title:'confirm'.tr,
                  onButtonPressed: onYesPressed,
                  textStyle:TextStyle(fontSize: 14.sp),
                  width: double.infinity,
                  hight: 40,
                ),
              ),
                const SizedBox(height: 20),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'cancel'.tr,
                  style: TextStyle(fontSize: 12.sp),
                ),
              ),
              const SizedBox(height: 15)
            ],
          ),
        ),
      ),
    ),
  );
  await showDialog(context: context, builder: (context) => dialog);
}
