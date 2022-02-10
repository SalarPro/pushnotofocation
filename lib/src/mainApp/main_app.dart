import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Container(
        child: ElevatedButton(
          child: Text("salar"),
          onPressed: () async {
            Map<String, dynamic> salar = {};
            salar["hello"] = 153;
            salar["salar"] = true;
            salar["pro"] = 1.5;

            FirebaseFirestore.instance
                .collection("messages")
                .doc("2aad3f70-72ef-11ec-9f53-27ae9b057fd6")
                .set({"name": 123});
          },
        ),
      )),
    );
  }
}
