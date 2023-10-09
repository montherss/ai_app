import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

import 'component/component.dart';
import 'main.dart';
import 'notification/notification_dart.dart';

requestPermissionNotification()async{
  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
}
Future<void> backGroundMessage(RemoteMessage message)async{
  FlutterRingtonePlayer.playNotification();
  await NotificationService().showNotification(id: 1,
      title: '${message.notification!.title}',
      body: '${message.notification!.body}')
      .then((value) async {
    FlutterRingtonePlayer.playNotification();
  }).catchError((onError) {
    showTost("${onError.toString()}", Colors.red);
  });
}
initalMessage()async{
  var message = await FirebaseMessaging.instance.getInitialMessage();

  if(message!=null){
    main();
    FlutterRingtonePlayer.playNotification();
    await NotificationService().showNotification(id: 1,
        title: '${message.notification!.title}',
        body: '${message.notification!.body}')
        .then((value) async {
      FlutterRingtonePlayer.playNotification();
    }).catchError((onError) {
      showTost("${onError.toString()}", Colors.red);
    });
  }
}
fcmConfig()async
{
  await FirebaseMessaging.instance.getToken().then((value){
    print(value.toString());
  }).catchError((onError){
    print(onError.toString());
  });
  initalMessage();

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    main();
  });
  FirebaseMessaging.onMessage.listen((message) async{

    FlutterRingtonePlayer.playNotification();
    await NotificationService().showNotification(id: 1,
        title: '${message.notification!.title}',
        body: '${message.notification!.body}')
        .then((value) async {
      FlutterRingtonePlayer.playNotification();
    }).catchError((onError) {
      showTost("${onError.toString()}", Colors.red);
    });
  });
  FirebaseMessaging.onBackgroundMessage(backGroundMessage);
}