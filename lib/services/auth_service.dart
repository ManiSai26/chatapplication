import 'package:chatapplication/helper/helper_function.dart';
import 'package:chatapplication/services/database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future registerUserWithEmailandPassword(
      String fullName, String email, String password) async{
    try
        {
          User user = (await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user!;
          await DatabaseServices(uid: user.uid).updateUserData(fullName, email);
          return true;
        }on FirebaseAuthException catch (e)
    {
      print(e);

      return e.message;
    }

  }

  Future signOut() async{
    try {
      await firebaseAuth.signOut();
      await HelperFunctions.saveLoggedInStatus(false);
      await HelperFunctions.saveUserNameSF("");
      await HelperFunctions.saveUserEmailSF("");
    }
    catch (e) {
      return null;
    }
  }



}
