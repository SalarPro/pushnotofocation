import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotifyView extends StatefulWidget {
  LocalNotifyView({Key? key}) : super(key: key);

  @override
  State<LocalNotifyView> createState() => _LocalNotifyViewState();
}

class _LocalNotifyViewState extends State<LocalNotifyView> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  @override
  void initState() {
    super.initState();

    var iniSetting =
        InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(iniSetting,
        onSelectNotification: (payload) {
      debugPrint(payload ?? "");
    });
    _configureLocalTimeZone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                child: ElevatedButton(
                  child: Text("show notification"),
                  onPressed: () async {
                    showNotify();
                  },
                ),
              ),
              Container(
                child: ElevatedButton(
                  child: Text("show after 5 seconds"),
                  onPressed: () async {
                    _zonedScheduleNotification();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showNotify() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('salar_id_1', 'Salar Pro',
            channelDescription: 'For tests',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(0, 'Test Titlelee',
        'body body body body body body ', platformChannelSpecifics,
        payload: 'payload payload payload payload');
  }

  Future<void> _zonedScheduleNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'scheduled title',
        'scheduled body',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
          android: AndroidNotificationDetails('salar_id_1', 'Salar Pro',
              channelDescription: 'For tests',
              importance: Importance.max,
              priority: Priority.high,
              ticker: 'ticker'),
        ),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: "Back ground :)");
  }

  Future<void> _configureLocalTimeZone() async {
    // if (kIsWeb || Platform.isLinux) {
    //   return;
    // }
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
  }
}
