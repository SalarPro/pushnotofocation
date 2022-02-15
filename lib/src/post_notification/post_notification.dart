import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:pushnotofocation/src/custom_view/custome_view.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:http/http.dart' as http;

class PostNotificationScreen extends StatefulWidget {
  PostNotificationScreen({Key? key}) : super(key: key);

  static String roughtName = '/post_notification';

  @override
  State<PostNotificationScreen> createState() => _PostNotificationScreenState();
}

class _PostNotificationScreenState extends State<PostNotificationScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    var iniSetting =
        InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(iniSetting,
        onSelectNotification: (payload) {
      debugPrint("asdasadasasdasd");
    });
    _configureLocalTimeZone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: Text("Send notification to a specific token"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              controller: _titleController,
              decoration: CustomView.ganeralInputDecoration(labelText: "Title"),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'The message is required';
                } else
                  return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              controller: _bodyController,
              decoration: CustomView.ganeralInputDecoration(labelText: "Body"),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'The message is required';
                } else
                  return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
              controller: _dataController,
              decoration: CustomView.ganeralInputDecoration(labelText: "Data"),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'The message is required';
                } else
                  return null;
              },
            ),
          ),
          ElevatedButton(
              onPressed: () {
                sent_notification(
                    'dMUo0GHVRFSsGhBppHTAzm:APA91bEP_AHEtNSBFh6TxZHEymmKvTYaBkt3hpSApjiL4j-EgYZN_sFrldl6hLtxP1D5Yn3pk3815ocCyWvEUNuL58X1hc7-BHV81qTSjh9jcMJHSZ-vNrTwm6XzR0jdW_xF6WAWW5Vu',
                    _titleController.text,
                    _bodyController.text);
              },
              child: Text(
                'Send the notification',
              )),
          NotificationListener(
            onNotification: (notification) {
              setState(() {
                _titleController.text = "notification";
                debugPrint("asdasdasdasd");
              });

              return true;
            },
            child: Text("notidiii"),
          ),
          StreamBuilder<RemoteMessage>(
            stream: FirebaseMessaging.onMessage,
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                var datt = snapshot.data!;

                showNotify(datt.notification!.title!, datt.notification!.body!);
              }

              return Text("${snapshot.data?.data}");
            },
          )
        ],
      ),
    );
  }

  Future<void> sent_notification(
      String token, String title, String body) async {
    var apiKey =
        "AAAAhSiCEPU:APA91bHzLpeSydRniST7-sWL1FPI8kJCmoy75Y98N5DM8nrZt07U1rGVOmWdeZ03dN1KKASqDWzJK1OYrwW6qTehXAScAxRd_rNP0iSc3OrZTX7imzqtCWEwT7lzvDSZ_O_ottZTr-XZ";

    var url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    var response = await http.post(url,
        headers: {
          'authorization': 'key=${apiKey}',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'to': token,
          'notification': {'title': title, 'body': body},
          'data': {'code': 123},
        }));
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');
  }

  Future<void> _configureLocalTimeZone() async {
    // if (kIsWeb || Platform.isLinux) {
    //   return;
    // }
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
  }

  Future<void> showNotify(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('salar_id_1', 'Salar Pro',
            channelDescription: 'For tests',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics,
        payload: 'payload payload payload payload');
  }
}
