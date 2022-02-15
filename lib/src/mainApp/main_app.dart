import 'package:flutter/material.dart';
import 'package:pushnotofocation/src/post_notification/post_notification.dart';

class MainView extends StatefulWidget {
  MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Container(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/notify");
                  },
                  child: Text("local notification")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/home");
                  },
                  child: Text("Anonymous user's token")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, PostNotificationScreen.roughtName);
                  },
                  child: Text("post notificaoitn")),
            ],
          ),
        ),
      )),
    );
  }
}
