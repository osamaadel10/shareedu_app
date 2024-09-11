// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screens/web_view_screen/web_view_screen.dart';

Widget buildIcon(
    BuildContext context, String imageName, String title, String baseUrl) {
  return InkWell(
     onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => WebViewScreen(
                title: title,
                isGuestPage: true,
                pageUrl: baseUrl, 
              ),
            ),
          );
        },
    child: Container(
       padding: const EdgeInsets.all(5),
          width: 110,
          height: 125,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border: Border.all(
              color: const Color(0xff0E4D68),
              style: BorderStyle.solid,
            ),
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/$imageName.png'),
          const SizedBox(height: 8),
          Text(title, textAlign: TextAlign.center,
              style:  TextStyle(
                color:const Color(0xff0E4D68),
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),),
        ],
      ),
    ),
  );
}
