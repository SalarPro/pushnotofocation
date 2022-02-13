import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pushnotofocation/src/firebase_messageing/firebaseSignIn.dart';
import 'package:pushnotofocation/src/firebase_messageing/models.dart';

class TokenScreen extends StatefulWidget {
  TokenScreen({Key? key}) : super(key: key);

  @override
  State<TokenScreen> createState() => _TokenScreenState();
}

class _TokenScreenState extends State<TokenScreen> {
  @override
  void initState() {
    super.initState();
    FireabaseSignInAuth().signInuserAnonymosly();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text(
                  "Tokens",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("user").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: CircularProgressIndicator());
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    List<DocumentSnapshot> _docs = snapshot.data!.docs;

                    List<UserModel> _users = _docs
                        .map((e) =>
                            UserModel.fromMap(e.data() as Map<String, dynamic>))
                        .toList();

                    return ListView.builder(
                      itemCount: _users.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(8),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(_users[index].tokens?.first ?? ""),
                              )),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                FirebaseMessaging messaging = FirebaseMessaging.instance;

                NotificationSettings settings =
                    await messaging.requestPermission(
                  alert: true,
                  announcement: true,
                  badge: true,
                  carPlay: true,
                  criticalAlert: true,
                  provisional: true,
                  sound: true,
                );

                if (settings.authorizationStatus ==
                    AuthorizationStatus.authorized) {
                  print('User granted permission');
                } else if (settings.authorizationStatus ==
                    AuthorizationStatus.provisional) {
                  print('User granted provisional permission');
                } else {
                  print('User declined or has not accepted permission');
                }
              },
              child: Text("Send a notificatio"),
            ),
          ],
        ),
      ),
    );
  }
}
