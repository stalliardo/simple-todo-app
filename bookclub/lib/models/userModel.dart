import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  String? uid;
  String? email;
  String? fullName;
  Timestamp? accountCreated;

  MyUser({
    this.uid,
    this.email,
    this.fullName,
    this.accountCreated,
  });
}
