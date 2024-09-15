import 'package:flutter/material.dart';
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
    super.key,
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
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.all(1),
      child: SizedBox(
        width: width,
        height: hight,
        child: ElevatedButton.icon(
          icon: icon ?? Container(),
          label: Text(
            title,
            style: const TextStyle(fontSize: 18) ,
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
      ),
    );
  }
}
