
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future <void> firebaseMessageinginBackground(RemoteMessage message)async
{
    Get.snackbar('${message.messageId}', '${message.data}',backgroundColor:Colors.white);
}

Future<bool> requestPermissionNotifcation()async
{
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: true,
    provisional: true,
    criticalAlert: true,
    sound: true,
  );
  if(settings.authorizationStatus == AuthorizationStatus.authorized)
  {
    FirebaseMessaging.onMessage.listen((RemoteMessage message){
          Get.snackbar('${message.notification!.title}', '${message.notification!.body}',backgroundColor:Colors.white);
    });
    
  }
  return (settings.authorizationStatus == AuthorizationStatus.authorized);
}