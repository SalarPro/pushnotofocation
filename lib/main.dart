import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pushnotofocation/src/firebase_messageing/firebaseSignIn.dart';
import 'package:pushnotofocation/src/mainApp/main_app.dart';
import 'package:pushnotofocation/src/tolen_screens/toket_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => debugPrint('Fireabase Done'));
  
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Firebase

    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => TokenScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}