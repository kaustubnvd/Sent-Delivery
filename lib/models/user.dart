import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

/*
  Authors: Kaustub Navalady, Last Edit: 02/03/20 (Deserialization of User Data in firestore)
*/

class User {
  final String uid;
  final String displayName;
  final String username;
  final String phoneNumber;
  // final String photoUrl;

  User({
    @required this.uid,
    @required this.displayName,
    @required this.username,
    @required this.phoneNumber,
    // @required this.photoUrl,
  });

  // Deserialization of the document data
  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      uid: doc.data["uid"],
      displayName: doc.data["name"],
      username: doc.data["username"],
      phoneNumber: doc.data["phoneNumber"],
    );
  }

  // Returns current logged in user
  static Future<User> getCurrentUser() async  {
    final currentUser = await FirebaseAuth.instance.currentUser();
    final usersRef = Firestore.instance.collection("users");
    final user = await usersRef.document(currentUser.uid).get();
    return User.fromDocument(user);
  }
}
