import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import '../../constant/varibles/global_varible.dart';
import '../../controllers/tracking/tracking_survices.dart';

class SwitchButton extends StatefulWidget {
  const SwitchButton({super.key});

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

Future<bool> requestLocationPermission() async {
  final Location location = Location();
  bool serviceEnabled;
  PermissionStatus permissionGranted;

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      Get.snackbar('error'.tr, 'locationPermaiton'.tr,
          borderColor: Colors.red,
          backgroundColor: Colors.redAccent,
          borderWidth: 2,
          colorText: Colors.white,
          icon: Icon(
            Icons.error_outline,
            color: Colors.white,
            size: 40.r,
          ));
      return false; 
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      Get.snackbar('error'.tr, 'locationPermaiton'.tr,
          borderColor: Colors.red,
          backgroundColor: Colors.redAccent,
          borderWidth: 2,
          colorText: Colors.white,
          icon: Icon(
            Icons.error_outline,
            color: Colors.white,
            size: 40.r,
          ));
      return false; 
    }
  }

  return true; 
}

class _SwitchButtonState extends State<SwitchButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "track".tr,
          style: const TextStyle(color: Colors.white),
        ),
        Switch(
          value: istracked,
          activeColor: Colors.green,
          onChanged: (v) async {
            if (v == true) {
              bool permissionGranted = await requestLocationPermission();
              if (permissionGranted) {
                TrackingServices().startTracking();
                setState(() {
                  istracked = true; 
                });
              } else {
                setState(() {
                  istracked = false;
                });
              }
            } else {
              setState(() {
                istracked = false; 
              });
            }
          },
        ),
      ],
    );
  }
}
