import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class DatabaseServices
{
  final String uid;

  DatabaseServices({required this.uid});
  final CollectionReference userCollection =  FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection =  FirebaseFirestore.instance.collection("group");

  Future saveUserData(String fullName,String email)
  {
    return userCollection.doc(uid).set(
      {
        "fullName": fullName,
        "email": email,
        "groups": [],
        "profilePic": "",
        "uid": uid,
      }
    );
  }
  Future getUserData(String email) async{
    QuerySnapshot snapshot = await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

}