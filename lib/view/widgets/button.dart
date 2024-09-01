import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/styles/colors.dart';


class Button extends StatelessWidget {
  final String title;
  final VoidCallback? onButtonPressed;
  final Color color;
  final Color textColor;
  final TextStyle textStyle;
  final double borderRadius;
  final double? width;
  final double? hight;
  final double elevation;
  final Widget? icon;
  const Button({
    Key? key,
    required this.title,
    required this.onButtonPressed,
    this.color = primaryColor,
    this.borderRadius = 10,
    this.width = 110,
    this.hight = 46,
    this.elevation = 2,
    this.textStyle = const TextStyle( fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w800,),
    this.textColor = Colors.white,
    this.icon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: hight,
      child: ElevatedButton.icon(
        icon: icon ?? Container(),
        label: Text(
          title,
          style: TextStyle(fontSize: 16.sp) ,
        ),
        onPressed: onButtonPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor,
          alignment: Alignment.center,
          backgroundColor: color,
          elevation: elevation,
          textStyle: textStyle,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}
