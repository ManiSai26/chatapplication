import 'package:chatapplication/helper/helper_function.dart';
import 'package:chatapplication/services/database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future loginWithUsernameAndPassword( String email, String password) async{
    try
    {
      User user = (await firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user!;
      return true;
    }on FirebaseAuthException catch (e)
    {
      print(e);

      return e.message;
    }

  }

  Future registerUserWithEmailandPassword(
      String fullName, String email, String password) async{
    try
        {
          User user = (await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user!;
          await DatabaseServices(uid: user.uid).saveUserData(fullName, email);
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
