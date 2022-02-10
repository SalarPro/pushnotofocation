import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class FireabaseSignInAuth {
  signInuserAnonymosly() async {
    FirebaseAuth _firebaseAuth = await FirebaseAuth.instance;

    _firebaseAuth.signInAnonymously();
    debugPrint("no signed in");

    String token = await FirebaseMessaging.instance.getToken() ?? "no user";

    if (token != "no user") {
      // Save the initial token to the database
      await saveTokenToDatabase(token);
      // Any time the token refreshes, store this in the database too.
      FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
    }

    String uid = _firebaseAuth.currentUser?.uid ?? "-------- NO_UID --------";
    debugPrint(uid);
  }

  saveToken() {}

  Future<void> saveTokenToDatabase(String token) async {
    // Assume user is logged in for this example
    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";

    if (userId != "") {
      await FirebaseFirestore.instance.collection('user').doc(userId).set({
        'tokens': FieldValue.arrayUnion([token]),
      });
    }
  }
}
